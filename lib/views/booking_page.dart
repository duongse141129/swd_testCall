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
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BookingPage extends StatefulWidget {
  late int lawyerID;
  late String lawyerName;
  CustomerCase customerCase;
  SlotDTO slotDto;
  late String questions;

  BookingPage(this.lawyerID, this.lawyerName, this.customerCase, this.slotDto,
      this.questions);

  @override
  _BookingPageState createState() => _BookingPageState(
      lawyerID: lawyerID,
      lawyerName: lawyerName,
      customerCase: customerCase,
      slotDto: slotDto,
      questions: questions);
}

class _BookingPageState extends State<BookingPage> {
  static const platform = const MethodChannel("razorpay_flutter");
  final user = FirebaseAuth.instance.currentUser!;

  late Razorpay _razorpay;
  _BookingPageState(
      {required this.lawyerID,
      required this.lawyerName,
      required this.customerCase,
      required this.slotDto,
      required this.questions});
  late String lawyerName;
  late int lawyerID;
  late CustomerCase customerCase;
  late SlotDTO slotDto;
  late String questions;
  late final Future<Users> userList;

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    userList = getUsers();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
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
      body: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      child: Wrap(
                        children: [
                          Text(
                              "Ngày đặt: " +
                                  date.day.toString() +
                                  " - " +
                                  date.month.toString() +
                                  " - " +
                                  date.year.toString(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                          DatePicker(
                            DateTime.now(),
                            height: 80,
                            initialSelectedDate: DateTime.now(),
                            selectedTextColor: Colors.white,
                            selectionColor: Colors.blue,
                            dateTextStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),

                    Card(
                        child: Container(
                            width: double.infinity,
                            height: 50,
                            child: buildFutureBuilder())),

                    // Text(
                    //   'Name: ' + lawyer.name,
                    //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    // ),

                    Card(
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(' Chủ đề: ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                            Text('    - ' + customerCase.name,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                            Text(' Nội dung: ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                            Text('    - ' + customerCase.description,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                            Text(' Câu hỏi: ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                            Text('    - ' + questions,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Wrap(
                        children: [
                          Text("Slot ID:" + slotDto.id.toString(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                          SizedBox(
                            width: 30,
                          ),
                          Text('Ngày hẹn: ' + slotDto.startAt.substring(0, 10),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Bắt đầu từ: ' +
                                        slotDto.startAt.substring(11),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  Text(
                                      'Kết thúc:     ' +
                                          slotDto.endAt.substring(11),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('Luật sư: ',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20)),
                                    Text(lawyerName.toString(),
                                        maxLines: 3,
                                        style: TextStyle(
                                            color: Colors.purpleAccent,
                                            fontSize: 20)),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Total Price:",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 30)),
                          Text(slotDto.price.toString(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 30)),
                        ],
                      ),
                    ),

                    ElevatedButton(
                      style: (ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      )),
                      onPressed: () async {
                        //var
                        //CustomerCase cusCase =await NetworkRequest.createCustomerCase(customerCase);
                        Future.delayed(Duration(seconds: 4),
                            () => 'Waiting import customer case');
                        print("is CS" + customerCase.toString());
                        //var inputFormat = DateFormat('dd/MM/yyyy HH:mm');
                        final df = new DateFormat('dd/MM/yyyy');
                        String dateTo = df.format(date);
                        Booking booking = new Booking(
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
                            customerCaseId: customerCase.id);

                        print(booking.toString());
                        booking = await NetworkRequest.createBooking(booking);
                        booking = await NetworkRequest.getBookingID(booking.id);

                        print("done infor" + booking.toString());
                        await NetworkRequest.createQuestion(booking, questions);
                        //Future.delayed(Duration(seconds: 4), () => 'Waiting import customer case');
                        await NetworkRequest.updateSlot(slotDto.id, booking.id);

                        openCheckout();
                      },
                      child: Text(
                        'Thanh toán',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  FutureBuilder<Users> buildFutureBuilder() {
    return FutureBuilder<Users>(
      future: userList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Khách hàng: ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    snapshot.data!.name.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                ],
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

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_nWIFRH8ira4IQB',
      'amount': slotDto.price * 100,
      'name': '${user.displayName}',
      'description': '${customerCase}',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '0363597619', 'email': '${user.email}'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "PAYMENT SUCCESS", toastLength: Toast.LENGTH_SHORT);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CustomerMain()));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
    print(response.code.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }
}
