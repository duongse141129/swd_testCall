import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<CustomerCase> createCustomerCase(String name, String description) async {
  final response = await http.post(
    Uri.parse('https://104.215.186.78/api/v1/customer-cases'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'description': description,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return CustomerCase.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class CustomerCase {
  final int id;
  final String name;
  final String description;

  CustomerCase({required this.id,required this.name, required this.description});

  factory CustomerCase.fromJson(Map<String, dynamic> json) {
    return CustomerCase(id: json['id'],name: json['name'], description: json['description']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return "CustomerCase: "+id.toString()+"-"+name+"-"+description;
  }
}
