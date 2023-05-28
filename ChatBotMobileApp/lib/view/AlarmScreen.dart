import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'EmergencyCallScreen.dart';

class AlarmScreen extends StatefulWidget {
  final Function(String, int, int, String) onAlarmAdded;

  const AlarmScreen({Key? key, required this.onAlarmAdded}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  late int _alarmHour;
  late int _alarmMinute;
  late String _alarmName;
  late String _alarmDay;

  final List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

  @override
  void initState() {
    super.initState();
    final DateTime now = DateTime.now();
    _alarmHour = now.hour;
    _alarmMinute = now.minute;
    _alarmName = '';
    _alarmDay = days[0];
  }

  void _addAlarm() {
    FlutterAlarmClock.createAlarm(_alarmHour, _alarmMinute);
    widget.onAlarmAdded(_alarmName, _alarmHour, _alarmMinute, _alarmDay);
    setState(() {
      _alarmName = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE8E8E8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'New Alarm',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  _alarmName = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Alarm Name',
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Time',
                  style: TextStyle(fontSize: 16.0),
                ),
                DropdownButton<int>(
                  value: _alarmHour,
                  onChanged: (value) {
                    setState(() {
                      _alarmHour = value!;
                    });
                  },
                  items: List<DropdownMenuItem<int>>.generate(
                    24,
                        (index) => DropdownMenuItem<int>(
                      value: index,
                      child: Text(index.toString().padLeft(2, '0')),
                    ),
                  ),
                ),
                const Text(
                  ':',
                  style: TextStyle(fontSize: 16.0),
                ),
                DropdownButton<int>(
                  value: _alarmMinute,
                  onChanged: (value) {
                    setState(() {
                      _alarmMinute = value!;
                    });
                  },
                  items: List<DropdownMenuItem<int>>.generate(
                    60,
                        (index) => DropdownMenuItem<int>(
                      value: index,
                      child: Text(index.toString().padLeft(2, '0')),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Day',
                  style: TextStyle(fontSize: 16.0),
                ),
                DropdownButton<String>(
                  value: _alarmDay,
                  onChanged: (value) {
                    setState(() {
                      _alarmDay = value!;
                    });
                  },
                  items: days.map((day) {
                    return DropdownMenuItem<String>(
                      value: day,
                      child: Text(day),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _addAlarm,
              child: const Text('Confirm'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: (){
                  Get.to(EmergencyCallScreen());
                },
                child: Text('Call Emergency Assistance'),

            )
          ],
        ),
      ),
    );
  }
}
