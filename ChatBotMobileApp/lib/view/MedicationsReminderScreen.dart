import 'package:flutter/material.dart';
import 'AlarmScreen.dart';

class MedicationReminder extends StatefulWidget {
  @override
  _MedicationReminderState createState() => _MedicationReminderState();
}

class _MedicationReminderState extends State<MedicationReminder> {
  List<String> alarms = [];

  void addAlarm(String alarmName, int hour, int minute, String day) {
    setState(() {
      String alarm = '$alarmName - ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} ($day)';
      alarms.add(alarm);
    });
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      context: context,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: AlarmScreen(
            onAlarmAdded: addAlarm,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF53abef), Color(0xFF4a7ff8)],
            ),
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFF6F8FC),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: TopContainer(),
            ),
            SizedBox(height: 10),
            Flexible(
              flex: 7,
              child: ListView.builder(
                itemCount: alarms.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(alarms[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF53abef), Color(0xFF4a7ff8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          elevation: 4,
          child: const Icon(Icons.add),
          onPressed: () {
            _showBottomSheet(context);
          },
        ),
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  const TopContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF53abef), Color(0xFF4a7ff8)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(50, 27),
          bottomRight: Radius.elliptical(50, 27),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey,
            offset: Offset(0, 3.5),
          ),
        ],
      ),
      width: double.infinity,
      height: 200,
      child: Column(
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "Mediminder",
              style: TextStyle(
                fontFamily: "coolvetica",
                fontSize: 64,
                color: Colors.white,
              ),
            ),
          ),
          Divider(
            color: Color(0xFFB0F3CB),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Center(
              child: Text(
                "Number of Mediminders",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
