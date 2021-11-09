import 'package:advisories_lawyer/lawyer/addslot.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class LawyerSchedule extends StatefulWidget {
  @override
  _SheduleState createState() => _SheduleState();
}

class _SheduleState extends State<LawyerSchedule> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(DateFormat.yMMMMd().format(DateTime.now()),
                            style: TextStyle(color: Colors.grey, fontSize: 15)),
                        Text(
                          "Today",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddSlotTask()));
                    },
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff4e5ae8)),
                      child: Center(
                          child: Text(
                        "+ Add task",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 15, right: 10),
              child: DatePicker(
                DateTime.now(),
                height: 100,
                initialSelectedDate: DateTime.now(),
                selectedTextColor: Colors.white,
                selectionColor: Colors.blue,
                dateTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddSlotTask()));
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff4e5ae8)),
                    child: Center(
                        child: Text(
                      "+ Add task",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
              ),
            ),*/
            Container(
              padding: EdgeInsets.only(left: 30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular((30)),
                      topRight: Radius.circular((30))),
                  color: Color(0xff30384c)),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text(
                          "Task today",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      serviceTask(
                          "8:00 AM",
                          "advice for Tom",
                          CupertinoIcons.check_mark_circled_solid,
                          Color(0xff00cf8d)),
                      serviceTask("10:00 AM", "meeting the department",
                          Icons.radio_button_unchecked, Color(0xff00cf8d)),
                      serviceTask("13:00 PM", "advice for Tom2",
                          Icons.radio_button_unchecked, Color(0xff00cf8d)),
                      serviceTask(
                          "15:00 PM",
                          "advice for Tom3",
                          CupertinoIcons.check_mark_circled_solid,
                          Color(0xff00cf8d)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container serviceTask(
      String timeTask, String description, IconData iconData, Color colorIcon) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          Icon(
            iconData,
            color: colorIcon,
            size: 30,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('$timeTask',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Text('$description',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold))
              ],
            ),
          )
        ],
      ),
    );
  }
}
