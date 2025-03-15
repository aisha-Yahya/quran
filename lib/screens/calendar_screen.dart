import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late String _gregorianDate;
  late String _hijriDate;

  @override
  void initState() {
    super.initState();
    _getDates();
  }

  void _getDates() {
    DateTime now = DateTime.now();
    _gregorianDate = DateFormat('yyyy-MM-dd').format(now); // التاريخ الميلادي

    HijriCalendar hijriCalendar = HijriCalendar.fromDate(now);
    _hijriDate =
        "${hijriCalendar.hYear}-${hijriCalendar.hMonth}-${hijriCalendar.hDay}"; // التاريخ الهجري
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("التقويم الهجري والميلادي")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDateCard("📅 التاريخ الميلادي", _gregorianDate),
            SizedBox(height: 20),
            _buildDateCard("🕌 التاريخ الهجري", _hijriDate),
          ],
        ),
      ),
    );
  }

  Widget _buildDateCard(String title, String date) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              date,
              style: TextStyle(fontSize: 18, color: Colors.blueAccent),
            ),
          ],
        ),
      ),
    );
  }
}
