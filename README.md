# 🏷️ TAGit - Emergency Response with NFC

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white" alt="Next.js"/>
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase"/>
  <img src="https://img.shields.io/badge/TypeScript-3178C6?style=for-the-badge&logo=typescript&logoColor=white" alt="TypeScript"/>
  <img src="https://img.shields.io/badge/Tailwind_CSS-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white" alt="Tailwind"/>
</p>

<p align="center">
  <strong>A life-saving NFC-based emergency response system that provides instant access to critical medical information when every second counts.</strong>
</p>

---

## 📖 Overview

**TAGit** is a full-stack emergency response platform that enables individuals to store vital medical and emergency contact information on NFC (Near Field Communication) tags. When scanned by first responders, medical professionals, or Good Samaritans, the tag instantly displays the person's critical health data—potentially saving lives in emergency situations.

### 🎯 The Problem We Solve

In emergency situations, victims are often unable to communicate critical information:

- Medical conditions (diabetes, epilepsy, heart conditions)
- Severe allergies (medications, food, insects)
- Current medications
- Blood type
- Emergency contacts

**TAGit bridges this communication gap** by making this information instantly accessible through a simple NFC tap.

---

## ✨ Key Features

### 📱 Mobile Application (Flutter)

| Feature                      | Description                                                              |
| ---------------------------- | ------------------------------------------------------------------------ |
| **🔐 Secure Authentication** | Email/password authentication with Firebase Auth                         |
| **👤 Profile Management**    | Complete medical profile with personal details, blood group, age, gender |
| **🏥 Medical Information**   | Store conditions, allergies, current medications                         |
| **📞 Emergency Contacts**    | Multiple emergency contacts with relationships                           |
| **📄 Document Storage**      | Upload and manage medical documents (prescriptions, reports, insurance)  |
| **📱 NFC Tag Writing**       | Write your emergency profile URL to any NFC tag                          |
| **📖 NFC Tag Reading**       | Read and view other TAGit profiles                                       |
| **📍 Location Services**     | Share real-time location in emergencies                                  |
| **🔔 Notifications**         | Stay updated with important alerts                                       |
| **🌐 Offline Support**       | Access your data even without internet                                   |
| **⚙️ Settings**              | Customize app preferences                                                |

### 🌐 Web Dashboard (Next.js)

| Feature                      | Description                                       |
| ---------------------------- | ------------------------------------------------- |
| **🖥️ User Dashboard**        | Manage your complete profile from any browser     |
| **👁️ Public Emergency View** | Clean, fast-loading page when NFC tag is scanned  |
| **📝 Profile Editor**        | Edit basic info, medical data, emergency contacts |
| **📤 Document Upload**       | Upload medical documents from desktop             |
| **🔒 Secure Access**         | Authentication required for profile management    |
| **📱 Responsive Design**     | Works on all devices and screen sizes             |

---

## 🛠️ Tech Stack

### Mobile App (Flutter)

```
📱 Framework & Language
├── Flutter 3.x (Cross-platform UI framework)
├── Dart SDK ^3.5.0
└── Material Design 3

🔥 Backend & Database
├── Firebase Core
├── Firebase Authentication
├── Cloud Firestore (NoSQL Database)
└── Firebase Storage (File Storage)

📡 Device Integration
├── nfc_manager - NFC read/write operations
├── ndef - NFC Data Exchange Format
├── geolocator - GPS & location services
├── permission_handler - Runtime permissions
└── connectivity_plus - Network monitoring

🎨 UI & Design
├── flutter_screenutil - Responsive design
├── flutter_svg - SVG rendering
├── google_fonts - Custom typography
├── salomon_bottom_bar - Navigation bar
└── qr_flutter - QR code generation

💾 Local Storage
├── shared_preferences - Key-value storage
└── sqflite - SQLite database

🔧 Utilities
├── provider - State management
├── image_picker - Camera/gallery access
├── file_picker - Document selection
├── url_launcher - External links
├── intl - Internationalization
└── uuid - Unique ID generation
```

### Website (Next.js)

```
🌐 Framework & Language
├── Next.js 14 (App Router)
├── React 18
└── TypeScript 5.4

🔥 Backend
└── Firebase JS SDK 10.12

🎨 Styling
├── Tailwind CSS 3.4
├── PostCSS
└── Autoprefixer

🧩 UI Components
├── Lucide React - Icon library
└── React Hot Toast - Notifications

🔧 Development
├── ESLint
├── TypeScript strict mode
└── Next.js optimizations
```

---

## 📁 Project Structure

```
TAGit Project/
│
├── 📱 tagit_app/                    # Flutter Mobile Application
│   ├── lib/
│   │   ├── main.dart                # App entry point
│   │   ├── firebase_options.dart    # Firebase configuration
│   │   │
│   │   ├── models/                  # Data models
│   │   │   ├── user_model.dart      # User profile model
│   │   │   └── nfc_data_model.dart  # NFC payload model
│   │   │
│   │   ├── services/                # Business logic
│   │   │   ├── auth_service.dart    # Authentication
│   │   │   ├── firestore_service.dart
│   │   │   ├── nfc_service.dart     # NFC operations
│   │   │   ├── location_service.dart
│   │   │   ├── storage_service.dart
│   │   │   ├── connectivity_service.dart
│   │   │   └── local_storage_service.dart
│   │   │
│   │   ├── screens/                 # UI Screens
│   │   │   ├── auth/                # Login, Signup
│   │   │   ├── main/                # Main navigation
│   │   │   ├── home/                # Home screen
│   │   │   ├── profile/             # Profile management
│   │   │   ├── nfc/                 # NFC read/write
│   │   │   ├── emergency/           # Emergency features
│   │   │   ├── emergency_contacts/  # Contact management
│   │   │   ├── documents/           # Medical documents
│   │   │   ├── settings/            # App settings
│   │   │   └── notifications/       # Notifications
│   │   │
│   │   ├── widgets/                 # Reusable components
│   │   │   ├── autocomplete_dropdown.dart
│   │   │   ├── confirm_dialog.dart
│   │   │   └── loading_dialog.dart
│   │   │
│   │   └── utils/                   # Utilities
│   │       ├── app_theme.dart       # Theme configuration
│   │       ├── snackbar_helper.dart
│   │       └── offline_indicator.dart
│   │
│   ├── android/                     # Android native code
│   ├── ios/                         # iOS native code
│   └── pubspec.yaml                 # Dependencies
│
└── 🌐 tagit_website/                # Next.js Web Application
    ├── src/
    │   ├── app/                     # App Router pages
    │   │   ├── page.tsx             # Landing page
    │   │   ├── layout.tsx           # Root layout
    │   │   ├── globals.css          # Global styles
    │   │   ├── login/               # Login page
    │   │   ├── signup/              # Signup page
    │   │   ├── dashboard/           # User dashboard
    │   │   ├── nfc/                 # NFC management
    │   │   └── user/
    │   │       └── [userId]/        # Public emergency profile
    │   │
    │   ├── components/              # React components
    │   │   ├── BasicInfoEditor.tsx
    │   │   ├── MedicalInfoEditor.tsx
    │   │   ├── EmergencyContactsEditor.tsx
    │   │   └── DocumentUpload.tsx
    │   │
    │   ├── contexts/
    │   │   └── AuthContext.tsx      # Auth state management
    │   │
    │   ├── lib/
    │   │   └── firebase/            # Firebase configuration
    │   │
    │   └── types/
    │       └── index.ts             # TypeScript types
    │
    ├── tailwind.config.ts           # Tailwind configuration
    ├── next.config.mjs              # Next.js configuration
    └── package.json                 # Dependencies
```

---

## 🔄 How It Works

### For Users

```
1️⃣ SETUP
   Download App → Create Account → Fill Medical Profile → Add Emergency Contacts

2️⃣ WRITE TAG
   Get NFC Tag → Open App → Tap "Write to NFC" → Hold phone to tag → Done!

3️⃣ WEAR/CARRY
   Attach tag to: Wristband, Keychain, Wallet, Medical bracelet, Phone case
```

### In An Emergency

```
📱 RESPONDER SCANS TAG
         ↓
🌐 OPENS WEB PAGE (No app needed!)
         ↓
👤 SEES: Name, Photo, Blood Type
         ↓
🏥 SEES: Medical Conditions, Allergies, Medications
         ↓
📞 SEES: Emergency Contacts (tap to call)
         ↓
💊 CAN ACCESS: Medical Documents
```

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** (3.x or higher)
- **Node.js** (18.x or higher)
- **Firebase Project** with Authentication, Firestore, and Storage enabled
- **Android Studio** / **Xcode** (for mobile development)
- **NFC-enabled smartphone** (for testing NFC features)

### Mobile App Setup

```bash
# Navigate to app directory
cd tagit_app

# Install dependencies
flutter pub get

# Configure Firebase
# Add your google-services.json (Android) and GoogleService-Info.plist (iOS)

# Run the app
flutter run
```

### Website Setup

```bash
# Navigate to website directory
cd tagit_website

# Install dependencies
npm install

# Create .env.local with Firebase config
NEXT_PUBLIC_FIREBASE_API_KEY=your_api_key
NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN=your_auth_domain
NEXT_PUBLIC_FIREBASE_PROJECT_ID=your_project_id
NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET=your_storage_bucket
NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID=your_sender_id
NEXT_PUBLIC_FIREBASE_APP_ID=your_app_id

# Run development server
npm run dev
```

---

## 📊 Database Schema

### Firestore Collections

```
users/
└── {userId}/
    ├── uid: string
    ├── email: string
    ├── name: string
    ├── phone: string
    ├── age: number
    ├── gender: string
    ├── bloodGroup: string
    ├── address: string
    ├── medicalConditions: string
    ├── allergies: string
    ├── medications: string
    ├── emergencyContacts: [
    │   {
    │     name: string,
    │     phone: string,
    │     relationship: string
    │   }
    │ ]
    ├── createdAt: timestamp
    └── updatedAt: timestamp

users/{userId}/medicalDocuments/
└── {docId}/
    ├── id: string
    ├── name: string
    ├── type: string (prescription|report|insurance|other)
    ├── url: string
    ├── fileSizeBytes: number
    └── uploadedAt: timestamp
```

---

## 🔒 Security Features

- **🔐 Firebase Authentication** - Secure user accounts
- **🛡️ Firestore Security Rules** - Data access control
- **🔑 Storage Security Rules** - Protected file uploads
- **📱 Local Encryption** - Sensitive data protection
- **🌐 HTTPS Only** - Encrypted data transmission
- **👤 Owner-only Access** - Users can only modify their own data

---

## 🎨 Design Principles

- **⚡ Speed First** - Emergency pages load in under 2 seconds
- **📱 Mobile First** - Optimized for on-the-go access
- **♿ Accessibility** - High contrast, large touch targets
- **🌍 Universal** - Works without app installation (web view)
- **🔋 Offline Ready** - Critical data cached locally

---

## 🗺️ Roadmap

- [x] Core user authentication
- [x] Profile management
- [x] NFC tag read/write
- [x] Emergency contacts
- [x] Medical document storage
- [x] Web dashboard
- [x] Public emergency view
- [ ] Multi-language support
- [ ] Apple Watch / Wear OS companion
- [ ] Emergency services integration
- [ ] Voice-activated emergency mode
- [ ] Medical professional verification
- [ ] Insurance integration

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Shreyas DM**

- GitHub: [@dmshreyas28](https://github.com/dmshreyas28)

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase team for the robust backend services
- Next.js team for the powerful web framework
- All contributors and supporters of this project

---

<p align="center">
  <strong>⭐ Star this repo if TAGit could save a life! ⭐</strong>
</p>

<p align="center">
  Made with ❤️ for emergency preparedness
</p>
