import 'dart:convert';
import 'dart:io';

import 'package:advisories_lawyer/lawyer/infor_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future<Users?> googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      // if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();

      var token = {"id_token": idToken};

      HttpClient client = HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      var url = 'https://104.215.186.78/api/v1/authentications/login';

      HttpClientRequest request = await client.postUrl(Uri.parse(url));

      request.headers.set('content-type', 'application/json');

      request.add(utf8.encode(json.encode(token)));

      HttpClientResponse response = await request.close();

      String reply = await response.transform(utf8.decoder).join();

      Map<String, dynamic> userMap = jsonDecode(reply);
      var user = Users.fromJson(userMap);

      InforUser inforUser = new InforUser();
      inforUser.setUserInfo(user);

      return user;
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future<Users?> logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}

class Users {
  final int id;
  final String name;
  final String email;
  final String role;

  Users(this.name, this.email, this.role, this.id);

  Users.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['display_name'],
        email = json['email'],
        role = json['role'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'role': role,
      };
}

Future<Users> getUsers() async {
  var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();

  var token = {"id_token": idToken};

  HttpClient client = HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  var url = 'https://104.215.186.78/api/v1/authentications/login';

  HttpClientRequest request = await client.postUrl(Uri.parse(url));

  request.headers.set('content-type', 'application/json');

  request.add(utf8.encode(json.encode(token)));

  HttpClientResponse response = await request.close();

  String reply = await response.transform(utf8.decoder).join();

  Map<String, dynamic> userMap = jsonDecode(reply);
  var user = Users.fromJson(userMap);

  return user;
}
