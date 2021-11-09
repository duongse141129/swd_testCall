import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Slot>> fetchLawyer() async {
  final response = await http.get(Uri.parse(
      'https://104.215.186.78/api/v1/slots?page_index=1&page_size=10'));

  print(response);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((slot) => Slot.fromJson(slot)).toList();
  } else {
    throw Exception('Fail to load');
  }
}

DateTime _convertDateFromString(String date) {
  return DateTime.parse(date);
}

class Slot {
  final int id;
  final int bookingId;
  final DateTime startAt;
  final String startAtFormatted;
  final DateTime endAt;
  final String endAtFormatted;
  final int price;
  final int lawyerId;
  final int status;

  Slot(
      {required this.id,
      required this.bookingId,
      required this.startAt,
      required this.startAtFormatted,
      required this.endAt,
      required this.endAtFormatted,
      required this.price,
      required this.lawyerId,
      required this.status});

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
        id: json['id'],
        bookingId: json['booking_id'],
        startAt: json['start_at'],
        startAtFormatted: json['start_at_formatted'],
        endAt: json['end_at'],
        endAtFormatted: json['end_at_formatted'],
        price: json['price'],
        lawyerId: json['lawyer_id'],
        status: json['status']);
  }
}
