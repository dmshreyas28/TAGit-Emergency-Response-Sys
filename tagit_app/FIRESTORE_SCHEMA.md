# TAGit – Firestore Database Schema

This document describes the Firebase Firestore database structure for the TAGit emergency response application.

## Overview

The database is organized around user profiles that store personal, medical, and emergency contact information. The schema is designed to support NFC tag writing, offline access, and emergency responder queries.

## Collections

### 1. `users` (Primary Collection)

**Document Path:** `/users/{uid}`

Main user profile document containing all personal and medical information.

**Fields:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `uid` | string | Yes | Firebase Auth user ID (redundant but convenient) |
| `email` | string | Yes | User's email address |
| `name` | string | Yes | Full name |
| `phone` | string | Yes | Primary contact number |
| `age` | number | No | User's age |
| `gender` | string | No | Gender identity |
| `bloodGroup` | string | No | Blood type (A+, A-, B+, B-, AB+, AB-, O+, O-) |
| `address` | string | No | Residential address |
| `medicalConditions` | string | No | Known medical conditions (comma/pipe separated or narrative) |
| `allergies` | string | No | Known allergies |
| `medications` | string | No | Current medications |
| `emergencyContacts` | array | No | Array of emergency contact objects (see below) |
| `createdAt` | timestamp | Yes | Account creation timestamp |
| `updatedAt` | timestamp | Yes | Last profile update timestamp |
| `profileVersion` | number | No | Schema version for migration tracking |
| `lastNfcSyncAt` | timestamp | No | Last time NFC tag was written |
| `docCount` | number | No | Cached count of medical documents |

**Emergency Contact Object Structure:**
```json
{
  "name": "string",
  "phone": "string",
  "relationship": "string"
}
```

**Example Document:**
```json
{
  "uid": "abc123def456",
  "email": "john.doe@example.com",
  "name": "John Doe",
  "phone": "+1234567890",
  "age": 35,
  "gender": "Male",
  "bloodGroup": "O+",
  "address": "123 Main St, City, State",
  "medicalConditions": "Type 2 Diabetes, Hypertension",
  "allergies": "Penicillin, Peanuts",
  "medications": "Metformin 500mg, Lisinopril 10mg",
  "emergencyContacts": [
    {
      "name": "Jane Doe",
      "phone": "+1234567891",
      "relationship": "Spouse"
    },
    {
      "name": "Dr. Smith",
      "phone": "+1234567892",
      "relationship": "Primary Care Physician"
    }
  ],
  "createdAt": "2025-01-15T10:30:00Z",
  "updatedAt": "2025-11-19T14:22:00Z",
  "profileVersion": 1,
  "lastNfcSyncAt": "2025-11-18T09:15:00Z",
  "docCount": 5
}
```

---

### 2. `users/{uid}/medicalDocuments` (Subcollection)

**Document Path:** `/users/{uid}/medicalDocuments/{docId}`

Stores metadata for uploaded medical documents (prescriptions, reports, insurance cards, etc.). Actual files stored in Firebase Storage.

**Fields:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | string | Yes | Document ID (matches Firestore doc ID) |
| `name` | string | Yes | File name |
| `type` | string | Yes | Document category: `prescription`, `report`, `insurance`, `other` |
| `url` | string | Yes | Firebase Storage download URL |
| `thumbnailUrl` | string | No | Thumbnail image URL (for PDFs/images) |
| `fileSizeBytes` | number | Yes | File size in bytes |
| `uploadedAt` | timestamp | Yes | Upload timestamp |
| `extension` | string | No | File extension (e.g., PDF, JPG) |
| `hash` | string | No | File integrity hash (MD5/SHA256) |
| `tags` | array | No | Searchable tags (e.g., `["cardiology", "2025"]`) |
| `visibility` | string | No | Access level: `private`, `shared`, `emergency` |

**Example Document:**
```json
{
  "id": "doc789xyz",
  "name": "Blood_Test_Results_Nov2025.pdf",
  "type": "report",
  "url": "https://firebasestorage.googleapis.com/.../Blood_Test_Results_Nov2025.pdf",
  "thumbnailUrl": "https://firebasestorage.googleapis.com/.../thumb_Blood_Test.jpg",
  "fileSizeBytes": 245760,
  "uploadedAt": "2025-11-10T15:45:00Z",
  "extension": "PDF",
  "hash": "a3c5e7f9...",
  "tags": ["lab", "2025", "routine"],
  "visibility": "private"
}
```

---

### 3. `users/{uid}/emergencyContacts` (Optional Subcollection)

**Document Path:** `/users/{uid}/emergencyContacts/{contactId}`

Alternative to embedded array. Use this structure if you need per-contact updates, real-time listeners, or >10 contacts.

**Fields:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | Yes | Contact's full name |
| `phone` | string | Yes | Contact phone number |
| `relationship` | string | Yes | Relationship to user |
| `addedAt` | timestamp | Yes | When contact was added |
| `priority` | number | No | Priority order (1 = highest) |

**Example Document:**
```json
{
  "name": "Jane Doe",
  "phone": "+1234567891",
  "relationship": "Spouse",
  "addedAt": "2025-01-15T10:35:00Z",
  "priority": 1
}
```

---

### 4. `nfcPayloads` (Optional Historical Collection)

**Document Path:** `/nfcPayloads/{payloadId}`

Stores snapshots of data written to NFC tags for audit, versioning, and debugging.

**Fields:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `userId` | string | Yes | User ID this payload belongs to |
| `snapshotJson` | string | Yes | Exact JSON written to NFC tag |
| `generatedAt` | timestamp | Yes | Generation timestamp |
| `schemaVersion` | number | Yes | NFC data schema version |
| `contactCount` | number | Yes | Number of emergency contacts included |
| `includedFields` | array | Yes | List of fields written (e.g., `["bloodGroup", "allergies"]`) |
| `checksum` | string | No | Integrity checksum |

**Example Document:**
```json
{
  "userId": "abc123def456",
  "snapshotJson": "{\"userId\":\"abc123...\",\"userName\":\"John Doe\",...}",
  "generatedAt": "2025-11-18T09:15:00Z",
  "schemaVersion": 1,
  "contactCount": 2,
  "includedFields": ["bloodGroup", "allergies", "medications", "emergencyContacts"],
  "checksum": "b7d3f1e..."
}
```

---

### 5. `publicEmergencyProfiles/{uid}` (Optional)

**Document Path:** `/publicEmergencyProfiles/{uid}`

Minimal public-readable profile for emergency responders. Contains only life-critical information.

**Fields:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `userName` | string | Yes | User's name |
| `userPhone` | string | Yes | Primary contact |
| `bloodGroup` | string | No | Blood type |
| `allergies` | string | No | Known allergies |
| `medications` | string | No | Current medications (life-critical only) |
| `emergencyContacts` | array | Yes | Emergency contacts |
| `lastUpdated` | timestamp | Yes | Last sync timestamp |
| `signature` | string | No | HMAC for tamper detection |

**Security:** Readable by anyone, writable only via authenticated Cloud Function.

---

## NFC Data Model

Data written to NFC tags is a lightweight subset of the user profile:

**Fields:**
- `userId` – References Firestore user
- `userName` – For quick identification
- `userPhone` – Direct contact
- `bloodGroup` – Critical for transfusions
- `medicalConditions` – Key conditions
- `allergies` – Medication safety
- `emergencyContacts` – Array of `{name, phone, relationship}`
- `createdAt` – Tag write timestamp

**JSON Example:**
```json
{
  "userId": "abc123def456",
  "userName": "John Doe",
  "userPhone": "+1234567890",
  "bloodGroup": "O+",
  "medicalConditions": "Type 2 Diabetes, Hypertension",
  "allergies": "Penicillin, Peanuts",
  "emergencyContacts": [
    {"name": "Jane Doe", "phone": "+1234567891", "relationship": "Spouse"}
  ],
  "createdAt": "2025-11-18T09:15:00Z"
}
```

---

## Security Rules

**Recommended Firestore Rules:**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    function isSignedIn() {
      return request.auth != null;
    }
    
    function isOwner(uid) {
      return isSignedIn() && request.auth.uid == uid;
    }
    
    // Users collection
    match /users/{uid} {
      allow read: if isOwner(uid);
      allow create: if isOwner(uid);
      allow update: if isOwner(uid) && 
                       request.resource.data.updatedAt > resource.data.updatedAt;
      allow delete: if false; // Prevent accidental deletion
    }
    
    // Medical documents subcollection
    match /users/{uid}/medicalDocuments/{docId} {
      allow read, write: if isOwner(uid);
    }
    
    // Emergency contacts subcollection (if used)
    match /users/{uid}/emergencyContacts/{contactId} {
      allow read, write: if isOwner(uid);
    }
    
    // NFC payload history
    match /nfcPayloads/{payloadId} {
      allow create: if isOwner(request.resource.data.userId);
      allow read: if isOwner(resource.data.userId);
      allow update, delete: if false; // Immutable history
    }
    
    // Public emergency profiles (optional)
    match /publicEmergencyProfiles/{uid} {
      allow read: if true; // Public read for emergency responders
      allow write: if false; // Only Cloud Functions can write
    }
  }
}
```

---

## Indexes

**Required Composite Indexes:**

1. **Medical Documents by Type**
   - Collection: `medicalDocuments`
   - Fields: `type` (ASC), `uploadedAt` (DESC)
   - Query: Recent documents filtered by type

2. **NFC Payloads by User**
   - Collection: `nfcPayloads`
   - Fields: `userId` (ASC), `generatedAt` (DESC)
   - Query: Latest NFC snapshot for user

3. **Users by Blood Group** (optional, for admin filtering)
   - Collection: `users`
   - Fields: `bloodGroup` (ASC), `updatedAt` (DESC)

Create indexes only when Firestore throws query errors—avoid premature optimization.

---

## Query Patterns

### Fetch User Profile
```dart
FirebaseFirestore.instance
  .collection('users')
  .doc(uid)
  .get();
```

### List Medical Documents (Paginated)
```dart
FirebaseFirestore.instance
  .collection('users')
  .doc(uid)
  .collection('medicalDocuments')
  .orderBy('uploadedAt', descending: true)
  .limit(20)
  .get();
```

### Get Latest NFC Payload
```dart
FirebaseFirestore.instance
  .collection('nfcPayloads')
  .where('userId', isEqualTo: uid)
  .orderBy('generatedAt', descending: true)
  .limit(1)
  .get();
```

### Real-time Profile Updates
```dart
FirebaseFirestore.instance
  .collection('users')
  .doc(uid)
  .snapshots()
  .listen((snapshot) {
    // Handle profile changes
  });
```

---

## Offline Support

**Firestore Persistence:**
- Enable on mobile: `FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);`
- Cache size: Default 100MB (configurable)
- Cached collections: `users/{uid}`, `medicalDocuments`

**Strategy:**
- Store `lastNfcSyncAt` locally to avoid redundant tag writes
- Use `docCount` field to display counts without fetching all documents
- Implement optimistic updates with rollback on error

---

## Data Validation

**Client-side:**
- Blood group: Validate against enum (`A+`, `A-`, `B+`, `B-`, `AB+`, `AB-`, `O+`, `O-`)
- Emergency contacts: Max 5-10 contacts
- Phone numbers: Format validation (E.164 recommended)
- File uploads: Max 10MB per document, allowed types: PDF, JPG, PNG

**Server-side (Cloud Functions):**
- Trigger on `medicalDocuments` create: Update `users/{uid}.docCount`
- Trigger on file upload: Validate file type/size, generate thumbnail
- Scheduled function: Clean up orphaned Storage files

---

## Migration Strategy

If migrating from embedded to subcollection structure:

1. **Backup:** Export existing `users` collection
2. **Create subcollections:**
   ```javascript
   // Cloud Function pseudocode
   for each user doc:
     for each doc in medicalDocuments array:
       write to users/{uid}/medicalDocuments/{generatedId}
   ```
3. **Add fields:** `profileVersion: 1`, `lastNfcSyncAt: null`, `docCount: 0`
4. **Deploy rules:** Allow both legacy and new fields temporarily
5. **Update app:** Prefer subcollection reads/writes
6. **Cleanup:** Remove legacy `medicalDocuments` array after validation
7. **Bump version:** Set `profileVersion: 2`

---

## Performance Tips

- **Batch writes:** Use `WriteBatch` for multi-document updates
- **Pagination:** Always use `.limit()` for document lists
- **Denormalization:** Cache `docCount` to avoid counting queries
- **Storage URLs:** Use signed URLs with expiration for sensitive documents
- **Indexes:** Monitor Firestore console for "missing index" errors

---

## Related Documentation

- Security Rules: `../tagit_website/firestore.rules`
- Storage Rules: `../tagit_website/storage.rules`
- Model Definitions: `lib/models/user_model.dart`, `lib/models/nfc_data_model.dart`
- Tech Stack: `TECH_STACK.md`

---

**Last Updated:** November 19, 2025  
**Schema Version:** 1.0
