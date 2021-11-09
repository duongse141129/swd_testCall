import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Lawyer>> fetchLawyer(int categoryID) async {
  final response = await http.get(Uri.parse(
      'https://104.215.186.78/api/v1/lawyers?CategoryIds=$categoryID&page_index=1&page_size=10'));

  print(response);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((lawyer) => Lawyer.fromJson(lawyer)).toList();
  } else {
    throw Exception('Fail to load');
  }
}

class Lawyer {
  final int id;
  final String name;
  final String email;
  final String address;
  final String location;
  final String description;
  final String phoneNumber;
  final String website;
  final String sex;
  final String dateOfBirth;
  final int status;
  final int lawyerOfficeId;
  final int levelId;
  final String dateOfBirthFormatted;
  final String lawyerOfficeName;
  final String level;
  final List<int> categoryIds;

  Lawyer({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.location,
    required this.description,
    required this.phoneNumber,
    required this.website,
    required this.sex,
    required this.dateOfBirth,
    required this.status,
    required this.lawyerOfficeId,
    required this.levelId,
    required this.dateOfBirthFormatted,
    required this.lawyerOfficeName,
    required this.level,
    required this.categoryIds,
  });

  factory Lawyer.fromJson(Map<String, dynamic> json) {
    return Lawyer(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        address: json['address'] ?? '',
        location: json['location'] ?? '',
        description: json['description'] ?? '',
        phoneNumber: json['phone_number'] ?? '',
        website: json['website'] ?? '',
        sex: json['sex'] ?? '',
        dateOfBirth: json['date_of_birth'] ?? '',
        status: json['status'] ?? '',
        lawyerOfficeId: json['lawyer_office_id'] ?? '',
        levelId: json['level_id'] ?? '',
        dateOfBirthFormatted: json['date_of_birth_formatted'],
        lawyerOfficeName: json['lawyer_office_name'],
        level: json['level'],
        categoryIds: json['category_ids'].cast<int>());
  }
  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
