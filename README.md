# TAGit Website 🌐(new website branch is for testing changes in website)

A Next.js web application that serves as the companion platform for TAGit NFC tags. When an NFC tag is scanned, it redirects to this website displaying the user's emergency information to first responders.

![Next.js](https://img.shields.io/badge/Next.js-14.2.33-000000?logo=next.js)
![React](https://img.shields.io/badge/React-18.3.1-61DAFB?logo=react)
![TypeScript](https://img.shields.io/badge/TypeScript-5.4.0-3178C6?logo=typescript)
![Tailwind CSS](https://img.shields.io/badge/Tailwind-3.4.18-06B6D4?logo=tailwindcss)
![License](https://img.shields.io/badge/License-MIT-green)

## 📋 Overview

TAGit Website is the public-facing platform that displays emergency information when NFC tags are scanned. First responders can access critical medical data, emergency contacts, and documents without needing any app installation—just a web browser.

## ✨ Features

### 🚨 Emergency Profile Display

- Instant access via NFC tag scan
- Public profile pages at `/user/[userId]`
- No login required for viewing emergency info
- Mobile-optimized responsive design

### 🔐 User Dashboard

- Secure login/signup with Firebase Auth
- Profile editing interface
- Emergency contact management
- Document upload and management
- NFC tag management

### 📱 NFC Integration

- Web NFC API support for compatible browsers
- Tag writing directly from web interface
- Tag verification and testing

### 🎨 Modern UI/UX

- Clean, professional design
- Tailwind CSS styling
- Responsive layouts for all devices
- Toast notifications for feedback
- Lucide icons for visual consistency

## 🛠️ Tech Stack

### Core Framework

| Technology | Version | Purpose                      |
| ---------- | ------- | ---------------------------- |
| Next.js    | 14.2.33 | React framework with SSR/SSG |
| React      | 18.3.1  | UI component library         |
| TypeScript | 5.4.0   | Type-safe JavaScript         |

### Styling

| Package      | Version | Purpose             |
| ------------ | ------- | ------------------- |
| Tailwind CSS | 3.4.18  | Utility-first CSS   |
| PostCSS      | 8.4.38  | CSS processing      |
| Autoprefixer | 10.4.19 | CSS vendor prefixes |

### Firebase

| Package  | Version | Purpose                  |
| -------- | ------- | ------------------------ |
| Firebase | 10.14.1 | Auth, Firestore, Storage |

### UI Components

| Package         | Version | Purpose             |
| --------------- | ------- | ------------------- |
| lucide-react    | 0.468.0 | Icon library        |
| react-hot-toast | 2.5.2   | Toast notifications |

## 📁 Project Structure

```
src/
├── app/
│   ├── globals.css           # Global styles & Tailwind imports
│   ├── layout.tsx            # Root layout with providers
│   ├── page.tsx              # Landing page
│   ├── dashboard/
│   │   └── page.tsx          # User dashboard
│   ├── login/
│   │   └── page.tsx          # Login page
│   ├── signup/
│   │   └── page.tsx          # Registration page
│   ├── nfc/
│   │   └── page.tsx          # NFC management page
│   └── user/
│       └── [userId]/
│           └── page.tsx      # Public emergency profile
├── components/
│   ├── BasicInfoEditor.tsx   # Profile editing
│   ├── DocumentUpload.tsx    # Document management
│   ├── EmergencyContactsEditor.tsx
│   └── MedicalInfoEditor.tsx
├── contexts/
│   └── AuthContext.tsx       # Authentication state
├── lib/
│   └── firebase/
│       ├── config.ts         # Firebase configuration
│       └── firebase.ts       # Firebase initialization
└── types/
    └── index.ts              # TypeScript interfaces
```

## 🚀 Getting Started

### Prerequisites

- Node.js 18.0 or higher
- npm or yarn
- Firebase project configured

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/tagit_website.git
   cd tagit_website
   ```

2. **Install dependencies**

   ```bash
   npm install
   ```

3. **Configure Environment Variables**

   Create a `.env.local` file in the root directory:

   ```env
   NEXT_PUBLIC_FIREBASE_API_KEY=your_api_key
   NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN=your_project.firebaseapp.com
   NEXT_PUBLIC_FIREBASE_PROJECT_ID=your_project_id
   NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET=your_project.appspot.com
   NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID=your_sender_id
   NEXT_PUBLIC_FIREBASE_APP_ID=your_app_id
   ```

4. **Run development server**

   ```bash
   npm run dev
   ```

5. **Open in browser**

   Navigate to [http://localhost:3000](http://localhost:3000)

### Building for Production

```bash
# Build the application
npm run build

# Start production server
npm start
```

### Deployment

**Vercel (Recommended):**

```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel
```

**Firebase Hosting:**

```bash
# Install Firebase CLI
npm i -g firebase-tools

# Login and deploy
firebase login
firebase deploy --only hosting
```

## 🔗 Routes

| Route            | Access    | Description               |
| ---------------- | --------- | ------------------------- |
| `/`              | Public    | Landing page              |
| `/login`         | Public    | User login                |
| `/signup`        | Public    | User registration         |
| `/dashboard`     | Protected | User dashboard            |
| `/nfc`           | Protected | NFC tag management        |
| `/user/[userId]` | Public    | Emergency profile display |

## 🗄️ Database Schema

### Users Collection (`/users/{userId}`)

```typescript
interface UserProfile {
  uid: string;
  email: string;
  createdAt: Timestamp;
  updatedAt: Timestamp;
  basicInfo: {
    firstName: string;
    lastName: string;
    dateOfBirth: string;
    bloodGroup: string;
    photoURL?: string;
  };
  medicalInfo: {
    allergies: string[];
    medications: string[];
    conditions: string[];
    organDonor: boolean;
    notes?: string;
  };
  emergencyContacts: Array<{
    id: string;
    name: string;
    phone: string;
    relationship: string;
    priority: number;
  }>;
  documents: Array<{
    id: string;
    name: string;
    url: string;
    type: string;
    uploadedAt: Timestamp;
  }>;
}
```

## 🔒 Security

### Firebase Security Rules

- Users can only read/write their own profiles
- Public profile endpoint allows read-only access to emergency info
- Document uploads restricted to authenticated users
- Storage rules prevent unauthorized file access

### Authentication

- Email/password authentication
- Session persistence
- Protected routes with AuthContext

## 🎨 Design System

### Colors

- **Primary**: Blue (#3B82F6)
- **Secondary**: Emerald (#10B981)
- **Danger**: Red (#EF4444)
- **Background**: Gray (#F9FAFB)
- **Text**: Dark Gray (#111827)

### Typography

- **Font**: System font stack (Inter, SF Pro, etc.)
- **Responsive**: Scales appropriately on all devices

## 🧪 Development

### Scripts

```bash
# Development server
npm run dev

# Production build
npm run build

# Start production server
npm start

# Lint code
npm run lint
```

### Code Style

- ESLint for code linting
- Prettier for formatting
- TypeScript strict mode enabled

## 🔗 Related Projects

- [TAGit Mobile App](../tagit_app) - Flutter companion app for NFC tag programming

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Your Name**

- GitHub: [@yourusername](https://github.com/yourusername)
- LinkedIn: [Your LinkedIn](https://linkedin.com/in/yourprofile)

## 🙏 Acknowledgments

- Vercel for Next.js framework
- Firebase for backend services
- Tailwind CSS team
- All open-source contributors

---

⭐ If you found this project helpful, please give it a star!
