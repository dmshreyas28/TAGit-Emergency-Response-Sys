import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import '../../utils/app_theme.dart';
import '../../widgets/confirm_dialog.dart';
import '../../widgets/loading_dialog.dart';
import '../about/about_screen.dart';
import '../documents/documents_screen.dart';
import '../emergency_contacts/emergency_contacts_screen.dart';
import '../home/new_home_screen.dart';
import '../location/location_screen.dart';
import '../nfc/nfc_read_screen.dart';
import '../nfc/nfc_settings_screen.dart';
import '../notifications/notifications_screen.dart';
import '../profile/profile_screen.dart';
import '../settings/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    NewHomeScreen(),
    NotificationsScreen(),
    SettingsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.primaryGradient,
          ),
        ),
        elevation: 0,
      ),
      drawer: _buildDrawer(),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  String _getTitle() {
    switch (_currentIndex) {
      case 0:
        return 'TAGit';
      case 1:
        return 'Notifications';
      case 2:
        return 'Settings';
      case 3:
        return 'Profile';
      default:
        return 'TAGit';
    }
  }

  Widget _buildDrawer() {
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;

    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFDC2626), Colors.white],
            stops: [0.0, 0.3],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFFF0000),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    child:
                        Icon(Icons.person, size: 36, color: Color(0xFFFF0000)),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user?.email?.split('@').first ?? 'User',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user?.email ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            // NFC Section with submenu
            ExpansionTile(
              leading:
                  const Icon(Icons.nfc, color: Color(0xFFFF0000), size: 24),
              title: const Text('NFC',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              iconColor: const Color(0xFFFF0000),
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 72, right: 16),
                  title: const Text('Read NFC', style: TextStyle(fontSize: 14)),
                  trailing: const Icon(Icons.qr_code_scanner, size: 20),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const NFCReadScreen()),
                    );
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 72, right: 16),
                  title:
                      const Text('Write NFC', style: TextStyle(fontSize: 14)),
                  trailing: const Icon(Icons.edit, size: 20),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const NfcSettingsScreen()),
                    );
                  },
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.file_upload_outlined,
                  color: Color(0xFFFF0000), size: 24),
              title: const Text('Upload Documents',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DocumentsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on_outlined,
                  color: Color(0xFFFF0000), size: 24),
              title: const Text('Location Services',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LocationScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.qr_code_2_outlined,
                  color: Color(0xFFFF0000), size: 24),
              title: const Text('View Profile QR',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              onTap: () => _showProfileQR(context),
            ),
            ListTile(
              leading: const Icon(Icons.contact_phone_outlined,
                  color: Color(0xFFFF0000), size: 24),
              title: const Text('Emergency Contacts',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const EmergencyContactsScreen()),
                );
              },
            ),
            const Divider(height: 32, thickness: 1),
            ListTile(
              leading: const Icon(Icons.info_outline,
                  color: Color(0xFFFF0000), size: 24),
              title: const Text('About App',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined,
                  color: Color(0xFFFF0000), size: 24),
              title: const Text('Logout',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Color(0xFFFF0000))),
              onTap: _handleLogout,
            ),
          ],
        ),
      ),
    );
  }

  void _showProfileQR(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final uid = authService.user?.uid;

    if (uid == null) return;

    final profileUrl =
        'https://tagit-emergency-ig3uzvyjg-shreyas-projects-4050d18c.vercel.app/user/$uid';

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Profile QR Code',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Scan to view your emergency profile',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: QrImageView(
                  data: profileUrl,
                  version: QrVersions.auto,
                  size: 250,
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                label: const Text('Close'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC2626),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => const ConfirmDialog(
        title: 'Logout',
        message: 'Are you sure you want to logout?',
        confirmText: 'Logout',
        isDangerous: true,
      ),
    );

    if (confirm == true && mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingDialog(message: 'Logging out...'),
      );

      final authService = Provider.of<AuthService>(context, listen: false);
      final firestoreService =
          Provider.of<FirestoreService>(context, listen: false);

      await authService.signOut();
      firestoreService.clearCurrentUser();

      if (mounted) {
        Navigator.of(context).pop(); // Close loading dialog
        // Don't navigate manually - let main.dart's Consumer handle it automatically
        // The AuthService will notify listeners and main.dart will show LoginScreen
      }
    }
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            selectedItemColor: const Color(0xFFFF0000),
            unselectedItemColor: const Color(0xFF999999),
            selectedColorOpacity: 0.15,
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.home_outlined, size: 24),
                activeIcon: const Icon(Icons.home, size: 24),
                title: const Text('Home',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                selectedColor: const Color(0xFFFF0000),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.notifications_outlined, size: 24),
                activeIcon: const Icon(Icons.notifications, size: 24),
                title: const Text('Alerts',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                selectedColor: Colors.orange,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.settings_outlined, size: 24),
                activeIcon: const Icon(Icons.settings, size: 24),
                title: const Text('Settings',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                selectedColor: Colors.purple,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.person_outline, size: 24),
                activeIcon: const Icon(Icons.person, size: 24),
                title: const Text('Profile',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                selectedColor: Colors.teal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
