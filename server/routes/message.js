
const express = require('express');
const MessageRouter = express.Router();
const Message = require('../models/message');

// POST: Save a new message
MessageRouter.post('/messages', async (req, res) => {
  try {
    const { message, name } = req.body;

    const newMessage = new Message({
      message,
      name,
      timestamp: new Date(),
    });

    await newMessage.save();

    res.status(200).json({ success: true, message: 'Message saved successfully.' });
  } catch (err) {
    console.error('Error saving message:', err);
    res.status(500).json({ success: false, message: 'Failed to save message.' });
  }
});

MessageRouter.get('/messages', async (req, res) => {
    try {
      const messages = await Message.find().sort({ timestamp: -1 }); // Sort by latest messages first
      res.status(200).json({ success: true, messages });
    } catch (err) {
      console.error('Error fetching messages:', err);
      res.status(500).json({ success: false, message: 'Failed to fetch messages.' });
    }
  });

module.exports = MessageRouter;
