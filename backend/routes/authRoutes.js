const express = require('express');
const { register, login, sendPhoneNumber } = require('../controllers/authController');

const router = express.Router();

// Define routes for registration and login
router.post('/register', register);
router.post('/login', login);
router.post('/phoneOTP', sendPhoneNumber);

module.exports = router;
