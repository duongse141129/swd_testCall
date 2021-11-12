import 'package:flutter/material.dart';

class AdvisoryDTO {
  int id;
  int customerId;
  int lawyerId;
  String question;
  String answer;
  int bookingId;
  int status;

  AdvisoryDTO(
      {required this.id,
      required this.customerId,
      required this.lawyerId,
      required this.question,
      required this.answer,
      required this.bookingId,
      required this.status});

  factory AdvisoryDTO.fromJson(Map<String, dynamic> json) {
    return AdvisoryDTO(
        id : json['id'],
        customerId: json['customer_id'],
        lawyerId: json['lawyer_id'],
        question: json['question'] ?? "",
        answer: json['answer'] ?? "",
        bookingId: json['booking_id'],
        status: json['status']);
  }
  


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['lawyer_id'] = this.lawyerId;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['booking_id'] = this.bookingId;
    data['status'] = this.status;
    return data;
  }
}
