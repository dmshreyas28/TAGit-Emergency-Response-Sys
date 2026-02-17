# TAGit Mobile App 📱

A Flutter-based emergency response mobile application that uses NFC technology to provide instant access to critical personal and medical information during emergencies.

![Flutter](https://img.shields.io/badge/Flutter-3.38.1-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.10.0-0175C2?logo=dart)
![Firebase](https://img.shields.io/badge/Firebase-5.x-FFCA28?logo=firebase)
![License](https://img.shields.io/badge/License-MIT-green)

## 📋 Overview

TAGit Mobile is the companion app for TAGit NFC tags. Users can create comprehensive emergency profiles, write them to NFC tags, and ensure first responders have immediate access to life-saving information when seconds count.

## ✨ Features

### 🔐 Authentication

- Email/password authentication via Firebase Auth
- Secure session management
- Password reset functionality

### 👤 Profile Management

- **Basic Information**: Name, date of birth, blood group (with autocomplete), photo
- **Medical Information**: Allergies, medications, medical conditions, organ donor status
- **Emergency Contacts**: Multiple contacts with relationship types and priority ordering
- **Documents**: Upload and store important medical documents (insurance cards, prescriptions)

### 📡 NFC Integration

- Write complete emergency profiles to NFC tags
- Read and verify tag contents
- Support for NDEF message formatting
- Tag encryption for data security

### 📍 Location Services

- Real-time GPS location tracking
- Location sharing during emergencies
- Permission handling for location access

### 🔔 Notifications

- Push notification support
- Emergency alerts
- Profile update reminders

### 🎨 User Experience

- Modern Material Design 3 interface
- Coral-themed color palette (#FF7643)
- Responsive layouts with flutter_screenutil
- Custom bottom navigation (Salomon style)
- Dark/Light theme support

## 🛠️ Tech Stack

### Core Framework

| Technology        | Version | Purpose                     |
| ----------------- | ------- | --------------------------- |
| Flutter           | 3.38.1  | Cross-platform UI framework |
| Dart              | 3.10.0  | Programming language        |
| Material Design 3 | -       | Design system               |

### Firebase Services

| Package          | Version | Purpose                 |
| ---------------- | ------- | ----------------------- |
| firebase_core    | 3.15.2  | Firebase initialization |
| firebase_auth    | 5.7.0   | User authentication     |
| cloud_firestore  | 5.6.12  | NoSQL database          |
| firebase_storage | 12.4.10 | File storage            |

### NFC & Hardware

| Package            | Version | Purpose                   |
| ------------------ | ------- | ------------------------- |
| nfc_manager        | 4.1.1   | NFC read/write operations |
| ndef               | 0.3.1   | NDEF message formatting   |
| nfc_manager_ndef   | 1.0.1   | NFC-NDEF bridge           |
| geolocator         | 11.1.0  | GPS location services     |
| permission_handler | 11.4.0  | Runtime permissions       |

### UI Components

| Package            | Version | Purpose            |
| ------------------ | ------- | ------------------ |
| flutter_screenutil | 5.9.3   | Responsive sizing  |
| flutter_svg        | 2.1.0   | SVG rendering      |
| google_fonts       | 6.2.1   | Typography         |
| salomon_bottom_bar | 3.3.2   | Custom navigation  |
| qr_flutter         | 4.1.0   | QR code generation |
| image_picker       | 1.1.2   | Photo selection    |
| file_picker        | 8.3.7   | Document selection |

### State Management & Storage

| Package            | Version | Purpose                 |
| ------------------ | ------- | ----------------------- |
| provider           | 6.1.5   | State management        |
| shared_preferences | 2.5.3   | Local key-value storage |
| sqflite            | 2.4.2   | Local SQLite database   |

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point with AuthWrapper
├── firebase_options.dart     # Firebase configuration
├── models/
│   └── user_model.dart       # User data model
├── screens/
│   ├── auth/                 # Login, signup, password reset
│   ├── home/                 # Home screen
│   ├── profile/              # Profile management
│   ├── nfc/                  # NFC read/write screens
│   ├── emergency/            # Emergency information
│   ├── emergency_contacts/   # Contact management
│   ├── documents/            # Document uploads
│   ├── dashboard/            # Main dashboard
│   ├── settings/             # App settings
│   ├── notifications/        # Notification center
│   ├── location/             # Location services
│   └── splash_screen.dart    # Splash/loading screen
├── services/
│   ├── auth_service.dart     # Authentication logic
│   ├── firebase_service.dart # Firestore operations
│   ├── nfc_service.dart      # NFC operations
│   └── location_service.dart # GPS services
├── utils/
│   ├── app_theme.dart        # Theme configuration
│   └── constants.dart        # App constants
└── widgets/
    └── (Reusable components)
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.5.0 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / VS Code
- Firebase project configured
- Physical device with NFC capability (for NFC features)

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/tagit_app.git
   cd tagit_app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Add Android/iOS apps to your Firebase project
   - Download and place configuration files:
     - Android: `android/app/google-services.json`
     - iOS: `ios/Runner/GoogleService-Info.plist`
   - Run FlutterFire CLI to generate `firebase_options.dart`

4. **Run the app**
   ```bash
   flutter run
   ```

### Building for Release

**Android APK:**

```bash
flutter build apk --release
```

**Android App Bundle:**

```bash
flutter build appbundle --release
```

**iOS:**

```bash
flutter build ios --release
```

## 📱 Supported Platforms

| Platform | Status          | Notes                               |
| -------- | --------------- | ----------------------------------- |
| Android  | ✅ Full Support | NFC requires Android 4.4+           |
| iOS      | ✅ Full Support | NFC requires iPhone 7+ with iOS 13+ |
| Web      | ⚠️ Limited      | No NFC support                      |
| Windows  | ⚠️ Limited      | No NFC support                      |
| macOS    | ⚠️ Limited      | No NFC support                      |
| Linux    | ⚠️ Limited      | No NFC support                      |

## 🔒 Security Features

- **Firebase Security Rules**: Role-based access control
- **Data Encryption**: Sensitive data encrypted at rest
- **Secure Authentication**: Firebase Auth with token validation
- **NFC Tag Security**: Optional encryption for tag data
- **Privacy Controls**: Users control what information is shared

## 🎨 Design System

### Color Palette

- **Primary**: Coral (#FF7643)
- **Primary Variant**: Deep Coral (#E85A2D)
- **Secondary**: Teal (#26A69A)
- **Background**: Light Grey (#F5F5F5)
- **Surface**: White (#FFFFFF)
- **Error**: Red (#F44336)

### Typography

- **Font Family**: Google Fonts (Poppins, Roboto)
- **Headings**: Bold weights for emphasis
- **Body**: Regular weights for readability

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

## 🔗 Related Projects

- [TAGit Website](../tagit_website) - Next.js web app for emergency profile display

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Your Name**

- GitHub: [@yourusername](https://github.com/yourusername)
- LinkedIn: [Your LinkedIn](https://linkedin.com/in/yourprofile)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- NFC Forum for NDEF specifications
- All open-source package maintainers

---

⭐ If you found this project helpful, please give it a star!
