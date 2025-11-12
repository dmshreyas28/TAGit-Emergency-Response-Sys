import 'package:flutter/material.dart';
import '../nfc/nfc_settings_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 24),
          
          // NFC Settings Section
          const Text(
            'NFC',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF757575),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
        _buildSettingsTile(
          context,
          icon: Icons.nfc,
          title: 'NFC Settings',
          subtitle: 'Configure your NFC tag',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NfcSettingsScreen()),
            );
          },
        ),
        const SizedBox(height: 32),
        
        // Appearance Section
        Text(
          'Appearance',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        _buildSettingsTile(
          context,
          icon: Icons.palette_outlined,
          title: 'Theme',
          subtitle: 'Light mode',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Theme customization coming soon')),
            );
          },
        ),
        const SizedBox(height: 32),
        
        // Account Section
        Text(
          'Account',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        _buildSettingsTile(
          context,
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy & Security',
          subtitle: 'Manage privacy settings',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Privacy settings coming soon')),
            );
          },
        ),
        _buildSettingsTile(
          context,
          icon: Icons.notifications_outlined,
          title: 'Notifications',
          subtitle: 'Control notifications',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Notification settings coming soon')),
            );
          },
        ),
      ],
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.black, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF757575),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF9E9E9E)),
        onTap: onTap,
      ),
    );
  }
}
