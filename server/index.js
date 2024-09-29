const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const dotenv = require("dotenv");
const auth=require("./routes/auth");
const authRouter = require("./routes/auth");

// Load environment variables
dotenv.config();

const PORT = process.env.PORT || 3000; 
const dbUrl = process.env.DATABASE_URL;

// Ensure DATABASE_URL is loaded
if (!dbUrl) {
  throw new Error("DATABASE_URL is not defined in the environment variables.");
}

const app = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use(authRouter);


mongoose.connect(dbUrl, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => {
    console.log("Successfully connected to the database");
  })
  .catch((e) => {
    console.error("Database connection error:", e);
  });

// Start server
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server is running on port ${PORT}`);
});
