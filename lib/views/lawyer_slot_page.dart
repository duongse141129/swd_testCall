import 'dart:ui';

import 'package:advisories_lawyer/lawyer/addslot.dart';
import 'package:advisories_lawyer/lawyer/infor_user.dart';
import 'package:advisories_lawyer/lawyer/model_lawyer/slot.dart';
import 'package:advisories_lawyer/models/customer_case.dart';
import 'package:advisories_lawyer/models/lawyer.dart';
import 'package:advisories_lawyer/models/network_lawyer/network_request.dart';
import 'package:advisories_lawyer/views/booking_page.dart';
import 'package:advisories_lawyer/views/home_page.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class LawyerListSchedule extends StatefulWidget {
  late int lawyerID;
  late String lawyerName;
  late CustomerCase customerCase;
  late String questions;

  LawyerListSchedule(this.lawyerID, this.lawyerName, this.customerCase,this.questions);
  @override
  _LawyerListSheduleState createState() => _LawyerListSheduleState(
      lawyerID: lawyerID, lawyerName: lawyerName, customerCase: customerCase, questions: questions);
}

class _LawyerListSheduleState extends State<LawyerListSchedule> {
  _LawyerListSheduleState({
    required this.lawyerID,
    required this.lawyerName,
    required this.customerCase,
    required this.questions
  });
  late int lawyerID;
  late String lawyerName;
  late CustomerCase customerCase;
  late String questions;
  List<SlotDTO> slotData = <SlotDTO>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkRequest.fetachSlot(lawyerID).then((dataFromSever) {
      setState(() {
        slotData = dataFromSever;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slot'),
        backgroundColor: Colors.purple[400],
        centerTitle: true,
      ),
      body: Column(
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
                      Text(
                        "Danh sách các slot",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      )
                    ],
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => AddSlotTask()));
                //   },
                //   child: Container(
                //     width: 100,
                //     height: 40,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color: Color(0xff4e5ae8)),
                //     child: Center(
                //         child: Text(
                //       "+ Add task",
                //       style: TextStyle(color: Colors.white),
                //     )),
                //   ),
                // ),
              ],
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(top: 10, left: 15, right: 10),
          //   child: DatePicker(
          //     DateTime.now(),
          //     height: 100,
          //     initialSelectedDate: DateTime.now(),
          //     selectedTextColor: Colors.white,
          //     selectionColor: Colors.blue,
          //     dateTextStyle: TextStyle(
          //         fontSize: 20,
          //         fontWeight: FontWeight.w600,
          //         color: Colors.grey),
          //   ),
          // ),
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
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  //list
                  itemCount: slotData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          if (slotData[index].bookingId == 0) {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return BookingPage(lawyerID, lawyerName,
                                    customerCase, slotData[index], questions);
                              },
                            ));
                          } else {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Thông báo'),
                                content: const Text('Slot này đã được đặt'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Xác nhận'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Slot in day',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              DatePicker(
                                DateTime.parse(slotData[index].startAt),
                                height: 80,
                                initialSelectedDate:
                                    DateTime.parse(slotData[index].startAt),
                                selectedTextColor: Colors.white,
                                selectionColor: Colors.blue,
                                dateTextStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                              ),
                              Text(
                                'Price: ${slotData[index].price}',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              Text(
                                'Start at: ${slotData[index].startAt.substring(11)}',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              Text(
                                'End at: ${slotData[index].endAt.substring(11)}',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              sendText(slotData[index].bookingId),
                            ],
                          ),
                        ),
                      ),
                    );
                  }))
        ],
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

  // String changeString(int bookingID) {
  //   if (bookingID == 1) {
  //     return "Đã đặt";
  //   } else {
  //     return "Chưa đặt";
  //   }
  // }

  Text sendText(int bookingID) {
    if (bookingID >= 1) {
      return Text(
        "Đã đặt",
        style: TextStyle(color: Colors.red, fontSize: 18),
      );
    } else {
      return Text("Chưa đặt",
          style: TextStyle(color: Colors.green, fontSize: 18));
    }
  }
}
