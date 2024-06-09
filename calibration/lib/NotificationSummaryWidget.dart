import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationSummaryWidget extends StatelessWidget {
  final String name;
  final String description;
  final String idTag;
  final String refNum;
  final String department;
  // final String area;
  final String room;
  final String nextCalibrationDate;
  final DateTime notificationDate;
  final String alertType;

  const NotificationSummaryWidget({
    Key? key,
    required this.name,
    required this.description,
    required this.idTag,
    required this.refNum,
    required this.department,
    // required this.area,
    required this.room,
    required this.nextCalibrationDate,
    required this.notificationDate,
    required this.alertType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('$alertType Notification Set'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Name: $name'),
            Text('Description: $description'),
            Text('ID Tag: $idTag'),
            Text('Ref Num: $refNum'),
            Text('Department: $department'),
            // Text('Area: $area'),
            Text('Room: $room'),
            Text('Next Calibration Date: $nextCalibrationDate'),
            Text('Notification Date: ${DateFormat('yyyy-MM-dd').format(notificationDate)}'),
            const SizedBox(height: 20),
            const Text('Notification has been set successfully!', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
