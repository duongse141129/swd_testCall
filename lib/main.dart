import 'dart:io';

import 'package:advisories_lawyer/provider/google_sign_in.dart';
import 'package:advisories_lawyer/views/home_page.dart';
import 'package:advisories_lawyer/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        title: 'Login',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
        // initialRoute: '/login',
        // onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
