import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Booking>> fetchBooking() async {
  final response =
      await http.get(Uri.parse('https://104.215.186.78/api/v1/bookings'));

  print(response);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse
        .map((booking) => new Booking.fromJson(booking))
        .toList();
  } else {
    throw Exception('Fail to load');
  }
}

Future<Booking> createCustomerCase(
    String customerId,
    String bookingDate,
    String paymentMethod,
    String totalPrice,
    String payDate,
    String status,
    String customerCaseID) async {
  final response = await http.post(
    Uri.parse('https://104.215.186.78/api/v1/customer-cases'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'customer_id': customerId,
      'booking_date': bookingDate,
      'payment_method': paymentMethod,
      'pay_date': payDate,
      'customer_case_id': customerCaseID,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Booking.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Booking{
  int id;
  int customerId;
  String customerName;
  int lawyerId;
  String lawyerName;
  String bookingDate;
  String paymentMethod;
  int totalPrice;
  String payDate;
  int status;
  int customerCaseId;

  Booking(
      {required this.id,
      required this.customerId,
      required this.customerName,
      required this.lawyerId,
      required this.lawyerName,
      required this.bookingDate,
      required this.paymentMethod,
      required this.totalPrice,
      required this.payDate,
      required this.status,
      required this.customerCaseId});

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id : json['id'],
      customerId : json['customer_id'],
      customerName :json['customer_name'] ?? "",
      lawyerId : json['lawyer_id'],
      lawyerName : json['lawyer_name'] ?? "",
      bookingDate : json['booking_date'],
      paymentMethod : json['payment_method'],
      totalPrice : json['total_price'],
      payDate : json['pay_date'],
      status : json['status'],
      customerCaseId : json['customer_case_id']
    );
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
      data['id'] = this.id;
      data['customer_id'] = this.customerId;
      data['customer_name'] = this.customerName;
      data['lawyer_id'] = this.lawyerId;
      data['lawyer_name'] = this.lawyerName;
      data['booking_date'] = this.bookingDate;
      data['payment_method'] = this.paymentMethod;
      data['total_price'] = this.totalPrice;
      data['pay_date'] = this.payDate;
      data['status'] = this.status;
      data['customer_case_id'] = this.customerCaseId;
    return data;
  }

  @override
  String toString() {
    
    return "BookingDTO:"+id.toString()+"-"+customerId.toString()+"-"+customerName+"-"+lawyerId.toString()+"-"+lawyerName+"-"+bookingDate+"-"+payDate+"-"+customerCaseId.toString();
  }



}
