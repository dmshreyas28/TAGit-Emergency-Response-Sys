import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Notifications',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 20),
          _buildNotificationCard(
            icon: Icons.emergency_outlined,
            title: 'SOS Alert Sent',
            message: 'Emergency contacts notified',
            time: '2 hours ago',
            color: const Color(0xFFFF0000),
          ),
          _buildNotificationCard(
            icon: Icons.edit_outlined,
            title: 'Profile Updated',
            message: 'Medical information updated',
            time: '1 day ago',
            color: const Color(0xFF2196F3),
          ),
          _buildNotificationCard(
            icon: Icons.login_outlined,
            title: 'New Login',
            message: 'Logged in from new device',
            time: '3 days ago',
            color: const Color(0xFFFF9800),
          ),
          _buildNotificationCard(
            icon: Icons.nfc,
            title: 'NFC Tag Written',
            message: 'Emergency data saved to tag',
            time: '1 week ago',
            color: const Color(0xFF4CAF50),
          ),
        ],
      ),
    );
  }

  static Widget _buildNotificationCard({
    required IconData icon,
    required String title,
    required String message,
    required String time,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF757575),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
