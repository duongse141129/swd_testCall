// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// Future<Users> createUser(String username, String email) async {
//   final response = await http.put(
//       Uri.parse(
//           'https://104.215.186.78/api/v1/lawyers?page_index=3&page_size=1'),
//       body: {"username": username, "email": email});

//   print(response);

//   if (response.statusCode == 201) {
//     final String responeString = response.body;
//     return Users.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Fail to load');
//   }
// }

// class Users {
//   String username;
//   String role;
//   String name;
//   String address;
//   String location;
//   String description;
//   String phoneNumber;
//   String website;
//   String email;
//   String sex;
//   String dateOfBirth;
//   String dateOfBirthFormated;
//   int status;
//   int lawyerOfficeId;
//   int levelId;

//   Users(
//       {required this.username,
//       required this.role,
//       required this.name,
//       required this.address,
//       required this.location,
//       required this.description,
//       required this.phoneNumber,
//       required this.website,
//       required this.email,
//       required this.sex,
//       required this.dateOfBirth,
//       required this.dateOfBirthFormated,
//       required this.status,
//       required this.lawyerOfficeId,
//       required this.levelId});

//   factory Users.fromJson(Map<String, dynamic> json) {
//     return Users(
//         username: json['username'],
//         role: json['role'],
//         name: json['name'],
//         address: json['address'],
//         location: json['location'],
//         description: json['description'],
//         phoneNumber: json['phone_number'],
//         website: json['website'],
//         email: json['email'],
//         sex: json['sex'],
//         dateOfBirth: json['date_of_birth'],
//         dateOfBirthFormated: json['date_of_birth_formated'],
//         status: json['status'],
//         lawyerOfficeId: json['lawyer_office_id'],
//         levelId: json['level_id']);
//   }
//   @override
//   String toString() {
//     // TODO: implement toString
//     return super.toString();
//   }
// }
