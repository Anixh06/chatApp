# Chat App

A modern real-time chat application built with Flutter and Firebase, featuring user authentication, real-time messaging, and theme customization.

## Features

### 🔐 User Authentication
- **Sign Up & Sign In**: Secure user registration and authentication using Firebase Auth
- **Email/Password Authentication**: Simple and secure login system
- **User Session Management**: Automatic session handling and persistence

### 💬 Real-time Messaging
- **Instant Messaging**: Real-time chat using Firebase Firestore
- **User List**: View all registered users and start new conversations
- **Message Bubbles**: Clean, modern message interface with sender distinction
- **Chat History**: Persistent chat history stored in Firebase

### 🎨 Customization
- **Dark/Light Theme**: Toggle between light and dark mode themes
- **Settings Page**: Customize app preferences
- **Modern UI**: Material Design 3 with responsive layouts

### 🏗️ Architecture
- **Service Layer**: Organized services for authentication and chat functionality
- **Component-based**: Reusable UI components
- **State Management**: Provider pattern for theme management
- **Clean Architecture**: Separation of concerns with proper file organization

## Screenshots

### Light Mode

<img src="https://github.com/user-attachments/assets/44540f5e-aa50-49ae-b43b-d7d621f73832" width="24%">
<img src="https://github.com/user-attachments/assets/7af400b2-0e7e-412a-9390-b8f6f4548aee" width="24%">
<img src="https://github.com/user-attachments/assets/856b6ee9-12ee-41d3-9a68-c12e3a2b315b" width="24%">
<img src="https://github.com/user-attachments/assets/69d363c4-bc9b-43a9-a600-cde5bb94afb5" width="24%">

## Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase
  - **Authentication**: Firebase Auth
  - **Database**: Cloud Firestore
  - **Real-time Updates**: Firestore snapshots
- **State Management**: Provider
- **UI Framework**: Material Design 3

## Prerequisites

Before running this project, make sure you have:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.10.4 or higher)
- [Dart SDK](https://dart.dev/get-dart) (3.0.0 or higher)
- [Firebase CLI](https://firebase.google.com/docs/cli) (optional, for Firebase management)
- A Firebase project set up with:
  - Authentication enabled (Email/Password)
  - Cloud Firestore database

## Setup Instructions

### 1. Clone the Repository
```bash
git clone <your-repo-url>
cd chat_app
