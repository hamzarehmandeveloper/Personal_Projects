import 'package:flutter/material.dart';



class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Replace this sample data with actual notifications fetched from your backend or database
  List<NotificationItem> _notifications = [
    NotificationItem(
      title: 'New Job Posted',
      message: 'A new job has been posted in your area.',
      timestamp: DateTime.now().subtract(Duration(minutes: 30)),
    ),
    NotificationItem(
      title: 'Proposal Accepted',
      message: 'Your proposal has been accepted for Job XYZ.',
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return Card(
            child: ListTile(
              title: Text(notification.title),
              subtitle: Text(notification.message),
              trailing: Text(
                _formatTimestamp(notification.timestamp),
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              onTap: () {
                // Add code to navigate to the job or proposal details page
              },
            ),
          );
        },
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    Duration timeDiff = DateTime.now().difference(timestamp);
    if (timeDiff.inMinutes < 60) {
      return '${timeDiff.inMinutes}m ago';
    } else if (timeDiff.inHours < 24) {
      return '${timeDiff.inHours}h ago';
    } else {
      return '${timeDiff.inDays}d ago';
    }
  }
}

class NotificationItem {
  final String title;
  final String message;
  final DateTime timestamp;

  NotificationItem({required this.title, required this.message, required this.timestamp});
}
