// pages/menu.js

import React, { useState, useEffect, useRef } from 'react';

import { useRouter } from 'next/router';
import Cookies from 'js-cookie';

import { fetchData } from './api/menu';

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
    <div>
      {Object.entries(menuByType).map(([type, items]) => (
        <div key={type}>
          <h2>{type}</h2>
          {items.map((item) => (
            <div key={item.id} >
              <button type="button" onClick={(event) => handleSelectItem(event, item)}>{selectedItems.includes(item) ? 'selected' : 'select'}</button>
              <div>{item.dishName} - ${item.price}</div>
              {item.ingredients.map((ingredient) => {
                if (ingredient.produce) {
                  return (<span onClick={() => showItemDetails( ingredient)} style={{ color: 'green' }}>{ingredient.name}, </span>)
                } else {
                  return (<span>{ingredient.name}, </span>)
                }
              }
              )}
            </div>
          ))}
        </div>
      ))}
      <button onClick={() => submitOrder()}>Place Order</button>

      <Modal isOpen={isModalOpen} onClose={closeModal} content={(
        <div>
          <p>{activeProduce?.produce?.originFarm}</p>
          <p>Harvest Time: {activeProduce?.produce?.harvestTime}</p>
          <p>About the Farm: {userList[0].teamDescription}</p>
        </div>
      )} />

    </div>
  );
}
