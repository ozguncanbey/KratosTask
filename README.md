# Kratos 3D Task

## Overview

Kratos 3D Task is a mobile application created with Swift UIkit using Firebase Authentication and Firestore. The app consists of four screens: a launch screen, a login screen, a create user screen, and a home screen. The app is designed to provide a simple and secure user authentication experience.

## Features

- **Firebase Authentication**: Secure user authentication using Firebase.
- **Firestore Integration**: User data is stored and retrieved from Firestore.
- **User-Friendly Interface**: Intuitive and easy-to-use interface.

## Screens

1. **Launch Screen**:
    - A splash screen with a GIF that displays for 5 seconds before transitioning to the login screen.  
    <img src="https://github.com/ozguncanbey/KratosTask/assets/138692325/ac4778b6-da87-4fd1-a99e-24e6e61011c0" width="300"/>

2. **Login Screen**:
    - Allows users to log in using their email and password.  
    - Option to navigate to the Create User screen if the user doesn't have an account.  
    <img src="https://github.com/ozguncanbey/KratosTask/assets/138692325/7de9f6d3-f2ef-47e8-935d-e9b8b4f322f3" width="300"/>

3. **Create User Screen**:
    - Allows users to create a new account by providing their email, password, first name, and last name.  
    - User data is stored in Firestore upon successful account creation.  
    <img src="https://github.com/ozguncanbey/KratosTask/assets/138692325/a4e695ea-3e61-4a30-b27b-f8c2d73cd8b6" width="300"/>

4. **Home Screen**:
    - Displays the first name and last name of the logged-in user at the center of the screen.  
    - Includes a logout button to sign out the user and return to the login screen.  
    <img src="https://github.com/ozguncanbey/KratosTask/assets/138692325/e727dd32-a0f4-4160-9d0a-dc7f77c16d56" width="300"/>

## Technologies Used

- **Firebase Authentication**: Used for handling user sign-in and sign-up processes.
- **Firestore**: Used to store user information such as first name and last name.
- **UIKit**: The user interface is built using UIKit components.
- **Swift**: The app is developed in Swift programming language.

## Setup Instructions

1. Clone the repository.
2. Open the project in Xcode.
3. Ensure you have CocoaPods installed. If not, install it using the following command:
   ```sh
   sudo gem install cocoapods
   ```
4. Navigate to the project directory and install the required pods:
   ```sh
   cd KratosTask
   pod install
   ```
5. Open the `.xcworkspace` file in Xcode.
6. Configure Firebase in your project:
   - Add your `GoogleService-Info.plist` file to the project.
   - Ensure you have set up Firebase Authentication and Firestore in your Firebase console.
7. Build and run the project on your preferred simulator or device.

## Usage

1. **Launch the App**:
    - The app will display the launch screen with a GIF for 5 seconds.

2. **Login**:
    - Enter your email and password to log in.
    - If you don't have an account, click "Create One" to navigate to the Create User screen.

3. **Create User**:
    - Enter your email, password, first name, and last name to create a new account.
    - Upon successful account creation, you will be redirected to the Home Screen.

4. **Home Screen**:
    - Your first name and last name will be displayed in the center of the screen.
    - Click the "Log Out" button to sign out and return to the login screen.

## Contributing

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Make your changes and commit them with clear and concise messages.
4. Push your changes to your fork.
5. Create a pull request to the main repository.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---
