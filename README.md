# EverLasting

[![Swift](https://img.shields.io/badge/Swift-5.0-orange)](https://swift.org)
[![Express](https://img.shields.io/badge/Express-4.17.1-green)](https://expressjs.com/)

## Introduction

This App is an authentication application built using Swift for the frontend and Express for the backend. The application supports several key features including user registration, login, password recovery via email OTP, and a home page for authenticated users.

## Features

- **User Registration:** Allows new users to create an account.
- **User Login:** Enables existing users to log in.
- **Forgot Password:** Users can reset their password if forgotten.
- **Email OTP:** One-time passwords are sent via email for verification.
- **Home Page:** Authenticated users can access their home page.

## Technologies Used

- **Frontend:** Swift
- **Backend:** Express.js
- **Database:** Specify your database (e.g., MongoDB, PostgreSQL, MySQL)
- **Email Service:** Specify the email service used for OTPs (e.g., SendGrid, NodeMailer)

## Getting Started

### Prerequisites

- Swift 5.x or newer
- Node.js 14.x or newer
- NPM 6.x or newer
- Any other tools or libraries that are prerequisites

### Installing

#### Backend Setup

1. Clone the repository:
    ```sh
    git clone https://github.com/IncredibleGuru1004/swift-auth-express-backend.git
    cd swift-auth-express-backend/backend
    ```

2. Install Node.js dependencies:
    ```sh
    npm install
    ```

3. Setup environment variables:
    Create a `.env` file and add your configuration settings.
    ```plaintext
    PORT=3000
    DB_URL=your_database_url
    EMAIL_SERVICE_API_KEY=your_email_service_api_key
    ```

4. Start the server:
    ```sh
    npm start
    ```

#### Frontend Setup

1. Navigate to the frontend folder:
    ```sh
    cd ../frontend
    ```

2. Open the Xcode project:
    ```sh
    open YourProject.xcodeproj
    ```

3. Configure any necessary environment settings or services in your Xcode project.

### Running the Application

1. Make sure both the backend and frontend setups are completed successfully.
2. Run the backend server using:
    ```sh
    npm start
    ```
3. Open your iOS simulator in Xcode and run the frontend application.

## Usage

1. **Registration:**
   - Users can sign up by providing their user information.
2. **Login:**
   - Registered users can log in using their credentials.
3. **Forgot Password:**
   - Users can request to reset their password through an email OTP for verification.
4. **Home Page:**
   - Authenticated users are redirected to the home page.

## Contributing

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/YourFeatureName`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/YourFeatureName`).
5. Open a pull request.

## License

This project is licensed under the [Your License] - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments

- Any libraries, inspirations, code snippets, etc., that you used.

---

## Contact

- Your Name - [email@example.com](mailto:email@example.com)
- Project Link: [https://github.com/yourusername/your-repo-name](https://github.com/yourusername/your-repo-name)
