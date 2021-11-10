import 'dart:convert';
import 'dart:io';

import 'package:advisories_lawyer/lawyer/infor_user.dart';
import 'package:advisories_lawyer/lawyer/model_lawyer/category.dart';
import 'package:advisories_lawyer/lawyer/model_lawyer/document.dart';
import 'package:advisories_lawyer/lawyer/model_lawyer/post.dart';
import 'package:advisories_lawyer/lawyer/model_lawyer/slot.dart';
import 'package:advisories_lawyer/models/booking.dart';

import 'package:advisories_lawyer/models/customer_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class NetworkRequest {
  static const String url = 'https://jsonplaceholder.typicode.com/posts';
  static const String urlCategory =
      'https://104.215.186.78/api/v1/categories?page_index=1&page_size=20';
  static const String urlSlot =
      'https://104.215.186.78/api/v1/slots?page_index=1&page_size=5';
  static const String urlDocument =
      'https://104.215.186.78/api/v1/documents?page_index=1&page_size=10';

  static List<CategoryDTO> parseCategory(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<CategoryDTO> categories =
        list.map((model) => CategoryDTO.fromJson(model)).toList();
    return categories;
  }

  static List<Post> parsePost(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Post> posts = list.map((model) => Post.fromJson(model)).toList();
    return posts;
  }

  static List<SlotDTO> parseSlot(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<SlotDTO> slots = list.map((model) => SlotDTO.fromJson(model)).toList();
    return slots;
  }

  static List<DocumentDTO> parseDocument(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<DocumentDTO> documents =
        list.map((model) => DocumentDTO.fromJson(model)).toList();
    return documents;
  }

  static Future<List<Post>> fetachPosts({int page = 1}) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("connect dc r");
      return compute(parsePost, response.body);
    } else if (response.statusCode == 404) {
      print("Not found ");
      throw Exception('Not Found');
    } else {
      print("Fail to connect");
      throw Exception('Failed to get post');
    }
  }

  static Future<List<CategoryDTO>> fetachCategories({int page = 1}) async {
    final response = await http.get(Uri.parse(urlCategory));
    if (response.statusCode == 200) {
      print("connect dc r");
      return compute(parseCategory, response.body);
    } else if (response.statusCode == 404) {
      print("Not found ");
      throw Exception('Not Found');
    } else {
      print("Fail to connect");
      throw Exception('Failed to get post');
    }
  }

  static Future<List<DocumentDTO>> fetachDocument({int page = 1}) async {
    final response = await http.get(Uri.parse(urlDocument));
    if (response.statusCode == 200) {
      print("connect dc r");
      return compute(parseDocument, response.body);
    } else if (response.statusCode == 404) {
      print("Not found ");
      throw Exception('Not Found');
    } else {
      print("Fail to connect");
      throw Exception('Failed to get post');
    }
  }

  static Future<List<SlotDTO>> fetachSlot(int lawyerID, {int page = 1}) async {
    var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response = await http.get(
      Uri.parse(
          'https://104.215.186.78/api/v1/slots?lawyer_id=$lawyerID&page_index=1&page_size=50'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $idToken',
      },
    );

    if (response.statusCode == 200) {
      print("connect dc r");
      return compute(parseSlot, response.body);
    } else if (response.statusCode == 404) {
      print("Not found ");
      throw Exception('Not Found');
    } else {
      print("Fail to connect");
      throw Exception('Failed to get post');
    }
  }

  static Future<CustomerCase> createCustomerCase(CustomerCase cusCase) async {
    print("CCCsssss cuscase :" + cusCase.name + "---" + cusCase.description);
    final response = await http.post(
      Uri.parse('https://104.215.186.78/api/v1/customer-cases'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "name": cusCase.name,
        "description": cusCase.description,
      }),
    );
    print("CCC cuscase :" + response.body);
    Map<String, dynamic> cusCaseJSON = jsonDecode(response.body);
    CustomerCase cusCaseDTO = CustomerCase.fromJson(cusCaseJSON);
    print("CCC cuscase2 :" + cusCaseDTO.toString());
    print("R cuscase :" + response.statusCode.toString());
    if (response.statusCode == 201) {
      print("create CusCase dc r");
      return cusCaseDTO;
    } else {
      throw Exception('Failed to create slot.');
    }
  }

  static Future<CustomerCase> fetachCustomerCase(CustomerCase cusCase,
      {int page = 1}) async {
    String name = cusCase.name.replaceAll(" ", "%20");
    String description = cusCase.description.replaceAll(" ", "%20");

    final response = await http.get(Uri.parse(
        'https://104.215.186.78/api/v1/customer-cases?name=${name}&description=${description}&page_index=1&page_size=100'));

    Map<String, dynamic> cusCaseMap = jsonDecode(response.body);
    CustomerCase customerCaseDTO = CustomerCase.fromJson(cusCaseMap);

    if (response.statusCode == 200) {
      print("connect dc r" + response.body);
      return customerCaseDTO;
    } else if (response.statusCode == 404) {
      print("Not found ");
      throw Exception('Not Found');
    } else {
      print("Fail to connect");
      throw Exception('Failed to get post');
    }
  }

  static Future<Booking> createBooking(Booking dto) async {
    final response = await http.post(
      Uri.parse('https://104.215.186.78/api/v1/bookings'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "customer_id": InforUser.getIdUser(),
        "lawyer_id": dto.lawyerId,
        "booking_date": dto.bookingDate,
        "payment_method": dto.paymentMethod,
        "total_price": dto.totalPrice,
        "pay_date": dto.payDate,
        "status": 1,
        "customer_case_id": dto.customerCaseId
      }),
    );
    //https://104.215.186.78/api/v1/bookings/20

    Map<String, dynamic> bookingJSON = jsonDecode(response.body);
    print(response.body.toString());
    Booking bookingDTO = Booking.fromJson(bookingJSON);
    print("R:" + response.statusCode.toString());
    if (response.statusCode == 201) {
      print("create Booking dc r");
      return bookingDTO;
    } else {
      throw Exception('Failed to create slot.');
    }
  }

  static Future<Booking> getBookingID(int bookingID) async {
    final response = await http
        .get(Uri.parse('https://104.215.186.78/api/v1/bookings/$bookingID'));

    Map<String, dynamic> bookingJSON = jsonDecode(response.body);
    print(response.body.toString());
    Booking bookingDTO = Booking.fromJson(bookingJSON);
    print("R:" + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("create CusCase dc r");
      return bookingDTO;
    } else {
      throw Exception('Failed to create slot.');
    }
  }

  static Future<void> updateSlot(int idSlot, int bookingID) async {
    print(idSlot.toString() + "- --- -" + bookingID.toString());
    var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();

    /*final response = await http.put(Uri.parse('https://104.215.186.78/api/v1/slots'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $idToken',
        },
        body: jsonEncode(<String, int>{
          "id": idSlot,
          "booking_id": bookingID
        }),
      );*/
    final response = await http.put(
      Uri.parse('https://104.215.186.78/api/v1/slots'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $idToken',
      },
      body: jsonEncode(<String, dynamic>{"id": 18, "booking_id": 33}),
    );

    String body = response.body;
    print(body.toString() + "||");

    print("R:" + response.statusCode.toString());
    if (response.statusCode == 201 || response.statusCode == 200) {
      print("update booking to slot dc r");
    } else {
      throw Exception('Failed to connect.');
    }
  }

  static List<Booking> parseBooking(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Booking> bookings =
        list.map((model) => Booking.fromJson(model)).toList();
    return bookings;
  }

  static Future<List<Booking>> fetachBookingOfCustomer(int customerID,
      {int page = 1}) async {
    final response = await http.get(Uri.parse(
        'https://104.215.186.78/api/v1/bookings?CustomerId=$customerID&pageIndex=1&pageSize=10'));
    if (response.statusCode == 200) {
      print("connect dc r");
      return compute(parseBooking, response.body);
    } else if (response.statusCode == 404) {
      print("Not found ");
      throw Exception('Not Found');
    } else {
      print("Fail to connect");
      throw Exception('Failed to get post');
    }
  }

  static Future<String> getChanelNameToCall(int bookingID, String role,
      {int page = 1}) async {
    final response = await http.post(
      Uri.parse('https://104.215.186.78/api/v1/agora/call'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body:
          jsonEncode(<String, dynamic>{"booking_id": bookingID, "role": role}),
    );

    print("R:" + response.body.toString());
    print("R:" + response.statusCode.toString());
    if (response.statusCode == 201 || response.statusCode == 200) {
      print("lay chanel dc r dc r");
      return response.body;
    } else {
      throw Exception('Failed to create slot.');
    }
  }

  /*Future<List<Post>> fetchProducts() async { 
   final response = await http.get('http://192.168.1.2:8000/products.json' as Uri); 
   if (response.statusCode == 200) { 
      return parseProducts(response.body); 
   } else { 
      throw Exception('Unable to fetch products from the REST API');
   } 
}*/

}
