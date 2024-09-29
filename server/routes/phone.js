// routes/phoneNumber.js

const express = require('express');
const PhoneRouter = express.Router();
const PhoneNumber = require('../models/phoneNumber');

// GET: Fetch all phone numbers
PhoneRouter.get('/phone-numbers', async (req, res) => {
  try {
    const phoneNumberDoc = await PhoneNumber.findOne(); // Assuming there's only one document containing all phone numbers
    if (!phoneNumberDoc) {
      return res.status(404).json({ success: false, message: 'No phone numbers found.' });
    }
    res.status(200).json({ success: true, phoneNumbers: phoneNumberDoc.phoneNumbers });
  } catch (err) {
    console.error('Error fetching phone numbers:', err);
    res.status(500).json({ success: false, message: 'Failed to fetch phone numbers.' });
  }
});

module.exports = PhoneRouter;
