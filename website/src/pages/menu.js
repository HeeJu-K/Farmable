// pages/menu.js

import React, { useState, useEffect, useRef } from 'react';

import { useRouter } from 'next/router';
import getConfig from 'next/config';
import Cookies from 'js-cookie';

import { fetchData } from './api/menu';

import styles from './menu.module.css';
import { FaShoppingCart, FaPlus, FaMinus } from 'react-icons/fa';

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
    <div className={styles.modalback} onClick={onClose}>
      
      <div className={styles.modalcontent} onClick={e => e.stopPropagation()}>
      <button className={styles.addButton} style={{marginLeft:'auto'}} onClick={onClose}>x</button>
        {content}
        
      </div>
    </div>
  );
}

function Cart({ isOpen, onClose, content, isPressed }) {
  return (
    <div className={styles.cartback} onClick={onClose}>
      <div className={styles.cartcontent} onClick={e => e.stopPropagation()}>
        {/* {content} */}
        <FaShoppingCart color="green" />
        <button className={styles.addButton} onClick={onClose}>Close</button>
      </div>
    </div>
  );
}

export default function Menu({ menuItems, produceList, menuItemsWithProduceInfo, userList }) {

  const router = useRouter();

  const { publicRuntimeConfig } = getConfig();
  const [restaurantName, setRestaurantName] = useState("the Grange");

  const [selectedItems, setSelectedItems] = useState([]);

  const [activeProduce, setActiveProduce] = useState();
  const [isDetailsModalOpen, setIsDetailsModalOpen] = useState(false);
  const [isCartModalOpen, setIsCartModalOpen] = useState(false);

  const currentTime = new Date().getTime();

  const getTimedifference = (harvestTime) => {
    const currentTime = new Date().getTime();
    const timeDifference = currentTime - harvestTime;
    const millisecondsInHour = 1000 * 60 * 60;
    const millisecondsInDay = millisecondsInHour * 24;

    // Calculate the time difference in days and hours
    const daysDifference = Math.floor(timeDifference / millisecondsInDay);
    const hoursDifference = Math.floor((timeDifference % millisecondsInDay) / millisecondsInHour);
    return daysDifference.toString() + " days and " + hoursDifference.toString() + " hours ago"
  }

  Cookies.set('userList', JSON.stringify(userList));

  console.log("see", menuItemsWithProduceInfo)

  const menuByType = menuItemsWithProduceInfo.reduce((acc, item) => {
    acc[item.menuType] = acc[item.menuType] || [];
    acc[item.menuType].push(item);
    return acc;
  }, {})

  console.log("menuByType", menuByType)

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

  const showItemDetails = (selectedProduce) => {
    setActiveProduce(selectedProduce);
    setIsDetailsModalOpen(true);
  };

  const closeDetailsModal = () => {
    setIsDetailsModalOpen(false);
    setActiveProduce(null);
  };

  const showCartItems = () => {
    setIsCartModalOpen(true);
  };

  const closeCartModal = () => {
    setIsCartModalOpen(false);
  };

  const submitOrder = () => {
    console.log("submited order", cartItems)
    Cookies.set('selectedItems', JSON.stringify(cartItems));

    router.push({
      pathname: '/order',
    });
  }

  return (
    <div className={styles.container}>
      <div className={styles.restaurant}>
        <div className={styles.restaurantTitle} style={{ fontFamily: "Courier, Courier New, monospace" }}>{restaurantName}</div>
        <img
          src="/theGrangeLogo.png"
          alt="restaurant logo"
          style={{ width: '75px', height: '75px' }}
        />
        <div className={styles.restaurantDescription} style={{ fontFamily: "Courier, Courier New, monospace" }}>Farm-To-Table Restaurant <br /> &  <br /> General Store in Duvall</div>
        <div className={styles.restaurantDescription} style={{ fontSize: "10px" }}>15611 Main St NE, Duvall, WA 98019</div>
      </div>
      <nav className={styles.navbar}>
        <div className={styles.tabsContainer}>
          <ul className={styles.tabs}>
            {Object.entries(menuByType).map(([type, items]) => (
              <li>{type}</li>
            ))}
          </ul>
        </div>
      </nav>
      <div>
        {Object.entries(menuByType).map(([type, items]) => (
          <div key={type}>
            <div className={styles.menutype}>{type}</div>
            <div className={styles.divider}></div>
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
                        <button className={styles.addButton} onClick={() => removeFromCart(item.id)}>
                          <FaMinus />
                        </button>
                        {quantity}
                        <button className={styles.addButton} onClick={() => addToCart(item)}>
                          <FaPlus />
                        </button>
                      </div>
                      :
                      <button className={styles.addButton} onClick={() => addToCart(item)}>Add</button>
                    }

                  </div>
                  <div className={styles.divider}></div>
                </div>
              );
            })}
          </div>
        ))}
      </div>

      <Modal isOpen={isCartModalOpen} onClose={closeCartModal}
        content={(
          <div>
            <h3>Cart Items</h3>
            
            {[...cartItems.values()].map(item => (
              <div key={item.id} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '10px' }}>
                <div>
                  <div>{item.dishName}</div>
                  <div>${item.price}</div>
                  <div>Quantity: {item.quantity}</div>
                </div>
                {/* <button onClick={() => removeFromCart(item.id)}>Remove from Cart</button> */}
              </div>
            ))}
            <button className={styles.addButton} onClick={() => submitOrder()}>Place Order</button>
          </div>)}
      />
      <button className={styles.addButton} onClick={() => submitOrder()}>Place Order</button>
      <div className={styles.cartbutton} onClick={() => showCartItems()}>
        <div className={styles.carticon}>
          <FaShoppingCart color="#36A63A" />
        </div>
      </div>
      <Modal isOpen={isDetailsModalOpen} onClose={closeDetailsModal} content={(
        <div>
          <p className={styles.modalTitle}>{activeProduce?.produce?.originFarm}</p>
          <p>Harvest Time: {getTimedifference(activeProduce?.produce?.harvestTime)}</p>
          <p>About the Farm: {userList[0].teamDescription}</p>
        </div>
      )} />

    </div >
  );
}
