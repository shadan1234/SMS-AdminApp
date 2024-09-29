// models/phoneNumber.js

const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const phoneNumberSchema = new Schema({
  phoneNumbers: [{
    type: String,
    required: true,
  }]
});

const PhoneNumber= mongoose.model('PhoneNumber',phoneNumberSchema);
module.exports=PhoneNumber;