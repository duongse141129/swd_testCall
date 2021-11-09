import 'package:advisories_lawyer/lawyer/addslot.dart';
import 'package:advisories_lawyer/lawyer/model_lawyer/booking.dart';
import 'package:advisories_lawyer/lawyer/model_lawyer/slot.dart';
import 'package:advisories_lawyer/lawyer/network_lawyer/network_request.dart';
import 'package:advisories_lawyer/views/home_page.dart';
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
  List<SlotDTO> slotData = <SlotDTO>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkRequest.fetachSlot().then((dataFromSever) {
      setState(() {
        slotData = dataFromSever;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  //list
                  itemCount: slotData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${slotData[index].id}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                '${slotData[index].lawyerId}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                '${slotData[index].price}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                '${slotData[index].startAt}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                '${slotData[index].endAt}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                '${slotData[index].bookingId == 0 ?"Trống" : "đã có người thuê"}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
             

                              InkWell(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  if (slotData[index].bookingId == 0) {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('AlertDialog Title'),
                                        content: const Text(
                                            'AlertDialog description'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop( context),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              NetworkRequest.deleteSlot(slotData[index].id);
                                              Navigator.pop( context);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Thông báo '),
                                        content: const Text(
                                            'Không thế xóa khi đã có người đặt lịch'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              )
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

  /*String getNameOfCustomerBooking(int bookingID){

    String result="";
    if(bookingID == 0){
      return "Trống";
    }
    else{
      BookingDTO bookingDTO=NetworkRequest.fetachNameCusByBookingID(bookingID) as BookingDTO;
      result= bookingDTO.customerName;
    }
    return result;

  }*/
}
