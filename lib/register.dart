import 'package:flutter/material.dart';


/*void main() {
  runApp( Register());
}*/

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home: Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Container(
                  width: 70,
                  height: 70,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffd8d8d8)
                  ),
                  child: FlutterLogo()),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Text("ADVISORY LAWYER",
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30),
                ),
              ),
              Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextField(
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "USER NAME",
                        labelStyle: 
                            TextStyle(color: Color(0xff888888), fontSize: 15)
                        ),
                    ),
              ),
               Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextField(
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: 
                            TextStyle(color: Color(0xff888888), fontSize: 15)
                        ),
                    ),
              ),
              Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextField(
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "PHONE NUMBER",
                        labelStyle: 
                            TextStyle(color: Color(0xff888888), fontSize: 15)
                        ),
                    ),
              ),
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextField(
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "PASSWORD",
                        labelStyle: 
                            TextStyle(color: Color(0xff888888), fontSize: 15)
                        ),
                    ),
                  )
                ],
              ),
               Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextField(
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "CONFIRM PASSWORD",
                        labelStyle: 
                            TextStyle(color: Color(0xff888888), fontSize: 15)
                        ),
                    ),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                    onPressed: onSignInClicked,
                    child: Text(
                      "CREATE ACCOUNT",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                  ),
                ),
              ),

              

            ],
          ),
        ),
      ),
    );
  }


  void onSignInClicked(){}
}