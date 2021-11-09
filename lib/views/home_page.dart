import 'package:advisories_lawyer/models/lawyer.dart';
import 'package:advisories_lawyer/provider/google_sign_in.dart';
import 'package:advisories_lawyer/views/logged_in.dart';
import 'package:advisories_lawyer/views/login_page.dart';
import 'package:advisories_lawyer/views/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return WelcomePage();
          } else if (snapshot.hasError) {
            return Center(child: Text('Something went wrong!'));
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
