const express = require('express');
const bodyParser = require('body-parser');
const config = require('./config/config');
const authRoutes = require('./routes/authRoutes');

const app = express();

app.use(bodyParser.json());

// Use the auth routes
app.use('/auth', authRoutes);

const port = config.port;
app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
