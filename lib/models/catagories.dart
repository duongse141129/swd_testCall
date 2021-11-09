import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Catagories>> fetchCatagories() async {
  final response = await http.get(Uri.parse(
      'https://104.215.186.78/api/v1/categories?page_index=1&page_size=5'));

  print(response);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse
        .map((catagories) => Catagories.fromJson(catagories))
        .toList();
  } else {
    throw Exception('Fail to load');
  }
}

class Catagories {
  int id;
  String categoryName;

  Catagories({required this.id, required this.categoryName});

  factory Catagories.fromJson(Map<String, dynamic> json) {
    return Catagories(id: json['id'], categoryName: json['category_name']);
  }
}
