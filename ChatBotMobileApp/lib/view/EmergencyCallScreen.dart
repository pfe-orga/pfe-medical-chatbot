import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class EmergencyCallScreen extends StatefulWidget {
  const EmergencyCallScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyCallScreen> createState() => _EmergencyCallScreenState();
}

class _EmergencyCallScreenState extends State<EmergencyCallScreen> {
  late int _alarmHour;
  late int _alarmMinute;
  String _phoneNumber = '';
  final List<String> _phoneNumbers = [];

  @override
  void initState() {
    super.initState();
    // set the initial values for the alarm time
    final currentTime = DateTime.now();
    _alarmHour = currentTime.hour;
    _alarmMinute = currentTime.minute;
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(25),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Call 197 For Emergency',
                ),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  setState(() {
                    _phoneNumber = value;
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _callNumber();
              },
              child: const Text('Call'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _phoneNumbers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_phoneNumbers[index]),
                  );
                },
              ),
            ),
          ],
        ),
      );
  }
  void _callNumber() async {
    final url = 'tel:197';
    if (await canLaunch(url)) {
      await launch(url);
      setState(() {
        _phoneNumbers.add('197');
        _phoneNumber = ''; // clear the phone number field
      });
    } else {
      // Failed to launch the URL
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to call 197')),
      );
    }
  }
}