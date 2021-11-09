import 'package:advisories_lawyer/views/document_page.dart';
import 'package:advisories_lawyer/views/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/listDocument':
        return MaterialPageRoute(
            builder: (_) => DocPage(settings.arguments as int));

      default:
        return MaterialPageRoute(builder: (_) => WelcomePage());
    }
  }
}
