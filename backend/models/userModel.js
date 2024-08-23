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

const findUser = (username) => {
    return users.find(user => user.username === username);
};

module.exports = { User, addUser, findUser };
