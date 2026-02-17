# TAGit Website – Tech Stack

This document describes the technology stack and tooling for the TAGit web app (Next.js).

## Overview
- Framework: Next.js 14 (App Router)
- Language: TypeScript + React 18
- Styling: Tailwind CSS
- Auth & Data: Firebase client SDK (Auth, Firestore, Storage)

## Node, Scripts & Tooling
- Node: LTS recommended (v18+)
- Package manager: npm
- Scripts (from `package.json`):
  - `dev` – Start dev server
  - `build` – Build production bundle
  - `start` – Start production server
  - `lint` – Lint project

## Key Dependencies
- `next` (^14.2.0)
- `react` (^18.3.0) and `react-dom` (^18.3.0)
- `firebase` (^10.12.0)
- `tailwindcss` (^3.4.0), `postcss` (^8.4.0), `autoprefixer` (^10.4.0)
- `lucide-react` (^0.378.0) – icon set
- `react-hot-toast` (^2.4.1) – toast notifications

## TypeScript & Config
- TypeScript config: `tsconfig.json` (strict-ish defaults)
- Next config: `next.config.mjs`
- Tailwind config: `tailwind.config.ts`
- PostCSS config: `postcss.config.js`

## Project Structure
- `src/app/` – App Router pages (e.g., `login/`, `signup/`, `dashboard/`, `nfc/`, `user/[userId]/`)
- `src/components/` – Reusable UI editors (BasicInfo, MedicalInfo, EmergencyContacts, DocumentUpload)
- `src/contexts/AuthContext.tsx` – Auth provider and hooks
- `src/lib/firebase/` – Firebase initialization (`config.ts`, `firebase.ts`)
- `src/types/` – Shared TypeScript types

## Firebase
- Client SDKs used: Auth, Firestore, Storage
- Local emulators optional via `firebase.json` (see repo root files `firestore.rules`, `storage.rules`)
- Environment variables (expected at build/runtime):
  - NEXT_PUBLIC_FIREBASE_API_KEY
  - NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN
  - NEXT_PUBLIC_FIREBASE_PROJECT_ID
  - NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET
  - NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID
  - NEXT_PUBLIC_FIREBASE_APP_ID

## Styling
- Tailwind CSS with global resets in `src/app/globals.css`
- Dark mode strategy can be added later (class strategy)

## Development & Run
- Dev server runs on port 3000 by default; if taken, it chooses the next free port (observed: 3001)
- Build: `npm run build`; Start: `npm start`

## Notes
- Ensure Firebase rules are deployed/configured as per `FIREBASE_RULES_SETUP.md`.
- The web app complements the mobile app for admin/management workflows.

See the mobile app stack in `../tagit_app/TECH_STACK.md` for Flutter.
