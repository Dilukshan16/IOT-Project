import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts'),
        actions: [
          TextButton(
            onPressed: () {
              // Clear all notifications
            },
            child: const Text(
              'Clear All',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '9:41 AM',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green[400],
                  ),
                ),
                // Fixed width using SizedBox instead of Container
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Receive notifications'),
                    value: true,
                    onChanged: (bool value) {
                      // Handle notification toggle
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildNotificationCard(
                  context,
                  binNumber: 'Bin #123',
                  message: 'is 90% full, collect now!',
                  time: '2 mins ago',
                  isUrgent: true,
                ),
                const SizedBox(height: 12),
                _buildNotificationCard(
                  context,
                  binNumber: 'Bin #456',
                  message: 'is 80% full',
                  time: '10 mins ago',
                  isUrgent: false,
                ),
                const SizedBox(height: 12),
                _buildNotificationCard(
                  context,
                  binNumber: 'Bin #789',
                  message: 'is 95% full, urgent!',
                  time: '5 mins ago',
                  isUrgent: true,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Notifications tab is active
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
         
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/dashboard');
              break;
            case 1:
              // Already on notifications
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/settings');
              break;
          }
        },
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context, {
    required String binNumber,
    required String message,
    required String time,
    required bool isUrgent,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isUrgent ? Colors.red.shade200 : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.delete,
                  color: isUrgent ? Colors.red : Colors.orange,
                  size: 24,
                ),
                const SizedBox(width: 8), // Proper spacing
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: binNumber,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isUrgent ? Colors.red : Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: ' $message',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8), // Proper spacing
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}