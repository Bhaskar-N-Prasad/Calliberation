import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'notification_helper.dart';
import 'NotificationSummaryWidget.dart';
import 'package:gsheets/gsheets.dart';

// Create credentials
// Create credentials
const _credentials = r'''
{
  "type": "service_account",
  "project_id": "flutter-gsheets-423108",
  "private_key_id": "717acfc2868124f3085113ac224b62902f31c9de",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC9+sRMHNFCoeY0\n8l/j9RwqMC/bxlTHBTO+13uX3igpNSZzn6Tr2V1G7SMY2L2eUpy7Obozwr8Jz8W/\nlx7xOggCWJfdEOU89MMXUd7cgC4aK/eX3FqYvOQ3czdtUpj+uC8oIUSnhNdyaEPj\nDzBNzFTDwEOhjij/JbNxyUCWEmjC7t5lURzKVSvJXqvT7tYs81j/bzLisOFD37x/\nFZFaJ7fb3f9FmjFoKEEWsp2hhMeai5Zfl/3TVsw3qm6WmZfG541pzE0sCHNpL/g/\nzOWIW7Q+l7h0+0pgmhx2OSSaz+eRx9NUvoBRuIXrEWwriLBZT7pvBXgki7cJE4c4\nupE68d4XAgMBAAECggEADakhAVoXIAP1QjxlccZXwp7ZaiO+R9tTZ7cl73sthx0H\nyUui98SXBPkbS3eWVvKYy4uwnHU1+HYkwYyT0IO8PLLzJJXI7hOpjZ04+cELz5z2\nvkg9iXsXq/cQdr94OeSzm16dCbCvL05ZB1Q5xHZbaAIEuvK2dvZWi2mNx9zGBLI5\nrvPHF1Ld8uJ/pAbswFI+T5NMkvxWjrmN74kdw44BZ50pYTpk5pjSy8ElUUzx+PSR\n2PNJaGaUcgO5gUrol8A8ODrIptnUvvbJTU4o5uficMD+gIDRzoyjwAMVVqLxk7a1\n53EOiNZqQb4LeLteq2zmE7iWCN3ErC9gTJ5on+SQFQKBgQDpHTw4v8MDXxr+gmxy\nh+JLUe9trIBXKOCmCOwiz6un0ODXjRaH9owpeO9mY4YvwV4dBeRv+d6d1vOsGs9K\nYYSb6yyhl2BPig7l6RyjvahS6kG5k4zkDFCxwOC6svfh8/CQb6f/v5fdxatbCoi8\nUS/guK9uGRxI8H/1xk82xHotBQKBgQDQoXIwcSLcdP8CtrXtXnI7LwAn9N7HtHtR\nLjUYWOZSZImp2+QpKLjxo8uvtSqNpBLymX9GfDlBcLP2AjEI1LtpMteTX0jn0/bE\nKXdXfZKhpB0a234VGGzRzmy9JQYogsybg/yQYn0OX+OK9jOQ5vu5oK3kzvTmq3b+\nqjLKDeJpawKBgDDnrjull078w9gDGqdIdKQik11p5B7k94Q9uPRwpu1098ag1co+\nYhdNRMQxOvSH16u1EcCgJiDs+H/xu+052i0vwFRCQrVNHGUFa7m6Tzbd6F37Y4Jw\nRvmTolHou/JOT/itRAx2cHDZSGK4Kgl/6tB1TnCFmhZ/RgkUyoeN3qfVAoGAe/cC\nH7CJ006dW+Ju1R0iaPIzeIpyeV1PTNxU5iOkr15XwhsLRj2RLttxovTV1RWhwI7e\nZmZXqv+pnsqMkj+9H/P6zfF3I3D6FnLBG7ZckzktphC3qRc7SasLR5QhRZ76rolN\nYAl1Xz4wuRgzaa0l85V63hLux8UoToeY6CA54QMCgYEAnAYwQk3AwhAJ5EhvTvwT\nzhGBeKGb+nGOLPkfDAioDaWVEWMUuRpeBSbI5343qi9wXE8vPIwpZp50WIPeC2B9\n3NvThnha6ruv/v5DLp93ZL/47T6OfXZcyHCv5wLumvbk1G+78VfZz976Geb4KOUK\nuaOe+3+S6wSZWHmkoyoJf6o=\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-gsheets@flutter-gsheets-423108.iam.gserviceaccount.com",
  "client_id": "116678971925086303577",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheets%40flutter-gsheets-423108.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

// Spreadsheet ID
const _spreadsheetId = '1lMo8U0v_6Nzl_Uf3tyDsheLG4mfiRXaPMU_RKnXNrJU';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Google Sheets
  final gsheets = GSheets(_credentials);

  // Fetch spreadsheet by ID
  final ss = await gsheets.spreadsheet(_spreadsheetId);

  // Grab the worksheet by its title
  var sheet = ss.worksheetByTitle('Sheet1');

  // Fetch all values from the sheet
  final allRows = await sheet!.values.allRows() ?? [];

  runApp(MyApp(allRows: allRows));
}

class MyApp extends StatelessWidget {
  final List<List<String>> allRows;

  const MyApp({Key? key, required this.allRows}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Notification App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _idTagController = TextEditingController();
  final TextEditingController _refNumController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _lastCalibratedController = TextEditingController();
  final TextEditingController _daysUntilNextCalibrationController = TextEditingController();
  final TextEditingController _firstAlertController = TextEditingController();

  String _nextCalibrationDate = '#';

  void _calculateNextCalibrationDate() {
    try {
      final DateTime lastCalibrated = DateFormat('yyyy-MM-dd').parse(_lastCalibratedController.text);
      final int daysUntilNextCalibration = int.parse(_daysUntilNextCalibrationController.text);
      final DateTime nextCalibrationDate = lastCalibrated.add(Duration(days: daysUntilNextCalibration));

      setState(() {
        _nextCalibrationDate = DateFormat('yyyy-MM-dd').format(nextCalibrationDate);
      });
    } catch (e) {
      setState(() {
        _nextCalibrationDate = 'Invalid input';
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _lastCalibratedController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        _calculateNextCalibrationDate();
      });
    }
  }

  void _showNotificationSummary(BuildContext context, String alertType, DateTime notificationDate) {
    showDialog(
      context: context,
      builder: (context) {
        return NotificationSummaryWidget(
          name: _nameController.text,
          description: _descriptionController.text,
          idTag: _idTagController.text,
          refNum: _refNumController.text,
          department: _departmentController.text,
          room: _roomController.text,
          nextCalibrationDate: _nextCalibrationDate,
          notificationDate: notificationDate,
          alertType: alertType,
        );
      },
    ).then((_) {
      _clearFields();
    });
  }

  void _clearFields() {
    _nameController.clear();
    _descriptionController.clear();
    _idTagController.clear();
    _refNumController.clear();
    _departmentController.clear();
    _roomController.clear();
    _lastCalibratedController.clear();
    _daysUntilNextCalibrationController.clear();
    _firstAlertController.clear();
    setState(() {
      _nextCalibrationDate = '';
    });
  }

Future<void> _scheduleNotification1() async {
  if (_formKey.currentState!.validate()) {
    int firstAlertDays = int.parse(_firstAlertController.text);
    final DateTime nextCalibrationDate = DateFormat('yyyy-MM-dd').parse(_nextCalibrationDate);
    final DateTime firstAlertDate = nextCalibrationDate.subtract(Duration(days: firstAlertDays));

    NotificationHelper.scheduledNotification(
      'First Alert',
      'First alert for calibration',
      firstAlertDate,
    );

    // Insert data into Google Sheet
    final gsheets = GSheets(_credentials);
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    var sheet = ss.worksheetByTitle('Sheet1');

    // Convert DateTime to String
    String firstAlertDateString = firstAlertDate.toIso8601String();

    await sheet!.values.appendRow([
      _nameController.text,
      _descriptionController.text,
      _idTagController.text,
      _refNumController.text,
      _departmentController.text,
      _roomController.text,
      _lastCalibratedController.text,
      _daysUntilNextCalibrationController.text,
      _nextCalibrationDate,
      _firstAlertController.text,
      firstAlertDateString,
    ]);

    _showNotificationSummary(context, 'First Alert', firstAlertDate);
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _idTagController,
                decoration: const InputDecoration(labelText: 'ID Tag'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an ID tag';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _refNumController,
                decoration: const InputDecoration(labelText: 'Ref Num'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a reference number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _departmentController,
                decoration: const InputDecoration(labelText: 'Department'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a department';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _roomController,
                decoration: const InputDecoration(labelText: 'Room'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a room';
                  }
                  return null;
                },
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _lastCalibratedController,
                    decoration: const InputDecoration(labelText: 'Last Calibrated (yyyy-MM-dd)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the last calibrated date';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              TextFormField(
                controller: _daysUntilNextCalibrationController,
                decoration: const InputDecoration(labelText: 'Days Until Next Calibration'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the days until next calibration';
                  }
                  return null;
                },
                onChanged: (value) => _calculateNextCalibrationDate(),
              ),
              const SizedBox(height: 20),
              Text(
                'Next Calibration Date: $_nextCalibrationDate',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _firstAlertController,
                decoration: const InputDecoration(labelText: 'Days Prior for First Alert'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the days prior for the first alert';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  _scheduleNotification1();
                },
                child: const Text('Schedule Notification 1'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}