import 'package:advisories_lawyer/lawyer/infor_user.dart';
import 'package:advisories_lawyer/lawyer/model_lawyer/slot.dart';
import 'package:advisories_lawyer/models/booking.dart';
import 'package:advisories_lawyer/models/customer_case.dart';
import 'package:advisories_lawyer/models/lawyer.dart';
import 'package:advisories_lawyer/models/network_lawyer/network_request.dart';
import 'package:advisories_lawyer/models/slot.dart';
import 'package:advisories_lawyer/provider/google_sign_in.dart';
import 'package:advisories_lawyer/views/home_page.dart';
import 'package:advisories_lawyer/views/main_customer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  late int lawyerID;
  CustomerCase customerCase;
  SlotDTO slotDto;
  BookingPage(this.lawyerID, this.customerCase,this.slotDto);

  @override
  _BookingPageState createState() =>
      _BookingPageState(lawyerID: lawyerID, customerCase: customerCase,slotDto: slotDto);
}

class _BookingPageState extends State<BookingPage> {
  _BookingPageState({required this.lawyerID, required this.customerCase, required this.slotDto});
  late int lawyerID;
  late CustomerCase customerCase;
  late SlotDTO slotDto;
  late final Future<Users> userList;
  @override
  void initState() {
    userList = getUsers();
  }

  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    //final lawyer = ModalRoute.of(context)!.settings.arguments as Lawyer;
    // final user = ModalRoute.of(context)!.settings.arguments as Users;
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Page'),
        backgroundColor: Colors.purple[400],
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildFutureBuilder(),
                Text(
                  'Lawyer ID: ' + lawyerID.toString(),
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                // Text(
                //   'Name: ' + lawyer.name,
                //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                // ),
                Text(
                    "Ngày chọn: " +
                        date.day.toString() +
                        " - " +
                        date.month.toString() +
                        " - " +
                        date.year.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                  Text(customerCase.name),
                  Text(customerCase.description),

                  Text("Slot ID:"+ slotDto.id.toString()),
                  Text(slotDto.startAt),
                  Text(slotDto.endAt),
                  Text("Total Price:"),
                  Text(slotDto.price.toString()),
                  ElevatedButton(
                      style: (ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      )),
                      onPressed: () async {
                        //var 
                        CustomerCase cusCase= await NetworkRequest.createCustomerCase(customerCase);
                        Future.delayed(Duration(seconds: 4), () => 'Waiting import customer case'); 
                        print("is CS"+cusCase.toString());
                        //var inputFormat = DateFormat('dd/MM/yyyy HH:mm');
                        final df = new DateFormat('dd/MM/yyyy');
                        String dateTo= df.format(date);
                        Booking booking=new Booking(
                          id: 0, 
                          customerId: InforUser.getIdUser(), 
                          customerName: InforUser.getNameUser(), 
                          lawyerId: lawyerID, 
                          lawyerName: "", 
                          bookingDate: dateTo, 
                          paymentMethod: "Momo", 
                          totalPrice: slotDto.price, 
                          payDate: dateTo, 
                          status: 1, 
                          customerCaseId: cusCase.id);

                        print(booking.toString());
                        booking= await NetworkRequest.createBooking(booking);
                        booking= await NetworkRequest.getBookingID(booking.id);
                        print("done infor"+booking.toString());
                        //Future.delayed(Duration(seconds: 4), () => 'Waiting import customer case'); 
                        await NetworkRequest.updateSlot(slotDto.id, booking.id);


                        
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomerMain()));
                      },
                      child: Text(
                        'Thanh toán',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
              ],
            ),
          )),
    );
  }

  FutureBuilder<Users> buildFutureBuilder() {
    return FutureBuilder<Users>(
      future: userList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title: " + snapshot.data!.toString(),
                style: TextStyle(fontSize: 20),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
