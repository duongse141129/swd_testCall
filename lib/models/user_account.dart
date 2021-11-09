// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// Future<List<Users>> fetchUser() async {
//   final response = await http.get(Uri.parse(
//       'https://104.215.186.78/api/v1/user-accounts?page_index=1&page_size=5'));

//   print(response);

//   if (response.statusCode == 200) {
//     List jsonResponse = json.decode(response.body);
//     return jsonResponse.map((users) => Users.fromJson(users)).toList();
//   } else {
//     throw Exception('Fail to load');
//   }
// }

// class Users {
//   final String name;
//   final String email;
//   final String role;

//   Users(this.name, this.email, this.role);

//   Users.fromJson(Map<String, dynamic> json)
//       : name = json['display_name'],
//         email = json['email'],
//         role = json['role'];

//   Map<String, dynamic> toJson() => {
//         'name': name,
//         'email': email,
//         'role': role,
//       };
// }
