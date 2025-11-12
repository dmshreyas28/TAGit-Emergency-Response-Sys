import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../services/nfc_service.dart';

class NfcScreen extends StatefulWidget {
  const NfcScreen({super.key});

  @override
  State<NfcScreen> createState() => _NfcScreenState();
}

class _NfcScreenState extends State<NfcScreen> {
  final _nfcService = NFCService();
  bool _isNfcAvailable = false;
  bool _isWriting = false;
  bool _isReading = false;
  String? _profileUrl;

  @override
  void initState() {
    super.initState();
    _checkNfcAvailability();
    _generateProfileUrl();
  }

  Future<void> _checkNfcAvailability() async {
    final available = await _nfcService.isNfcAvailable();
    setState(() => _isNfcAvailable = available);
  }

  void _generateProfileUrl() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final uid = userProvider.userProfile?.uid;
    if (uid != null) {
      setState(() {
        _profileUrl = 'https://tagit-emergency.vercel.app/user/$uid';
      });
    }
  }

  Future<void> _writeToTag() async {
    if (_profileUrl == null) return;

    setState(() => _isWriting = true);

    try {
      // Use NDEF format for better compatibility
      await _nfcService.writeNdefUrl(_profileUrl!);
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Check NFC settings screen for write instructions'),
          backgroundColor: Colors.blue,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isWriting = false);
    }
  }

  Future<void> _readFromTag() async {
    setState(() => _isReading = true);

    try {
      final data = await _nfcService.readFromTag();
      
      if (!mounted) return;
      
      if (data != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Read data: ${data.userName}'),
            backgroundColor: Colors.blue,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No data read from tag'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isReading = false);
    }
  }

  void _copyProfileUrl() {
    if (_profileUrl != null) {
      Clipboard.setData(ClipboardData(text: _profileUrl!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile URL copied to clipboard')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFC Setup'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // NFC Availability Status
            Card(
              color: _isNfcAvailable 
                ? const Color(0xFFDCFCE7) 
                : const Color(0xFFFEE2E2),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      _isNfcAvailable ? Icons.check_circle : Icons.error,
                      color: _isNfcAvailable 
                        ? const Color(0xFF16A34A) 
                        : const Color(0xFFDC2626),
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isNfcAvailable 
                              ? 'NFC is Available' 
                              : 'NFC Not Available',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _isNfcAvailable 
                                ? const Color(0xFF166534) 
                                : const Color(0xFF991B1B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _isNfcAvailable
                              ? 'Ready to write your profile to MIFARE Classic 1K tags'
                              : 'Please enable NFC in your device settings',
                            style: TextStyle(
                              fontSize: 14,
                              color: _isNfcAvailable 
                                ? const Color(0xFF166534) 
                                : const Color(0xFF991B1B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Profile URL Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3B82F6).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Icon(
                            Icons.link,
                            color: Color(0xFF3B82F6),
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Text(
                            'Your Emergency Profile URL',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _profileUrl ?? 'Generating...',
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.copy, size: 20),
                            onPressed: _copyProfileUrl,
                            tooltip: 'Copy URL',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // MIFARE Classic 1K Info
            Card(
              color: const Color(0xFFEDE9FE),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B5CF6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.nfc,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'MIFARE Classic 1K',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5B21B6),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      ' 1024 bytes memory capacity\n'
                      ' 16 sectors with authentication\n'
                      ' URL stored using NDEF format\n'
                      ' Compatible with most smartphones',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF5B21B6),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Write Button
            ElevatedButton.icon(
              onPressed: (_isNfcAvailable && !_isWriting && _profileUrl != null) 
                ? _writeToTag 
                : null,
              icon: _isWriting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.nfc),
              label: Text(_isWriting ? 'Hold tag near phone...' : 'Write to MIFARE Tag'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xFF8B5CF6),
              ),
            ),

            const SizedBox(height: 12),

            // Read Button
            OutlinedButton.icon(
              onPressed: (_isNfcAvailable && !_isReading) ? _readFromTag : null,
              icon: _isReading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.nfc),
              label: Text(_isReading ? 'Hold tag near phone...' : 'Read from Tag'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),

            const SizedBox(height: 32),

            // Instructions
            const Text(
              'How to Write:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildInstructionCard(
              '1',
              'Tap "Write to MIFARE Tag" button above',
              Icons.touch_app,
            ),
            const SizedBox(height: 8),
            _buildInstructionCard(
              '2',
              'Hold your MIFARE Classic 1K tag near the back of your phone',
              Icons.phone_android,
            ),
            const SizedBox(height: 8),
            _buildInstructionCard(
              '3',
              'Wait for confirmation message',
              Icons.check_circle,
            ),
            const SizedBox(height: 8),
            _buildInstructionCard(
              '4',
              'Test by scanning the tag with any NFC-enabled phone',
              Icons.verified,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionCard(String number, String text, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF8B5CF6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  number,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B5CF6),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            Icon(icon, color: const Color(0xFF8B5CF6), size: 24),
          ],
        ),
      ),
    );
  }
}
