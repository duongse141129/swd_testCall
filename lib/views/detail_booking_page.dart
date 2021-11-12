import 'package:advisories_lawyer/lawyer/model_lawyer/slot.dart';
import 'package:advisories_lawyer/models/booking.dart';
import 'package:advisories_lawyer/models/network_lawyer/network_request.dart';
import 'package:advisories_lawyer/models/slot.dart';
import 'package:advisories_lawyer/views/profile_of_cuscase.dart';
import 'package:advisories_lawyer/views/profile_of_lawyer.dart';
import 'package:flutter/material.dart';

class DetailOfBooking extends StatefulWidget {
  final Booking bookingDTO;
  const DetailOfBooking(this.bookingDTO);

  @override
  _DetailOfBookingState createState() =>
      _DetailOfBookingState(bookingDTO: bookingDTO);
}

class _DetailOfBookingState extends State<DetailOfBooking> {
  late final Booking bookingDTO;
  _DetailOfBookingState({required this.bookingDTO});
  List<SlotDTO> slotData = <SlotDTO>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkRequest.fetachSlotByBooingID(bookingDTO.id).then((dataFromSever) {
      setState(() {
        slotData = dataFromSever;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Detail"),
        backgroundColor: Colors.purple[400],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            child: Row(
              children: [
                Container(
                  width: 15,
                  height: 10,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(5),
                      )),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              text:
                                  "Ngày đặt: ${bookingDTO.bookingDate.substring(0, 10)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              children: [])),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.only(right: 10, left: 30),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Booking ID: ${bookingDTO.id}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "     + Có hẹn với luật sư: ${bookingDTO.lawyerName}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  "     + Giá: ${bookingDTO.totalPrice}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: (ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            )),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfileLawyerInBooking(bookingDTO.lawyerId)));
            },
            child: Text(
              'Profile of Lawyer',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            style: (ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            )),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileOfCustomerCase(
                          bookingDTO.customerCaseId, bookingDTO.id)));
            },
            child: Text(
              'Profile of CustomerCase',
              style: TextStyle(color: Colors.white),
            ),
          ),
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
                                '${"Date: " + slotData[index].startAt.substring(0, 10)}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                '${"Time: " + slotData[index].startAt.substring(11, 16)}  - ${slotData[index].endAt.substring(11, 16)}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                '${"Price: " + slotData[index].price.toString()}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                'ID: ${slotData[index].id}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
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
}
