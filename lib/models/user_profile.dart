class UserProfile {
  final String uid;
  final String email;
  final String name;
  final String phone;
  final String? bloodGroup;
  final int? age;
  final String? address;
  final String? medicalConditions;
  final String? allergies;
  final String? medications;
  final List<EmergencyContact> emergencyContacts;
  final List<MedicalDocument> medicalDocuments;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
    this.bloodGroup,
    this.age,
    this.address,
    this.medicalConditions,
    this.allergies,
    this.medications,
    this.emergencyContacts = const [],
    this.medicalDocuments = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    try {
      return UserProfile(
        uid: json['uid']?.toString() ?? '',
        email: json['email']?.toString() ?? '',
        name: json['name']?.toString() ?? '',
        phone: json['phone']?.toString() ?? '',
        bloodGroup: json['bloodGroup']?.toString(),
        age: json['age'] is int ? json['age'] : (json['age'] != null ? int.tryParse(json['age'].toString()) : null),
        address: json['address']?.toString(),
        medicalConditions: json['medicalConditions']?.toString(),
        allergies: json['allergies']?.toString(),
        medications: json['medications']?.toString(),
        emergencyContacts: (json['emergencyContacts'] is List
                ? json['emergencyContacts'] as List<dynamic>
                : <dynamic>[])
            .map((e) {
              try {
                return EmergencyContact.fromJson(e as Map<String, dynamic>);
              } catch (err) {
                print('Error parsing emergency contact: $err');
                return null;
              }
            })
            .whereType<EmergencyContact>()
            .toList(),
        medicalDocuments: (json['medicalDocuments'] is List
                ? json['medicalDocuments'] as List<dynamic>
                : <dynamic>[])
            .map((e) {
              try {
                return MedicalDocument.fromJson(e as Map<String, dynamic>);
              } catch (err) {
                print('Error parsing medical document: $err');
                return null;
              }
            })
            .whereType<MedicalDocument>()
            .toList(),
        createdAt: json['createdAt'] is String
            ? DateTime.parse(json['createdAt'])
            : (json['createdAt'] is int
                ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'])
                : DateTime.now()),
        updatedAt: json['updatedAt'] is String
            ? DateTime.parse(json['updatedAt'])
            : (json['updatedAt'] is int
                ? DateTime.fromMillisecondsSinceEpoch(json['updatedAt'])
                : DateTime.now()),
      );
    } catch (e) {
      print('Error parsing UserProfile: $e');
      print('JSON data: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'bloodGroup': bloodGroup,
      'age': age,
      'address': address,
      'medicalConditions': medicalConditions,
      'allergies': allergies,
      'medications': medications,
      'emergencyContacts': emergencyContacts.map((e) => e.toJson()).toList(),
      'medicalDocuments': medicalDocuments.map((e) => e.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class EmergencyContact {
  final String name;
  final String relationship;
  final String phone;

  EmergencyContact({
    required this.name,
    required this.relationship,
    required this.phone,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      name: json['name'] ?? '',
      relationship: json['relationship'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'relationship': relationship,
      'phone': phone,
    };
  }
}

class MedicalDocument {
  final String id;
  final String name;
  final String type;
  final String url;
  final DateTime uploadedAt;

  MedicalDocument({
    required this.id,
    required this.name,
    required this.type,
    required this.url,
    required this.uploadedAt,
  });

  factory MedicalDocument.fromJson(Map<String, dynamic> json) {
    return MedicalDocument(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      url: json['url'] ?? '',
      uploadedAt: DateTime.parse(json['uploadedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'url': url,
      'uploadedAt': uploadedAt.toIso8601String(),
    };
  }
}
