import { useRouter } from 'next/router';
import React, { useState, useEffect } from 'react';
import Cookies from 'js-cookie';
import Image from 'next/image'
import { PassThrough } from 'stream';

import { URL } from '../lib/constants';

import styles from './order.module.css';

export default function Order() {

    // const router = useRouter();
    const cartItems = Cookies.get('cartItems');
    // const parsedItems = selectedItems ? JSON.parse(selectedItems) : [];
    const parsedItems = cartItems ? JSON.parse(cartItems) : [];

    const [farmerFeedback, setFarmerFeedback] = useState('');
    const [restaurantFeedback, setRestaurantFeedback] = useState('');

    // const url = 'http://10.18.98.85:8080/'; // school
    // // const url = 'http://10.19.179.108:8080/'; //home 


    const userList = Cookies.get('userList');

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
            <div style={{ height: "20px" }}></div>
            <span style={{margin:'auto', fontSize:'26px', fontWeight:'bold'}}>The Grange</span>
            <div style={{ height: "10px" }}></div>
            <Image src="/theGrangeLogo.png" width="50" height="50" alt="Example Image" style={{margin:'auto'}}/>
            <div style={{ height: "10px" }}></div>
            <span style={{margin:'auto', fontSize:'12px'}}>Duvall, Washington</span>
            <div style={{ height: "30px" }}></div>
            <div className={styles.divider} style={{padding:"3px 0"}}></div>

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
                <p className={styles.itemdescription}>Winter Lettuces</p>
                <p className={styles.itemdetails}>from <span style={{color:'green'}}>Sean's farm</span>, harvested 4 days ago</p>
                <div style={{ height: "3px" }}></div>
                <p className={styles.itemdescription}>Caesar Dressing</p>
                <div style={{ height: "3px" }}></div>
                <p className={styles.itemdescription}>Herb Crouton</p>
                <p className={styles.itemdetails}>from <span style={{color:'green'}}>Sarah's farm</span>, harvested 6 days ago</p>

                <p className={styles.itemheading}>CHICKEN WINGS</p>
                <p className={styles.itemheading}>SNO-VALLEY MUSHROOM GEMELLI</p>
                <p className={styles.itemdescription}>Butternut Squash</p>
                <p className={styles.itemdetails}>from <span style={{color:'green'}}>Sean's farm</span>, harvested 27 hours ago</p>
                <div style={{ height: "3px" }}></div>
                <p className={styles.itemdescription}>Kale and Leeks</p>
                <p className={styles.itemdetails}>from <span style={{color:'green'}}>Sarah's farm</span>, harvested 46 hours ago</p>
                <div style={{ height: "3px" }}></div>
                <p className={styles.itemdescription}>Herbs</p>
                <p className={styles.itemdetails}>from <span style={{color:'green'}}>Sarah's farm</span>, harvested 6 days ago</p>
                <div style={{ height: "3px" }}></div>
                <p className={styles.itemdescription}>Garlic</p>
                <p className={styles.itemdetails}>from <span style={{color:'green'}}>SixOne farm</span>, harvested 26 hours ago</p>
                <div style={{ height: "3px" }}></div>
                <p className={styles.itemdescription}>Sahllot</p>
                <p className={styles.itemdetails}>from <span style={{color:'green'}}>HeeJu&apos;s farm</span>, harvested 32 hours ago</p>


                <div className={styles.divider}></div>
                <p className={styles.averageheading}>In average,</p>
                <div style={{ height: "10px" }}></div>
                <p className={styles.averagedetail}>your meal came out from soil <span className={styles.trackable}>52.7 hours</span> ago</p>
                <p className={styles.averagedetail}>and traveled <span className={styles.trackable}>7.6 miles</span> to your table</p>
                <p className={styles.averagedetail}>an estimate of <span className={styles.trackable}>37g</span> CO2 is saved in comparison to a regular meal</p>
                <div style={{ height: "10px" }}></div>
            </div>
            <div className={styles.divider}></div>
            <span className={styles.formdescription}>If you liked your meal, please tell our farmers and restaurants something!</span>
            <div className={styles.heightspacer}></div>
            <form onSubmit={submitFarmerFeedback}>
                <textarea
                    value={farmerFeedback}
                    onChange={handleFarmerFeedbackChange}
                    placeholder="Write your feedback to farmers here..."
                    rows="4"
                    className={styles.textinput}
                />
                <button type="submit" className={styles.submitbutton}>Send Feedback to Farmer</button>
            </form>
            <div className={styles.heightspacer}></div>
            <form onSubmit={submitRestaurantFeedback}>
                <textarea
                    value={restaurantFeedback}
                    onChange={handleRestaurantFeedbackChange}
                    placeholder="Write your feedback to restaurants here..."
                    rows="4"
                    className={styles.textinput}
                />
                <button type="submit" className={styles.submitbutton}>Send Feedback to Restaurant</button>
            </form>
            <div style={{height:'80px'}}></div>
        </div>
    )
}
