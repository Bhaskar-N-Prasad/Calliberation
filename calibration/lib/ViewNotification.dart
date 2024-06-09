import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ViewNotification extends StatefulWidget {
  const ViewNotification({super.key});

  @override
  _ViewNotificationState createState() => _ViewNotificationState();
}

class _ViewNotificationState extends State<ViewNotification> {
  List<PendingNotificationRequest> _pendingNotifications = [];
  
  get flutterLocalNotificationsPlugin => null;

  Future<void> _checkPendingNotificationRequests() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    setState(() {
      _pendingNotifications = pendingNotificationRequests;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkPendingNotificationRequests(); // Fetch notifications when the screen is loaded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Notifications'),
      ),
      body: _pendingNotifications.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _pendingNotifications.length,
              itemBuilder: (context, index) {
                final notification = _pendingNotifications[index];
                return ListTile(
                  title: Text(notification.title ?? 'No Title'),
                  subtitle: Text(notification.body ?? 'No Body'),
                  trailing: Text('ID: ${notification.id}'),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()), // Show a loading indicator while fetching data
    );
  }
}

class PaddedElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const PaddedElevatedButton({
    required this.buttonText,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(buttonText),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Notification App')),
      body: Center(
        child: Builder(
          builder: (context) {
            return PaddedElevatedButton(
              buttonText: 'Check pending notifications',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewNotification()),
                );
              },
            );
          },
        ),
      ),
    ),
  ));
}
