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

### Dark Mode
<img src="https://github.com/user-attachments/assets/7cfe396e-8825-46db-bcdd-3d09c74ce434" width="24%">
<img src="https://github.com/user-attachments/assets/12efa399-89a4-4103-af57-f6e39c529c20" width="24%">
<img src="https://github.com/user-attachments/assets/8a736d08-aa70-4504-b4da-e39eb022d754" width="24%">
<img src="https://github.com/user-attachments/assets/1c788fbe-d1fb-4eca-be32-27c42cf0ef74" width="24%">

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
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Firebase Setup

#### Create a Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project"
3. Follow the setup wizard

#### Configure Firebase for Your App

**For Android:**
1. Download `google-services.json` from Firebase Console
2. Place it in `android/app/`

**For iOS:**
1. Download `GoogleService-Info.plist` from Firebase Console
2. Place it in `ios/Runner/`

**For Web:**
1. Download `firebase-messaging-sw.js` if needed
2. Update Firebase configuration in `web/index.html`

#### Enable Authentication
1. In Firebase Console, go to Authentication > Sign-in method
2. Enable "Email/Password" provider

#### Setup Firestore Database
1. In Firebase Console, go to Firestore Database
2. Create database in test mode (or production with proper rules)
3. Start in test mode for development

### 4. Run the App

#### For Development
```bash
# Run on connected device/simulator
flutter run

# Run in debug mode
flutter run --debug

# Run with hot reload
flutter run --hot
```

#### For Production Build
```bash
# Android APK
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## Project Structure

```
lib/
├── components/           # Reusable UI components
│   ├── chat_input.dart     # Message input component
│   ├── message_bubble.dart # Message bubble widget
│   ├── my_button.dart      # Custom button component
│   ├── my_drawer.dart      # Navigation drawer
│   ├── my_textfield.dart   # Custom text field
│   └── user_tile.dart      # User list item
├── models/              # Data models
│   └── message.dart        # Message model
├── pages/               # App screens
│   ├── chat_page.dart      # Individual chat screen
│   ├── home_page.dart      # Main user list screen
│   ├── login_page.dart     # Login screen
│   ├── register_page.dart  # Registration screen
│   └── settings_page.dart  # Settings screen
├── services/            # Business logic & API calls
│   ├── auth/              # Authentication services
│   │   ├── auth_gate.dart    # Authentication gate
│   │   ├── auth_service.dart # Auth business logic
│   │   └── login_or_register.dart # Auth UI controller
│   ├── chat/              # Chat services
│   │   └── chat_service.dart  # Chat business logic
│   └── theme_provider.dart # Theme management
├── themes/              # Theme definitions
│   ├── dark_mode.dart      # Dark theme
│   └── light_mode.dart     # Light theme
├── firebase_options.dart # Firebase configuration
└── main.dart            # App entry point
```

## Key Features Explained

### User Authentication Flow
1. **Registration**: Users create accounts with email/password
2. **Login**: Existing users sign in with credentials
3. **Session Management**: Firebase maintains user sessions
4. **User Data**: User information stored in Firestore Users collection

### Real-time Messaging
1. **User List**: Home page shows all registered users
2. **Start Chat**: Click on any user to begin conversation
3. **Message Sending**: Real-time message delivery via Firestore
4. **Chat Rooms**: Unique chat rooms created for each conversation pair

### Theme System
1. **Provider Pattern**: Theme changes managed by ThemeProvider
2. **Light/Dark Modes**: Complete theme switching capability
3. **Persistent Settings**: Theme preference saved locally

## Firebase Collections

### Users Collection
```javascript
{
  "uid": "user_id",
  "email": "user@example.com"
}
```

### Chat Rooms Collection
```
chat_rooms/
├── {chatRoomID}/
│   └── messages/
│       ├── {messageId}: {
│           "senderID": "user_id",
│           "senderEmail": "user@example.com",
│           "receiverID": "other_user_id",
│           "content": "Hello!",
│           "timestamp": Timestamp
│       }
```

## Development Notes

### Code Organization
- **Services**: Business logic separated from UI
- **Components**: Reusable UI elements
- **Models**: Data structures and conversion
- **Themes**: Consistent styling across app

### State Management
- **Provider**: Used for theme management
- **StreamBuilder**: Real-time data from Firebase
- **FutureBuilder**: Async operations

### Best Practices
- Error handling with try-catch blocks
- Loading states for better UX
- Responsive design principles
- Clean architecture patterns

## Troubleshooting

### Common Issues

**Firebase Connection Errors:**
- Verify `google-services.json` or `GoogleService-Info.plist` is in correct location
- Check Firebase project configuration
- Ensure Authentication and Firestore are enabled

**Build Errors:**
- Run `flutter clean && flutter pub get`
- Check Flutter and Dart SDK versions
- Verify all dependencies are compatible

**Authentication Issues:**
- Confirm Email/Password provider is enabled in Firebase
- Check Firebase project settings
- Verify package names match Firebase configuration

### Debug Mode
```bash
# Enable Flutter debug mode
flutter run --debug

# Check Firebase connection
flutter logs
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support, please open an issue in the GitHub repository or contact the development team.

---

**Built with ❤️ using Flutter and Firebase**

