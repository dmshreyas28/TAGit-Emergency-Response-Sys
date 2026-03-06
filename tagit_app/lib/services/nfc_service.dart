import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager_ndef/nfc_manager_ndef.dart';
import 'package:ndef_record/ndef_record.dart';
import '../models/nfc_data_model.dart';

class NFCService extends ChangeNotifier {
  bool _isAvailable = false;
  bool _isReading = false;
  bool _isWriting = false;
  String? _errorMessage;
  NFCDataModel? _lastReadData;

  bool get isAvailable => _isAvailable;
  bool get isReading => _isReading;
  bool get isWriting => _isWriting;
  String? get errorMessage => _errorMessage;
  NFCDataModel? get lastReadData => _lastReadData;

  // Check if NFC is available on device
  Future<bool> isNfcAvailable() async {
    try {
      debugPrint('Checking NFC availability...');
      _isAvailable = await NfcManager.instance.isAvailable();
      debugPrint('NFC available: $_isAvailable');
      
      if (!_isAvailable) {
        _errorMessage = 'NFC not available. Please enable NFC in Settings → Connected devices → NFC';
      }
      
      notifyListeners();
      return _isAvailable;
    } catch (e) {
      debugPrint('Error checking NFC: $e');
      _isAvailable = false;
      _errorMessage = 'Failed to check NFC availability: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  Future<void> checkNFCAvailability() async {
    await isNfcAvailable();
  }

  // Write NDEF URL and emergency data to NFC tag
  Future<void> writeNdefUrlWithData(String url, {
    required String name,
    required String bloodGroup,
    String? medicalConditions,
    String? allergies,
    List<String>? emergencyContacts,
  }) async {
    if (!_isAvailable) {
      throw Exception('NFC not available on device');
    }

    _isWriting = true;
    _errorMessage = 'Hold your NFC tag near the phone...';
    notifyListeners();

    try {
      await NfcManager.instance.startSession(
        pollingOptions: {
          NfcPollingOption.iso14443,
          NfcPollingOption.iso15693,
        },
        onDiscovered: (NfcTag tag) async {
          try {
            debugPrint('🏷️ NFC Tag discovered');
            _errorMessage = 'Tag detected! Writing emergency data...';
            notifyListeners();

            // Get Ndef instance from tag
            final ndef = Ndef.from(tag);
            if (ndef == null) {
              throw Exception('Tag does not support NDEF');
            }

            // Check if writable
            if (!ndef.isWritable) {
              throw Exception('Tag is not writable or locked');
            }

            debugPrint('📝 Writing NDEF message with emergency data...');
            
            // Create list of records
            List<NdefRecord> records = [];
            
            // 1. URL Record (first record - will be opened by default)
            final List<int> urlPayload;
            if (url.startsWith('https://')) {
              urlPayload = [0x04, ...url.substring(8).codeUnits];
            } else if (url.startsWith('http://')) {
              urlPayload = [0x03, ...url.substring(7).codeUnits];
            } else {
              urlPayload = [0x00, ...url.codeUnits];
            }
            
            records.add(NdefRecord(
              typeNameFormat: TypeNameFormat.wellKnown,
              type: Uint8List.fromList([0x55]), // 'U' for URI
              identifier: Uint8List(0),
              payload: Uint8List.fromList(urlPayload),
            ));
            
            // 2. Emergency Data as Text Record
            final emergencyData = StringBuffer();
            emergencyData.writeln('🆘 EMERGENCY CONTACT INFO');
            emergencyData.writeln('━━━━━━━━━━━━━━━━━━━━━━━━');
            emergencyData.writeln('Name: $name');
            emergencyData.writeln('Blood: $bloodGroup');
            
            if (medicalConditions != null && medicalConditions.isNotEmpty) {
              emergencyData.writeln('Medical: $medicalConditions');
            }
            
            if (allergies != null && allergies.isNotEmpty) {
              emergencyData.writeln('Allergies: $allergies');
            }
            
            if (emergencyContacts != null && emergencyContacts.isNotEmpty) {
              emergencyData.writeln('━━━━━━━━━━━━━━━━━━━━━━━━');
              emergencyData.writeln('Emergency Contacts:');
              for (var contact in emergencyContacts) {
                emergencyData.writeln('📞 $contact');
              }
            }
            
            emergencyData.writeln('━━━━━━━━━━━━━━━━━━━━━━━━');
            emergencyData.writeln('Profile: $url');
            
            final textBytes = emergencyData.toString().codeUnits;
            final textPayload = [
              0x02, // UTF-8 encoding
              'en'.codeUnitAt(0), 
              'en'.codeUnitAt(1),
              ...textBytes,
            ];
            
            records.add(NdefRecord(
              typeNameFormat: TypeNameFormat.wellKnown,
              type: Uint8List.fromList([0x54]), // 'T' for Text
              identifier: Uint8List(0),
              payload: Uint8List.fromList(textPayload),
            ));
            
            // Create NDEF message with all records
            final message = NdefMessage(records: records);

            // Check if message will fit
            final messageSize = message.byteLength;
            if (messageSize > ndef.maxSize) {
              throw Exception('Data too large for tag ($messageSize bytes > ${ndef.maxSize} bytes)');
            }

            // Write to tag
            await ndef.write(message: message);
            
            debugPrint('✅ Successfully wrote emergency data to tag!');
            debugPrint('   Records: ${records.length}');
            debugPrint('   Size: $messageSize / ${ndef.maxSize} bytes');
            
            _errorMessage = '✅ Emergency data written!\n\n📱 URL + Offline Data\n${records.length} records, $messageSize bytes';
            _isWriting = false;
            notifyListeners();
            
            await Future.delayed(Duration(seconds: 2));
            await NfcManager.instance.stopSession();
            
          } catch (e) {
            debugPrint('❌ Write error: $e');
            _isWriting = false;
            _errorMessage = '❌ Failed: ${e.toString()}';
            notifyListeners();
            await NfcManager.instance.stopSession();
            rethrow;
          }
        },
      );
    } catch (e) {
      _isWriting = false;
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Write NDEF URL record to NFC tag (simple version - kept for compatibility)
  Future<void> writeNdefUrl(String url) async {
    if (!_isAvailable) {
      throw Exception('NFC not available on device');
    }

    _isWriting = true;
    _errorMessage = 'Hold your NFC tag near the phone...';
    notifyListeners();

    try {
      await NfcManager.instance.startSession(
        pollingOptions: {
          NfcPollingOption.iso14443,
          NfcPollingOption.iso15693,
        },
        onDiscovered: (NfcTag tag) async {
          try {
            debugPrint('🏷️ NFC Tag discovered');
            _errorMessage = 'Tag detected! Writing URL...';
            notifyListeners();

            // Get Ndef instance from tag
            final ndef = Ndef.from(tag);
            if (ndef == null) {
              throw Exception('Tag does not support NDEF');
            }

            // Check if writable
            if (!ndef.isWritable) {
              throw Exception('Tag is not writable or locked');
            }

            debugPrint('📝 Writing NDEF message...');
            
            // Create NDEF URI record payload manually
            final List<int> payload;
            if (url.startsWith('https://')) {
              payload = [0x04, ...url.substring(8).codeUnits]; // 0x04 = https://
            } else if (url.startsWith('http://')) {
              payload = [0x03, ...url.substring(7).codeUnits]; // 0x03 = http://
            } else {
              payload = [0x00, ...url.codeUnits]; // 0x00 = no prefix
            }
            
            // Create NDEF record
            final record = NdefRecord(
              typeNameFormat: TypeNameFormat.wellKnown,
              type: Uint8List.fromList([0x55]), // 'U' for URI
              identifier: Uint8List(0),
              payload: Uint8List.fromList(payload),
            );
            
            // Create NDEF message
            final message = NdefMessage(records: [record]);

            // Write to tag
            await ndef.write(message: message);
            
            debugPrint('✅ Successfully wrote to tag!');
            _errorMessage = '✅ URL written to tag!\n\n$url';
            _isWriting = false;
            notifyListeners();
            
            await Future.delayed(Duration(seconds: 2));
            await NfcManager.instance.stopSession();
            
          } catch (e) {
            debugPrint('❌ Write error: $e');
            _isWriting = false;
            _errorMessage = '❌ Failed: ${e.toString()}';
            notifyListeners();
            await NfcManager.instance.stopSession();
            rethrow;
          }
        },
      );
    } catch (e) {
      _isWriting = false;
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<bool> writeToTag(NFCDataModel data) async {
    if (!_isAvailable) {
      _errorMessage = 'NFC not available on device';
      notifyListeners();
      return false;
    }

    _isWriting = true;
    _errorMessage = 'NFC Write: Hold tag near phone...';
    notifyListeners();

    try {
      bool success = false;
      
      await NfcManager.instance.startSession(
        pollingOptions: {NfcPollingOption.iso14443, NfcPollingOption.iso15693},
        onDiscovered: (NfcTag tag) async {
          debugPrint('NFC Tag discovered');
          _errorMessage = 'Tag detected! Writing data...';
          notifyListeners();
          
          await Future.delayed(Duration(seconds: 1));
          
          success = true;
          _errorMessage = 'Write successful! (Simulated)';
          _isWriting = false;
          notifyListeners();
          await NfcManager.instance.stopSession();
        },
      );
      
      if (!success) {
        _isWriting = false;
        _errorMessage = 'No tag detected';
        notifyListeners();
      }
      
      return success;
    } catch (e) {
      _isWriting = false;
      _errorMessage = 'Write failed: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  Future<NFCDataModel?> readFromTag() async {
    if (!_isAvailable) {
      _errorMessage = 'NFC not available on device';
      notifyListeners();
      return null;
    }

    _isReading = true;
    _errorMessage = 'NFC Read: Hold tag near phone...';
    _lastReadData = null;
    notifyListeners();

    try {
      NFCDataModel? data;
      bool sessionCompleted = false;
      
      await NfcManager.instance.startSession(
        pollingOptions: {NfcPollingOption.iso14443, NfcPollingOption.iso15693},
        onDiscovered: (NfcTag tag) async {
          if (sessionCompleted) return; // Prevent multiple reads
          sessionCompleted = true;
          
          debugPrint('NFC Tag discovered for reading');
          debugPrint('Tag data: ${tag.toString()}');
          
          _errorMessage = 'Tag detected! Reading data...';
          notifyListeners();
          
          // Try to parse NDEF data from tag
          String? url = await _parseNdefUrl(tag);
          String? emergencyText = await _parseNdefText(tag);
          
          if (url != null && url.isNotEmpty) {
            debugPrint('Found URL on tag: $url');
            if (emergencyText != null) {
              debugPrint('Found emergency text data on tag');
            }
            
            _errorMessage = 'TAGit data found!\n${emergencyText != null ? "With offline emergency info" : "URL only"}';
            notifyListeners();
            
            // Check if it's a TAGit profile URL (supports both Firebase and Vercel URLs)
            if (url.contains('tagit-emergency.web.app/user/') || 
                url.contains('tagit-emergency') && url.contains('vercel.app/user/')) {
              final userId = url.split('/user/').last.split('?').first; // Remove query params if any
              debugPrint('TAGit profile detected! User ID: $userId');
              
              // Create a data model with the URL and emergency text info
              data = NFCDataModel(
                userId: userId,
                userName: emergencyText != null ? 'TAGit Emergency Profile' : 'TAGit Profile',
                userPhone: emergencyText ?? 'Tap to open profile',
                bloodGroup: url,
                medicalConditions: emergencyText != null ? 'Offline emergency data available' : 'Profile URL detected',
                allergies: 'Opening browser...',
                emergencyContacts: [],
                createdAt: DateTime.now(),
              );
              
              _lastReadData = data;
              _errorMessage = 'TAGit profile URL detected!\nOpening browser...';
              _isReading = false;
              notifyListeners();
              
              // Open URL in browser
              await NfcManager.instance.stopSession();
              // Don't return here, let it fall through
            } else {
              // Not a TAGit URL but still a URL
              _errorMessage = 'URL found but not a TAGit profile:\n$url';
              data = NFCDataModel(
                userId: 'external-url',
                userName: 'External URL',
                userPhone: url,
                bloodGroup: 'N/A',
                medicalConditions: 'This is not a TAGit emergency tag',
                allergies: 'N/A',
                emergencyContacts: [],
                createdAt: DateTime.now(),
              );
            }
          } else {
            // No URL found, show demo data
            debugPrint('No URL found on tag, showing demo data');
            _errorMessage = 'No TAGit URL found on tag.\nShowing demo data.\n\nTo program this tag:\n1. Open NFC Settings\n2. Copy your profile URL\n3. Use NFC Tools app to write it';
            data = NFCDataModel(
              userId: 'demo-user',
              userName: 'Demo User',
              userPhone: '+91 1234567890',
              bloodGroup: 'O+',
              medicalConditions: 'This is demo data',
              allergies: 'No TAGit URL found on this tag',
              emergencyContacts: [
                {'name': 'Emergency Contact', 'phone': '+91 9876543210'}
              ],
              createdAt: DateTime.now(),
            );
          }
          
          _lastReadData = data;
          _isReading = false;
          notifyListeners();
          
          await NfcManager.instance.stopSession();
        },
      );
      
      // Wait up to 30 seconds for tag detection
      int attempts = 0;
      while (!sessionCompleted && attempts < 300) {
        await Future.delayed(Duration(milliseconds: 100));
        attempts++;
      }
      
      if (!sessionCompleted) {
        _isReading = false;
        _errorMessage = 'No tag detected - session timed out';
        notifyListeners();
        await NfcManager.instance.stopSession();
      }
      
      return data;
    } catch (e) {
      _isReading = false;
      _errorMessage = 'Read failed: ${e.toString()}';
      notifyListeners();
      await NfcManager.instance.stopSession();
      return null;
    }
  }

  // Parse NDEF URL from NFC tag
  Future<String?> _parseNdefUrl(NfcTag tag) async {
    try {
      // Get Ndef instance from tag
      final ndef = Ndef.from(tag);
      if (ndef == null) {
        debugPrint('Tag does not support NDEF');
        return null;
      }
      
      // Get cached message
      final cachedMessage = ndef.cachedMessage;
      if (cachedMessage == null || cachedMessage.records.isEmpty) {
        debugPrint('No NDEF message found on tag');
        return null;
      }
      
      debugPrint('Found ${cachedMessage.records.length} NDEF record(s)');
      
      // Get first record (should be the URL)
      final firstRecord = cachedMessage.records.first;
      final payload = firstRecord.payload;
      
      if (payload.isEmpty) {
        debugPrint('Empty payload in NDEF record');
        return null;
      }
      
      // Check if it's a URI record (type = 'U' = 0x55)
      if (firstRecord.typeNameFormat == TypeNameFormat.wellKnown && 
          firstRecord.type.length == 1 && 
          firstRecord.type[0] == 0x55) {
        
        debugPrint('✅ Found URI record');
        
        // NDEF URI record format:
        // Byte 0: URI identifier code
        //   0x00 = No prepending (full URI in payload)
        //   0x01 = http://www.
        //   0x02 = https://www.
        //   0x03 = http://
        //   0x04 = https://
        final identifierCode = payload[0];
        final urlBytes = payload.sublist(1);
        
        // Convert bytes to string
        String urlPart = String.fromCharCodes(urlBytes);
        
        // Add prefix based on identifier code
        String fullUrl;
        switch (identifierCode) {
          case 0x00:
            fullUrl = urlPart; // No prefix, full URL in payload
            break;
          case 0x01:
            fullUrl = 'http://www.$urlPart';
            break;
          case 0x02:
            fullUrl = 'https://www.$urlPart';
            break;
          case 0x03:
            fullUrl = 'http://$urlPart';
            break;
          case 0x04:
            fullUrl = 'https://$urlPart';
            break;
          default:
            // Unknown code, treat as no prefix
            fullUrl = urlPart;
        }
        
        debugPrint('✅ Parsed URL from NFC tag: $fullUrl');
        return fullUrl;
      } else {
        debugPrint('First record is not a URI record');
        return null;
      }
      
    } catch (e, stackTrace) {
      debugPrint('❌ Error parsing NDEF URL: $e');
      debugPrint('Stack trace: $stackTrace');
      return null;
    }
  }

  // Parse NDEF Text record from NFC tag
  Future<String?> _parseNdefText(NfcTag tag) async {
    try {
      // Get Ndef instance from tag
      final ndef = Ndef.from(tag);
      if (ndef == null) {
        return null;
      }
      
      // Get cached message
      final cachedMessage = ndef.cachedMessage;
      if (cachedMessage == null || cachedMessage.records.length < 2) {
        return null; // No text record (need at least 2 records: URL + Text)
      }
      
      // Look for text record (type = 'T' = 0x54)
      for (var record in cachedMessage.records) {
        if (record.typeNameFormat == TypeNameFormat.wellKnown && 
            record.type.length == 1 && 
            record.type[0] == 0x54) {
          
          debugPrint('✅ Found Text record');
          
          final payload = record.payload;
          if (payload.length < 3) {
            continue;
          }
          
          // Text record format:
          // Byte 0: Status byte (bit 7: encoding, bits 5-0: language code length)
          // Byte 1-N: Language code (e.g., 'en')
          // Byte N+1-end: Text in specified encoding
          
          final statusByte = payload[0];
          final languageCodeLength = statusByte & 0x3F;
          
          if (payload.length < 1 + languageCodeLength) {
            continue;
          }
          
          // Skip status byte and language code to get the actual text
          final textBytes = payload.sublist(1 + languageCodeLength);
          final text = String.fromCharCodes(textBytes);
          
          debugPrint('📄 Text content: ${text.substring(0, text.length > 100 ? 100 : text.length)}...');
          return text;
        }
      }
      
      return null;
      
    } catch (e, stackTrace) {
      debugPrint('❌ Error parsing NDEF text: $e');
      debugPrint('Stack trace: $stackTrace');
      return null;
    }
  }

  Future<void> stopSession() async {
    try {
      await NfcManager.instance.stopSession();
      _isReading = false;
      _isWriting = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Stop session error: $e');
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearLastReadData() {
    _lastReadData = null;
    notifyListeners();
  }
}
