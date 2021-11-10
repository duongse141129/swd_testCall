import 'package:advisories_lawyer/lawyer/infor_user.dart';
import 'package:advisories_lawyer/models/booking.dart';
import 'package:advisories_lawyer/models/network_lawyer/network_request.dart';
import 'package:advisories_lawyer/views/call_page.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerSchedule extends StatefulWidget {
  @override
  _SheduleState createState() => _SheduleState();
}

class _SheduleState extends State<CustomerSchedule> {
  List<Booking> bookingData = <Booking>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkRequest.fetachBookingOfCustomer(InforUser.getIdUser())
        .then((dataFromSever) {
      setState(() {
        bookingData = dataFromSever;
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
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  //list
                  itemCount: bookingData.length,
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
                                '${bookingData[index].id}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                'Lawyer ID ${bookingData[index].lawyerId} : ${bookingData[index].lawyerName} ',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                'Price: ${bookingData[index].totalPrice}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                'Ngày đặt: ${bookingData[index].bookingDate.substring(0, 10)}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              InkWell(
                                child: Icon(
                                  Icons.call,
                                  color: Colors.green,
                                ),
                                onTap: () async {
                                  var chanelNameToCall =
                                      await NetworkRequest.getChanelNameToCall(
                                          bookingData[index].id,
                                          InforUser.getRoleUser());

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CallPage(
                                              channelName: chanelNameToCall)));
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
