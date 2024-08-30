const users = [];

class User {
    constructor(username, email, password) {
        this.username = username;
        this.email = email;
        this.password = password;
    }
}

const addUser = (user) => {
    users.push(user);
};

const findUser = (email) => {
    return users.find(user => user.email === email);
};

module.exports = { User, addUser, findUser };
