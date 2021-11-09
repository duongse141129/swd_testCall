import 'dart:convert';
import 'dart:io';

import 'package:advisories_lawyer/lawyer/infor_user.dart';
import 'package:advisories_lawyer/lawyer/model_lawyer/booking.dart';
import 'package:advisories_lawyer/lawyer/model_lawyer/category.dart';
import 'package:advisories_lawyer/lawyer/model_lawyer/customer.dart';
import 'package:advisories_lawyer/lawyer/model_lawyer/customer_case.dart';
import 'package:advisories_lawyer/lawyer/model_lawyer/document.dart';
import 'package:advisories_lawyer/lawyer/model_lawyer/post.dart';
import 'package:advisories_lawyer/lawyer/model_lawyer/slot.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class NetworkRequest {
  static const String url = 'https://jsonplaceholder.typicode.com/posts';
  static const String urlCategory =
      'https://104.215.186.78/api/v1/categories?page_index=1&page_size=6';
  static const String urlSlot =
      'https://104.215.186.78/api/v1/slots?page_index=1&page_size=5';
  static const String urlDocument =
      'https://104.215.186.78/api/v1/documents?page_index=1&page_size=10';
  static String tokenOfUser = '';

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

  static List<BookingDTO> parseBooking(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<BookingDTO> bookings =
        list.map((model) => BookingDTO.fromJson(model)).toList();
    return bookings;
  }


  static CustomerDTO parseCustomer(String responseBody) {
    Map<String, dynamic> cusMap = jsonDecode(responseBody);
    CustomerDTO customerDTO = CustomerDTO.fromJson(cusMap);
    return customerDTO;
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

  static Future<List<DocumentDTO>> fetachDocument(int categoryID,{int page = 1}) async {
    final response = await http.get(Uri.parse(
        'https://104.215.186.78/api/v1/documents?category_id=$categoryID&page_index=1&page_size=10'));
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

  static Future<List<SlotDTO>> fetachSlot({int page = 1}) async {
    tokenOfUser = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response = await http.get(
      Uri.parse('https://104.215.186.78/api/v1/slots?lawyer_id=${InforUser.getIdUser()}&sort_by=StartAt&page_index=1&page_size=100'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $tokenOfUser',
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

  static void createSlot(SlotDTO slotDTO) async {
    var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    print("co id" + tokenOfUser);
    
      final response = await http.post(
        Uri.parse('https://104.215.186.78/api/v1/slots'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $idToken',
          
        },
        body: jsonEncode(<String, dynamic>{
          "start_at_formatted": slotDTO.startAt,
          "end_at_formatted": slotDTO.endAt,
          "price": slotDTO.price,
          "lawyer_id": slotDTO.lawyerId,
          "status": 1
        }),
      );
      print("R:"+response.statusCode.toString());
      if (response.statusCode == 201) {
        print("create dc r");
      } else {
        throw Exception('Failed to create slot.');
      }
    
  }
  static void deleteSlot(int slotID) async {
    var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    print("co id" + tokenOfUser);
    
      final response = await http.delete(
        Uri.parse('https://104.215.186.78/api/v1/slots'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $idToken',
          
        },
        body: jsonEncode(<String, dynamic>{
          "id": slotID
        
        }),
      );
      print("R:"+response.statusCode.toString());
      if (response.statusCode == 200) {
        print("delete dc r");
      } else {
        throw Exception('Failed to create slot.');
      }
    
  }

  static Future<List<BookingDTO>> fetachBooking({int page = 1}) async {
    final response = await http.get(Uri.parse('https://104.215.186.78/api/v1/bookings?LawyerId=8&pageIndex=1&pageSize=10'));
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

  static Future<CustomerDTO> fetachProfileUser(int customerID,{int page = 1}) async {
    final response = await http.get(Uri.parse('https://104.215.186.78/api/v1/customers/$customerID'));

    Map<String, dynamic> cusMap = jsonDecode(response.body);
    CustomerDTO customerDTO = CustomerDTO.fromJson(cusMap);

    if (response.statusCode == 200) {
      print("connect dc r" +response.body);
      return customerDTO;
    } else if (response.statusCode == 404) {
      print("Not found ");
      throw Exception('Not Found');
    } else {
      print("Fail to connect");
      throw Exception('Failed to get post');
    }
  }

  static Future<CustomerCaseDTO> fetachCustomerCase(int customerCaseID,{int page = 1}) async {
    final response = await http.get(Uri.parse('https://104.215.186.78/api/v1/customer-cases/$customerCaseID'));

    Map<String, dynamic> cusCaseMap = jsonDecode(response.body);
    CustomerCaseDTO customerCaseDTO = CustomerCaseDTO.fromJson(cusCaseMap);

    if (response.statusCode == 200) {
      print("connect dc r" +response.body);
      return customerCaseDTO;
    } else if (response.statusCode == 404) {
      print("Not found ");
      throw Exception('Not Found');
    } else {
      print("Fail to connect");
      throw Exception('Failed to get post');
    }
  }

  static Future<BookingDTO> fetachNameCusByBookingID(int bookingID,{int page = 1}) async {
    final response = await http.get(Uri.parse('https://104.215.186.78/api/v1/bookings/$bookingID'));

    Map<String, dynamic> bookingMap = jsonDecode(response.body);
    BookingDTO bookingDTO = BookingDTO.fromJson(bookingMap);

    if (response.statusCode == 200) {
      print("connect dc r" +response.body);
      return bookingDTO;
    } else if (response.statusCode == 404) {
      print("Not found ");
      throw Exception('Not Found');
    } else {
      print("Fail to connect");
      throw Exception('Failed to get post');
    }
  }

  static Future<String> getChanelNameToCall(int bookingID,String role,{int page = 1}) async {
    
      final response = await http.post(
        Uri.parse('https://104.215.186.78/api/v1/agora/call'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
          
        },
        body: jsonEncode(<String, dynamic>{
          "booking_id": bookingID,
          "role": role
        }),
      );

      print("R:"+response.body.toString());
      print("R:"+response.statusCode.toString());
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
