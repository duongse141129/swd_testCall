import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SlotPage extends StatefulWidget {
  const SlotPage({Key? key}) : super(key: key);

  @override
  _SlotPageState createState() => _SlotPageState();
}

class _SlotPageState extends State<SlotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer case'),
        backgroundColor: Colors.purple[400],
        centerTitle: true,
      ),
      body: SfCalendar(
        view: CalendarView.week,
        firstDayOfWeek: 6,
      ),
    );
  }
}
