import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Doc>> fetchDoc(int cateid) async {
  final response = await http.get(Uri.parse(
      'https://104.215.186.78/api/v1/documents?category_id=$cateid&page_index=1&page_size=10'));

  print(response);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((doc) => Doc.fromJson(doc)).toList();
  } else {
    throw Exception('Fail to load');
  }
}

Future<Doc> createDoc(String name, String description) async {
  final response = await http.post(
    Uri.parse('https://104.215.186.78/api/v1/documents'),
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
    return Doc.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create doc.');
  }
}

class Doc {
  final int id;
  final String name;
  final String description;
  final int category_id;

  Doc(
      {this.id = 0,
      required this.name,
      required this.description,
      required this.category_id});

  factory Doc.fromJson(Map<String, dynamic> json) {
    return Doc(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        category_id: json['category_id']);
  }
  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
