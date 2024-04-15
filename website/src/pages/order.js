import { useRouter } from 'next/router';
import React, { useState, useEffect } from 'react';
import Cookies from 'js-cookie';
import Image from 'next/image'
import { PassThrough } from 'stream';

import { URL } from '../lib/constants';
import {fetchData, postData} from './api/menu';

import { FaHeart } from 'react-icons/fa';

import styles from './order.module.css';

export default function Order() {

    const [restaurantName, setRestaurantName] = useState("the Grange");

    // const router = useRouter();
    const cartItems = Cookies.get('cartItems');
    // const parsedItems = selectedItems ? JSON.parse(selectedItems) : [];
    const parsedItems = cartItems ? JSON.parse(cartItems) : [];

    const [farmerFeedback, setFarmerFeedback] = useState('');
    const [restaurantFeedback, setRestaurantFeedback] = useState('');

    // const url = 'http://10.18.98.85:8080/'; // school
    // // const url = 'http://10.19.179.108:8080/'; //home 


    const userList = Cookies.get('userList');

    const handleLikeButtonClick = (role) => {
        console.log("clicked like", role)
        var farmerBody = JSON.stringify({
            "senderEntity": "Stone Burner",
            "senderRole": "Customer",
            "receiverEntity": "SarahFarm",
            "receiverRole": "Farmer"
        })
        var restaurantBody = JSON.stringify({
            "senderEntity": "Stone Burner",
            "senderRole": "Customer",
            "receiverEntity": "SarahFarm",
            "receiverRole": "Farmer"
        })
        

        postData('like/add', role=='farmer'?farmerBody:restaurantBody, "like")
    }
    const handleFarmerFeedbackChange = (e) => {
        setFarmerFeedback(e.target.value);
    };

    const handleRestaurantFeedbackChange = (e) => {
        setRestaurantFeedback(e.target.value);
    };

    const submitFarmerFeedback = async (e) => {
        e.preventDefault();

        try {
            const response = await fetch(URL + 'users/update', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ "email": "js@abc.com", "lastName": "Stevenson", "farmerFeedback": farmerFeedback }),
            });

            if (response.ok) {

                alert('Feedback submitted successfully!');
            } else {
                alert('Failed to submit feedback');
            }
        } catch (error) {
            console.error('Failed to submit feedback:', error);
            alert('Failed to submit feedback');
        }
    };

    const submitRestaurantFeedback = async (e) => {
        e.preventDefault();

        try {
            const response = await fetch(URL + 'users/update', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ "email": "sm@abc.com", "lastName": "Miller", "restaurantFeedback": restaurantFeedback }),
            });

            if (response.ok) {

                alert('Feedback submitted successfully!');
            } else {
                alert('Failed to submit feedback');
            }
        } catch (error) {
            console.error('Failed to submit feedback:', error);
            alert('Failed to submit feedback');
        }
    };

    useEffect(() => {
        return () => {
            Cookies.remove('userList');
            Cookies.remove('selectedItems');
        };
    }, []);

    return (
        <div className={styles.ordercontainer}>
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
            <div className={styles.divider} style={{ padding: "15px 0" }}></div>

            {/* {parsedItems.map((parsedItem) => (
                <div>
                    <p>{parsedItem.dishName}</p>
                    {parsedItem?.ingredients?.map((ingredient) =>
                    (<div>
                        <span>{ingredient?.produce?.harvestTime}</span>
                        <span>{ingredient?.produce?.originFarm}</span>
                    </div>)

                    )}
                </div>
            ))} */}
            <div className={styles.ordersummary}>
                <p className={styles.summaryheading}>Here is a summary of what you've ordered!</p>
                <p className={styles.itemheading}>VALLEY CAESAR SALAD</p>
                
                <p className={styles.itemdescription}>Farm Radish</p>
                <div style={{ height: "3px" }}></div>
                <p className={styles.itemdescription}>Winter Greens</p>
                <p className={styles.itemdetails}>from <span style={{ color: 'green' }}>Sean's farm</span>, harvested 0 hours ago</p>
                <div style={{ height: "3px" }}></div>
                <p className={styles.itemdescription}>Chicken Tenders</p>
                <div style={{ height: "3px" }}></div>
                <p className={styles.itemdescription}>Pickled Onion</p>

                <p className={styles.itemheading}>PIZZA</p>
                <p className={styles.itemdescription}>inion marmellata</p>
                <div style={{ height: "3px" }}></div>
                <p className={styles.itemdescription}>flatbread</p>
                <div style={{ height: "3px" }}></div>
                <p className={styles.itemheading}>SAUTÉED KALE w/ BRATWURST</p>
                <p className={styles.itemdescription}>House-made Bratwurst</p>
                <div style={{ height: "3px" }}></div>
                <p className={styles.itemdescription}>Onion</p>
                <div style={{ height: "3px" }}></div>
                <p className={styles.itemdescription}>Mustard</p>
                <div style={{ height: "3px" }}></div>
                <p className={styles.itemdescription}>White Wine</p>
                <div style={{ height: "3px" }}></div>
                <p className={styles.itemdescription}>Cream</p>
                <div style={{ height: "3px" }}></div>
                <p className={styles.itemdescription}>Potato</p>
                <p className={styles.itemdetails}>from <span style={{ color: 'green' }}>Sean's farm</span>, harvested 9 days and 7 hours ago</p>
                <div style={{ height: "3px" }}></div>


                <div className={styles.divider}></div>
                <p className={styles.averageheading}>In average,</p>
                <div style={{ height: "10px" }}></div>
                <p className={styles.averagedetail}>your meal came out from soil <span className={styles.trackable}>4 days</span> and <span className={styles.trackable}>16 hours</span> ago</p>
                <p className={styles.averagedetail}>and traveled <span className={styles.trackable}>7.6 miles</span> to your table</p>
                {/* <p className={styles.averagedetail}>an estimate of <span className={styles.trackable}>37g</span> CO2 is saved in comparison to a regular meal</p> */}
                <div style={{ height: "10px" }}></div>
            </div>
            <div className={styles.divider}></div>
            <span className={styles.formdescription}>If you liked your meal, please tell our farmers and restaurants something!</span>
            <div className={styles.heightspacer}></div>
            <div className={styles.feedback}>
                <button className={styles.likebutton} onClick={() => handleLikeButtonClick('farmer')}><FaHeart size={12} /> Send like to Farmers</button>
                <form onSubmit={submitFarmerFeedback}>
                    <textarea
                        value={farmerFeedback}
                        onChange={handleFarmerFeedbackChange}
                        placeholder="Show love to farmers here!"
                        rows="4"
                        className={styles.textinput}
                    />
                    <button type="submit" className={styles.submitbutton}>Send Comment</button>
                </form>
                <div className={styles.heightspacer}></div>
                <button className={styles.likebutton} onClick={() => handleLikeButtonClick('restaurant')}><FaHeart size={12} /> Send like to Restaurants</button>
                <form onSubmit={submitRestaurantFeedback}>
                    <textarea
                        value={restaurantFeedback}
                        onChange={handleRestaurantFeedbackChange}
                        placeholder="Tell restaurants something here!"
                        rows="4"
                        className={styles.textinput}
                    />
                    <button type="submit" className={styles.submitbutton}>Send Comment</button>
                </form>
            </div>
            <div style={{ height: '80px' }}></div>
        </div>
    )
}
