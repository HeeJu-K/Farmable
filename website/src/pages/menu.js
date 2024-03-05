// pages/menu.js

import React, { useState, useEffect } from 'react';

import { useRouter } from 'next/router';
import Cookies from 'js-cookie';

import { fetchMenuData } from './api/menu';

export async function getServerSideProps(context) {
  const menuItems = await fetchMenuData();
  return {
    props: { menuItems },
  };
}

export default function Menu({ menuItems }) {
  const router = useRouter();
  //   const [menuItems, setMenuItems] = useState([]);
  const [selectedItems, setSelectedItems] = useState([]);


  const menuByType = menuItems.reduce((acc, item) => {
    acc[item.menuType] = acc[item.menuType] || [];
    acc[item.menuType].push(item);
    return acc;
  }, {})

  const handleSelectItem = (selectedItem) => {
    setSelectedItems((prevItems) => {
      const isAlreadySelected = prevItems.some(item => item.id === selectedItem.id);

      if (isAlreadySelected) {
        return prevItems.filter(item => item.id !== selectedItem.id);
      } else {
        console.log(" see", prevItems, selectedItem)
        return [...prevItems, selectedItem];
      }
    });
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
            <div key={item.id} onClick={() => handleSelectItem(item)} style={{ cursor: 'pointer', background: selectedItems.includes(item) ? 'lightgray' : 'transparent' }}>
              <p>{item.dishName} - ${item.price}</p>
              <p>{item.description}</p>
            </div>
          ))}
        </div>
      ))}
      <button onClick={submitOrder}>Place Order</button>
    </div>
  );
}
