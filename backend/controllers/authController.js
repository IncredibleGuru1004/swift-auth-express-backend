const { User, addUser, findUser } = require('../models/userModel.js');

const register = (req, res) => {
    const { username, email, password } = req.body;
    if (!username || !email || !password) {
        return res.status(400).json({ message: 'All fields are required' });
    }

    const existingUser = findUser(username);
    if (existingUser) {
        return res.status(409).json({ message: 'User already exists' });
    }
    console.log("============Regiter Successfully=================")

    const newUser = new User(username, email, password);
    addUser(newUser);
    return res.status(201).json({ message: 'User registered successfully' });
};

const login = (req, res) => {
    const { email, password } = req.body;
    if (!email || !password) {
        return res.status(400).json({ message: 'All fields are required' });
    }

    const user = findUser(email);
    if (!user || user.password !== password) {
        return res.status(401).json({ message: 'Invalid username or password' });
    }

    console.log("============Login Successfully=================")
    console.log(JSON.stringify(user))

    return res.status(200).json({ message: 'Logged in successfully' });
};

module.exports = { register, login };
