// pages/menu.js

import React, { useState, useEffect, useRef } from 'react';

import { useRouter } from 'next/router';
import Cookies from 'js-cookie';

import { fetchData } from './api/menu';

import styles from './menu.module.css';
import { FaPlus, FaMinus } from 'react-icons/fa';

export async function getServerSideProps(context) {
  const menuItems = await fetchData("restaurant/menu");

  const produceList = await fetchData("restaurant/grocery");

  const userList = await fetchData("users");

  const menuItemsWithProduceInfo = menuItems.map(dish => {
    const ingredients = dish.description.split(',').map(ingredient => ingredient.trim());
    const ingredientsWithDetails = ingredients.map(ingredient => ({
      name: ingredient,
      produce: produceList.find(produce => produce.groceryName.toLowerCase() === ingredient.toLowerCase()) || null
    }));

    return { ...dish, ingredients: ingredientsWithDetails };
  });

  console.log("SEE MENU WITH DETAILS", menuItemsWithProduceInfo)

  return {
    props: { menuItems, produceList, menuItemsWithProduceInfo, userList },
  };
}

function Modal({ isOpen, onClose, content }) {
  if (!isOpen) {
    return null;
  }

  return (
    <div className="modal-backdrop" onClick={onClose}>
      <div className="modal-content" onClick={e => e.stopPropagation()}>
        {content}
        <button onClick={onClose}>Close</button>
      </div>

      <style jsx>{`
        .modal-backdrop {
          position: fixed;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          background-color: rgba(0, 0, 0, 0.5);
          display: flex;
          justify-content: center;
          align-items: center;
          z-index: 1000;
        }
        .modal-content {
          background: white;
          padding: 20px;
          border-radius: 4px;
          max-width: 500px;
          max-height: 80%;
          overflow-y: auto;
        }
      `}</style>
    </div>
  );
}

export default function Menu({ menuItems, produceList, menuItemsWithProduceInfo, userList }) {

  const router = useRouter();

  const [selectedItems, setSelectedItems] = useState([]);

  const [activeProduce, setActiveProduce] = useState();
  const [isModalOpen, setIsModalOpen] = useState(false);

  Cookies.set('userList', JSON.stringify(userList));

  console.log("see", menuItemsWithProduceInfo)

  const menuByType = menuItemsWithProduceInfo.reduce((acc, item) => {
    acc[item.menuType] = acc[item.menuType] || [];
    acc[item.menuType].push(item);
    return acc;
  }, {})

  console.log("menuByType", menuByType)

  const handleSelectItem = (event, selectedItem) => {
    event.stopPropagation();
    setSelectedItems((prevItems) => {
      const isAlreadySelected = prevItems.some(item => item.id === selectedItem.id);

      if (isAlreadySelected) {
        return prevItems.filter(item => item.id !== selectedItem.id);
      } else {
        return [...prevItems, selectedItem];
      }
    });
  };

  const [cartItems, setCartItems] = useState(new Map());

  const addToCart = (product) => {
    setCartItems(prevItems => {
      const updatedItems = new Map(prevItems);
      if (updatedItems.has(product.id)) {
        const item = updatedItems.get(product.id);
        updatedItems.set(product.id, { ...item, quantity: item.quantity + 1 });
      } else {
        updatedItems.set(product.id, { ...product, quantity: 1 });
      }
      return updatedItems;
    });
  };

  const removeFromCart = (productId) => {
    setCartItems(prevItems => {
      const updatedItems = new Map(prevItems);
      if (updatedItems.has(productId)) {
        const item = updatedItems.get(productId);
        if (item.quantity > 0) {
          updatedItems.set(productId, { ...item, quantity: item.quantity - 1 });
        }
      }
      return updatedItems;
    });
  };
  const handleAddItem = (item) => {
    setCartItems(prevItems => {
      const updatedItems = new Map(prevItems);
      const existingItem = updatedItems.get(item.id);
      updatedItems.set(item.id, { ...item, quantity: (existingItem ? existingItem.quantity + 1 : 1) });
      return updatedItems;
    });
  };

  const handleRemoveItem = (item) => {
    setSelectedItems(selectedItems.map(item => {
      if (item.id === id && item.count > 0) {
        return { ...item, count: item.count - 1 };
      }
      return item;
    }));
  };

  const showItemDetails = (selectedProduce) => {
    setActiveProduce(selectedProduce);
    setIsModalOpen(true);
  };

  const closeModal = () => {
    setIsModalOpen(false);
    setActiveProduce(null);
  };

  const submitOrder = () => {
    Cookies.set('selectedItems', JSON.stringify(selectedItems));

    router.push({
      pathname: '/order',
    });
  }

  return (
    <div className={styles.container}>
      <nav className={styles.navbar}>
        <div className={styles.tabsContainer}>
          <ul className={styles.tabs}>
            {Object.entries(menuByType).map(([type, items]) => (
              <li>{type}</li>
            ))}
          </ul>
        </div>
      </nav>
      {Object.entries(menuByType).map(([type, items]) => (
        <div key={type}>
          <div className={styles.menutype}>{type}</div>
          <div class={styles.divider}></div>
          {items.map(item => {
            const cartItem = cartItems.get(item.id);
            const quantity = cartItem ? cartItem.quantity : 0;
            return (
              <div key={item.id} className={styles.itemcontainer}>
                <div className={styles.iteminfo} >
                  <div className={`${styles.dishname} ${styles.left}`}>{item.dishName}</div>
                  <div className={`${styles.dishprice} ${styles.right}`}>${item.price}</div>
                </div>
                <div className={styles.description}>
                  {item.ingredients.map((ingredient) => {
                    if (ingredient.produce) {
                      return (<span onClick={() => showItemDetails(ingredient)} style={{ color: 'green' }}>{ingredient.name}, </span>)
                    } else {
                      return (<span>{ingredient.name}, </span>)
                    }
                  }
                  )}
                </div>
                <div className={styles.right}>
                  {quantity ?
                    <div className={styles.right}>
                      <button className={styles.iconButton} onClick={() => removeFromCart(item.id)}>
                        <FaMinus />
                      </button>
                      {quantity}
                      <button className={styles.iconButton} onClick={() => addToCart(item)}>
                        <FaPlus />
                      </button>
                    </div>
                    :
                    <button className={styles.addButton} onClick={() => addToCart(item)}>Add</button>
                  }

                </div>
                <div class={styles.divider}></div>
              </div>
            );
          })}
        </div>
      ))
      }
      <div>
        <h3>Cart Items</h3>
        {[...cartItems.values()].map(item => (
          <div key={item.id} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '10px' }}>
            <div>
              <div>{item.dishName}</div>
              <div>{item.price}</div>
              <div>Quantity: {item.quantity}</div>
            </div>
            <button onClick={() => removeFromCart(item.id)}>Remove from Cart</button>
          </div>
        ))}
      </div>
      <button className={styles.addButton} onClick={() => submitOrder()}>Place Order</button>

      <Modal isOpen={isModalOpen} onClose={closeModal} content={(
        <div>
          <p>{activeProduce?.produce?.originFarm}</p>
          <p>Harvest Time: {activeProduce?.produce?.harvestTime}</p>
          <p>About the Farm: {userList[0].teamDescription}</p>
        </div>
      )} />

    </div >
  );
}
