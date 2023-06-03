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
    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
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
                UnicornOutlineButton(

                  onPressed: _addAlarm,
                  color: const Color(0xFF15e0c3),
                  strokeWidth: 2,
                  radius: 24,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF53abef), Color(0xFF4a7ff8)]),
                  child: const Text('Confirm',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                UnicornOutlineButton(
                    onPressed: (){
                      Get.to(EmergencyCallScreen());
                    },
                  color: const Color(0xFF15e0c3),
                  strokeWidth: 2,
                  radius: 24,
                  gradient: const LinearGradient(
                      colors: [Color(0xFF53abef), Color(0xFF4a7ff8)]),
                    child: const Text('Call Emergency Assistance',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class UnicornOutlineButton extends StatelessWidget {
  final _GradientPainter _painter;
  final Widget _child;
  final VoidCallback _callback;
  final double _radius;

  UnicornOutlineButton({
    required double strokeWidth,
    required double radius,
    required Color color,
    required Gradient gradient,
    required Widget child,
    required VoidCallback onPressed,
  })  : this._painter = _GradientPainter(
    strokeWidth: strokeWidth,
    radius: radius,
    gradient: gradient,
    color: color,
  ),
        this._child = child,
        this._callback = onPressed,
        this._radius = radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _callback,
        child: Container(
          constraints: BoxConstraints(minWidth: 200, minHeight: 55),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _child,
            ],
          ),
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Color color;
  final Gradient gradient;

  _GradientPainter({
    required double strokeWidth,
    required double radius,
    required Gradient gradient,
    required Color color,
  })  : this.strokeWidth = strokeWidth,
        this.radius = radius,
        this.gradient = gradient,
        this.color = color;

  @override
  void paint(Canvas canvas, Size size) {
    Rect outerRect = Offset.zero & size;
    var outerRRect = RRect.fromRectAndRadius(
      outerRect,
      Radius.circular(radius),
    );

    _paint.shader = gradient.createShader(outerRect);
    _paint.strokeWidth = strokeWidth;
    _paint.style = PaintingStyle.fill;
    _paint.color = color;

    canvas.drawRRect(outerRRect, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
