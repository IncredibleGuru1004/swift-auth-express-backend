require('dotenv').config();

const config = {
    port: process.env.PORT || 3000,
    secretKey: process.env.SECRET_KEY,
};

module.exports = config;
