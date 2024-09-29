const mongoose = require("mongoose");
const { use } = require("../routes/auth");


const userSchema = mongoose.Schema({
  name: {
    required: true,
    type: String, // mongoose understand string not js
    trim: true,
  },
 
  password: {
    required: true,
    type: String,
    trim:true,
    validate: {
        validator: (value) => {
         
          return value.length>6;
        },
        message: "Please enter a valid password",
      },
  },
 
  role: {
    type: String,
    default: "coordinator",
  },
});
const appConfigSchema = new mongoose.Schema({
  eventActive: {
      type: Boolean,
      required: true,
      default: true // Default value can be set to true or false based on your requirement
  }
  // Add more fields if needed
});

// Create the AppConfig model
const AppConfig = mongoose.model('AppConfig', appConfigSchema);


const User=mongoose.model('User',userSchema);
// Creates a model
module.exports={User,AppConfig};    