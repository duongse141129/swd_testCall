import 'package:flutter/material.dart';

class LawyerPage extends StatefulWidget {
  const LawyerPage({Key? key}) : super(key: key);

  @override
  _LawyerPageState createState() => _LawyerPageState();
}

class _LawyerPageState extends State<LawyerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Trang lawyer"),
      ),
    );
  }
}
