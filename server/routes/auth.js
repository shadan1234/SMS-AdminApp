const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { User, AppConfig } = require('../models/user');
const authRouter = express.Router();

// Middleware for checking authentication
const auth = (req, res, next) => {
    try {
        const token = req.header('x-auth-token');
        if (!token) return res.status(401).json({ message: 'No authentication token, authorization denied.' });

        const verified = jwt.verify(token, process.env.JWT_SECRET);
        if (!verified) return res.status(401).json({ message: 'Token verification failed, authorization denied.' });

        req.user = verified;
        next();
    } catch (error) {
        res.status(500).json({ message: 'Internal server error.' });
    }
};

// Middleware for checking admin privileges
const adminAuth = (req, res, next) => {
    if (req.user.role !== 'admin') {
        return res.status(403).json({ message: 'Access denied. Admins only.' });
    }
    next();
};

// Middleware for checking if coordinators can access the app
const coordinatorAccess = async (req, res, next) => {
    const appConfig = await AppConfig.findOne({
        
    });
    if (!appConfig) {
        return res.status(500).json({ message: 'App configuration not found.' });
    }

    if (!appConfig.eventActive && req.user.role === 'coordinator') {
        return res.status(403).json({ message: 'Event is over. Coordinators cannot access the app.' });
    }

    next();
};

// Sign up user
authRouter.post('/api/signup', async (req, res) => {
    // console.log(req.body);
    try {
       
        const { name, password } = req.body;
       
        // Check if user already exists
        const existingUser = await User.findOne({ name });
        if (existingUser) {
            return res.status(400).json({ message: 'User already exists, try a different user name' });
        }

        // Hash password
        const hashedPassword = await bcrypt.hash(password, 10);

        // Create new user with default role 'coordinator'
        const user = new User({
            name,
            password: hashedPassword,
            role: 'coordinator', // default role
        });
          
        await user.save();
        //  console.log(user);
        res.status(201).json({ message: 'User registered successfully.' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error.' });
    }
});

// Sign in user
authRouter.post('/signin', async (req, res) => {
    console.log('bale');
    try { 
        const { name, password } = req.body;
         console.log(name);
        // Find user by name
        const user = await User.findOne({ name });
        if (!user) {
            return res.status(404).json({ message: 'User not found.' });
        }

        // Check password
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(401).json({ message: 'Invalid credentials.' });
        }

        // Check event status and restrict coordinator login if event is over
        const appConfig = await AppConfig.findOne({});
        if (!appConfig) {
            return res.status(500).json({ message: 'App configuration not found.' });
        } 

        if (!appConfig.eventActive && user.role === 'coordinator') {
            return res.status(403).json({ message: 'Event is over. Coordinators cannot log in.' });
        }
 
        // Generate JWT token
        const token = jwt.sign({ userId: user._id, role: user.role }, process.env.JWT_SECRET,

        );   

        res.json({ token,  id: user._id, name: user.name, role: user.role, password:user.password  });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: error.message });
    }
});

// Token validation
authRouter.post('/tokenIsValid', async (req, res) => {
    try {
        const token = req.header('x-auth-token');
        if (!token) return res.json(false);

        const verified = jwt.verify(token, process.env.JWT_SECRET);
        if (!verified) return res.json(false);

        const user = await User.findById(verified.userId);
        if (!user) return res.json(false);
         
        const appConfig = await AppConfig.findOne({});
        if (!appConfig) {
            return res.status(500).json({ message: 'App configuration not found.' });
        }

        if (!appConfig.eventActive && user.role === 'coordinator') {
            return res.json(false);
        }

        res.json(true);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error.' });
    }
});

// Get user data - Requires authentication and coordinator access check
authRouter.get('/', auth, coordinatorAccess, async (req, res) => {
    try {
        const user = await User.findById(req.user.userId);
        if (!user) return res.status(404).json({ message: 'User not found.' });

        res.json(user);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error.' });
    }
});

// Admin-only route example
authRouter.get('/admin', auth, adminAuth, async (req, res) => {
    // This route is only accessible to admin users
    res.json({ message: 'Welcome, admin!' });
});

module.exports = authRouter;
