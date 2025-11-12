import 'package:flutter/material.dart';

/// Comprehensive button demo screen showcasing all button types
/// Used as reference for implementing buttons throughout the app
class ButtonDemo extends StatelessWidget {
  const ButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Components'),
        backgroundColor: Colors.red.shade600,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Elevated Buttons Section
            _buildSectionTitle('Elevated Buttons'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Default'),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('With Icon'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
                const ElevatedButton(
                  onPressed: null,
                  child: Text('Disabled'),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Filled Buttons Section
            _buildSectionTitle('Filled Buttons'),
            const Text(
              'Modern Material 3 style - recommended for primary actions',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: () {},
                  child: const Text('Default'),
                ),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('With Icon'),
                ),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Custom Color'),
                ),
                FilledButton(
                  onPressed: () {},
                  child: const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
                const FilledButton(
                  onPressed: null,
                  child: Text('Disabled'),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Filled Tonal Buttons Section
            _buildSectionTitle('Filled Tonal Buttons'),
            const Text(
              'Softer alternative to filled buttons',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.tonal(
                  onPressed: () {},
                  child: const Text('Default'),
                ),
                FilledButton.tonalIcon(
                  onPressed: () {},
                  icon: const Icon(Icons.star),
                  label: const Text('With Icon'),
                ),
                const FilledButton.tonal(
                  onPressed: null,
                  child: Text('Disabled'),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Outlined Buttons Section
            _buildSectionTitle('Outlined Buttons'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Default'),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('With Icon'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                  child: const Text('Custom Color'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                const OutlinedButton(
                  onPressed: null,
                  child: Text('Disabled'),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Text Buttons Section
            _buildSectionTitle('Text Buttons'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Default'),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('With Icon'),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  child: const Text('Custom Color'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                const TextButton(
                  onPressed: null,
                  child: Text('Disabled'),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Icon Buttons Section
            _buildSectionTitle('Icon Buttons'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  tooltip: 'Add',
                ),
                IconButton.filled(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                  tooltip: 'Favorite',
                ),
                IconButton.filledTonal(
                  onPressed: () {},
                  icon: const Icon(Icons.star),
                  tooltip: 'Star',
                ),
                IconButton.outlined(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  tooltip: 'Edit',
                ),
                IconButton.filled(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.red[100],
                    foregroundColor: Colors.red,
                  ),
                  tooltip: 'Delete',
                ),
                IconButton(
                  onPressed: () {},
                  icon: const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                const IconButton(
                  onPressed: null,
                  icon: Icon(Icons.settings),
                  tooltip: 'Disabled',
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Floating Action Buttons Section
            _buildSectionTitle('Floating Action Buttons'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FloatingActionButton.small(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton.large(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton.extended(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Extended'),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Emergency-themed buttons
            _buildSectionTitle('TAGit Emergency Buttons'),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.local_hospital),
                  label: const Text('Emergency SOS'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                  ),
                ),
                const SizedBox(height: 12),
                FilledButton.tonalIcon(
                  onPressed: () {},
                  icon: const Icon(Icons.nfc),
                  label: const Text('Write to NFC Tag'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.phone),
                  label: const Text('Call Emergency Contact'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Usage guidelines
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue.shade700),
                        const SizedBox(width: 8),
                        Text(
                          'Button Usage Guidelines',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '• FilledButton: Primary actions (recommended)\n'
                      '• FilledButton.tonal: Secondary actions\n'
                      '• OutlinedButton: Medium emphasis actions\n'
                      '• TextButton: Low emphasis actions\n'
                      '• IconButton: Toolbar and compact actions\n'
                      '• FloatingActionButton: Main screen action',
                      style: TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
