import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../services/auth_service.dart';
import '../../services/nfc_service.dart';
import '../../services/firestore_service.dart';
import '../../utils/app_theme.dart';
import '../../utils/snackbar_helper.dart';

class NfcSettingsScreen extends StatefulWidget {
  const NfcSettingsScreen({super.key});

  @override
  State<NfcSettingsScreen> createState() => _NfcSettingsScreenState();
}

class _NfcSettingsScreenState extends State<NfcSettingsScreen> {
  final NFCService _nfcService = NFCService();
  bool _isNfcAvailable = false;
  bool _isWriting = false;
  String? _profileUrl;

  @override
  void initState() {
    super.initState();
    _checkNfc();
    _getProfileUrl();
  }

  Future<void> _checkNfc() async {
    final available = await _nfcService.isNfcAvailable();
    setState(() => _isNfcAvailable = available);
  }

  void _getProfileUrl() {
    final authService = Provider.of<AuthService>(context, listen: false);
    final uid = authService.user?.uid;
    if (uid != null) {
      setState(() {
        // Update this URL to match your deployed website
        _profileUrl = 'https://tagit-emergency-ig3uzvyjg-shreyas-projects-4050d18c.vercel.app/user/$uid';
      });
    }
  }

  Future<void> _writeToTag() async {
    if (_profileUrl == null) {
      SnackBarHelper.showError(context, 'Profile URL not found');
      return;
    }

    setState(() => _isWriting = true);

    try {
      // Get user data from Firestore
      final authService = Provider.of<AuthService>(context, listen: false);
      final firestoreService = Provider.of<FirestoreService>(context, listen: false);
      
      if (authService.user == null) {
        SnackBarHelper.showError(context, 'User not logged in');
        setState(() => _isWriting = false);
        return;
      }

      final userProfile = await firestoreService.getUserProfile(authService.user!.uid);
      
      if (userProfile == null) {
        SnackBarHelper.showError(context, 'User profile not found');
        setState(() => _isWriting = false);
        return;
      }

      // Prepare emergency contacts list
      List<String> emergencyContacts = [];
      if (userProfile.emergencyContacts.isNotEmpty) {
        for (var contact in userProfile.emergencyContacts) {
          emergencyContacts.add('${contact.name}: ${contact.phone}');
        }
      }

      // Write URL and emergency data to NFC tag
      await _nfcService.writeNdefUrlWithData(
        _profileUrl!,
        name: userProfile.name,
        bloodGroup: userProfile.bloodGroup ?? 'Unknown',
        medicalConditions: userProfile.medicalConditions,
        allergies: userProfile.allergies,
        emergencyContacts: emergencyContacts.isNotEmpty ? emergencyContacts : null,
      );
      
      if (mounted) {
        SnackBarHelper.showSuccess(context, 'Emergency data written to NFC tag!');
      }
    } catch (e) {
      debugPrint('Error writing to NFC: $e');
      if (mounted) {
        SnackBarHelper.showError(context, 'Failed to write: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _isWriting = false);
      }
    }
  }

  void _copyUrl() {
    if (_profileUrl != null) {
      Clipboard.setData(ClipboardData(text: _profileUrl!));
      SnackBarHelper.showSuccess(context, 'URL copied to clipboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.lightGradient,
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                expandedHeight: 120,
                floating: false,
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(
                    'NFC Settings',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.nfc,
                        size: 60,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
              ),

              // Content
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // NFC Status Card
                    _buildStatusCard(),
                    const SizedBox(height: 16),

                    // Profile URL Card
                    _buildProfileUrlCard(),
                    const SizedBox(height: 16),

                    // QR Code Card
                    if (_profileUrl != null) _buildQrCodeCard(),
                    if (_profileUrl != null) const SizedBox(height: 16),

                    // Write to Tag Card
                    _buildWriteCard(),
                    const SizedBox(height: 16),

                    // Instructions Card
                    _buildInstructionsCard(),
                    const SizedBox(height: 16),

                    // Info Card
                    _buildInfoCard(),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _isNfcAvailable
                    ? AppTheme.successGreen.withOpacity(0.1)
                    : AppTheme.errorRed.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _isNfcAvailable ? Icons.check_circle : Icons.error,
                color:
                    _isNfcAvailable ? AppTheme.successGreen : AppTheme.errorRed,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _isNfcAvailable
                        ? 'NFC Available'
                        : 'NFC Not Available',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _isNfcAvailable
                        ? 'Your device supports NFC'
                        : 'Please enable NFC in settings',
                    style: const TextStyle(
                      color: AppTheme.textGrey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileUrlCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.link,
                    color: AppTheme.primaryRed,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Your Profile URL',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.backgroundLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.dividerGrey),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _profileUrl ?? 'Loading...',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textGrey,
                        fontFamily: 'monospace',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: _copyUrl,
                    icon: const Icon(Icons.copy, size: 20),
                    color: AppTheme.primaryRed,
                    tooltip: 'Copy URL',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'This URL can be accessed by anyone to view your emergency information.',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.textGrey.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrCodeCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'QR Code',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.dividerGrey, width: 2),
              ),
              child: QrImageView(
                data: _profileUrl!,
                version: QrVersions.auto,
                size: 200.0,
                backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Scan this QR code to access your profile',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.textGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWriteCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.nfc,
              size: 48,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            const Text(
              'Write to NFC Tag',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap the button below and hold your NFC tag near your phone',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isNfcAvailable && !_isWriting ? _writeToTag : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppTheme.primaryRed,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: _isWriting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppTheme.primaryRed),
                        ),
                      )
                    : const Text(
                        'Write to Tag',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How to Program Your NFC Tag',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 16),
            _buildStep(1, 'Get an NFC tag (MIFARE Classic 1K recommended)'),
            _buildStep(2, 'Tap "Write to Tag" button above'),
            _buildStep(3, 'Hold your NFC tag near your phone'),
            _buildStep(4, 'Wait for success confirmation'),
            _buildStep(5, 'Attach the tag to your helmet, wallet, or ID'),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(int number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppTheme.primaryRed,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textDark,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 2,
      color: AppTheme.ultraLightRed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppTheme.primaryRed,
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Important Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryRed,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoPoint('Your profile URL is public and can be accessed by anyone'),
            _buildInfoPoint('Only share your NFC tag with trusted individuals'),
            _buildInfoPoint('You can update your profile information anytime'),
            _buildInfoPoint('Keep your NFC tag in a secure, accessible location'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(
              Icons.circle,
              size: 6,
              color: AppTheme.primaryRed,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.textDark,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
