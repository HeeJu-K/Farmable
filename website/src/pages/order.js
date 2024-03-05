import { useRouter } from 'next/router';
import React, { useState, useEffect } from 'react';
import Cookies from 'js-cookie';
import { PassThrough } from 'stream';


export default function Order() {

    // const router = useRouter();
    const selectedItems = Cookies.get('selectedItems');
    const parsedItems = selectedItems ? JSON.parse(selectedItems) : [];
    const [farmerFeedback, setFarmerFeedback] = useState('');
    const [restaurantFeedback, setRestaurantFeedback] = useState('');

    const url = 'http://10.19.179.108:8080/';


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
            const response = await fetch(url+'users/update', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ "email": "js@abc.com", "lastName":"Stevenson", "farmerFeedback": farmerFeedback }),
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
            const response = await fetch(url+'users/update', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ "email": "sm@abc.com","lastName":"Miller", "restaurantFeedback": restaurantFeedback }),
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
        <div>
            {parsedItems.map((parsedItem) => (
                <div>
                    <p>{parsedItem.dishName}</p>
                    {parsedItem?.ingredients?.map((ingredient) =>
                    (<div>
                        <span>{ingredient?.produce?.harvestTime}</span>
                        <span>{ingredient?.produce?.originFarm}</span>
                    </div>)

                    )}
                </div>


            ))}
            <form onSubmit={submitFarmerFeedback}>
                <textarea
                    value={farmerFeedback}
                    onChange={handleFarmerFeedbackChange}
                    placeholder="Write your feedback to farmers here..."
                    rows="4"
                    style={{ width: '100%', padding: '10px', marginBottom: '10px' }}
                />
                <button type="submit" style={{ padding: '10px 20px' }}>Send Feedback to Farmer</button>
            </form>
            <form onSubmit={submitRestaurantFeedback}>
                <textarea
                    value={restaurantFeedback}
                    onChange={handleRestaurantFeedbackChange}
                    placeholder="Write your feedback to restaurants here..."
                    rows="4"
                    style={{ width: '100%', padding: '10px', marginBottom: '10px' }}
                />
                <button type="submit" style={{ padding: '10px 20px' }}>Send Feedback to Restaurant</button>
            </form>
        </div>
    )
}
