import { URL } from '../../lib/constants';

export default function handler(req, res) {
  // This data could be fetched from a database in a real application
  const menuItems = [
    { id: 1, name: 'Pizza Margherita', price: 10 },
    { id: 2, name: 'Pasta Carbonara', price: 12 },
    // Add more items...
  ];

  res.status(200).json({ items: menuItems });
}

export async function fetchData(endpoint) {
  // Fetch data from an API or database
  const response = await fetch(URL + endpoint);
  const data = await response.json();
  return data;
}

export async function postData(endpoint, body, message) {
  try {
    const response = await fetch(URL + endpoint, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    });

    if (response.ok) {

      alert( message + 'submitted successfully!');
    } else {
      alert('Failed to submit '+message);
    }
  } catch (error) {
    console.error('Failed to submit feedback:', error);
    alert('Failed to submit '+message);
  }
}