import 'package:advisories_lawyer/lawyer/category_page.dart';
import 'package:advisories_lawyer/provider/google_sign_in.dart';
import 'package:advisories_lawyer/views/category_page.dart';
import 'package:advisories_lawyer/views/customer_case_page.dart';
import 'package:advisories_lawyer/views/document_page.dart';
import 'package:advisories_lawyer/views/lawyer_page.dart';
import 'package:advisories_lawyer/views/navbar.dart';
import 'package:advisories_lawyer/views/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoggedIn extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  Users? users;
  getUser(BuildContext context) async {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    provider.logout();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.black87,
            image: DecorationImage(
                alignment: Alignment.center,
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            // Container(
            //   height: size.height * .45,
            //   decoration: BoxDecoration(
            //       color: Colors.black87,
            //       image: DecorationImage(
            //           alignment: Alignment.centerLeft,
            //           image: AssetImage("assets/background.png"))),
            // ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Row(
                              children: [
                                Text(
                                  "WELCOME ${user.displayName}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29.5),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Search",
                            icon: Icon(Icons.search),
                            border: InputBorder.none),
                      ),
                    ),
                    Expanded(
                        child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        Container(
                            child: ConstrainedBox(
                                constraints: BoxConstraints.expand(),
                                child: FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryCusPage()));
                                    },
                                    padding: EdgeInsets.all(0.0),
                                    child: Column(
                                      children: [
                                        Image.asset('assets/document.png'),
                                        Text(
                                          'Document List',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )))),
                        Container(
                            child: ConstrainedBox(
                                constraints: BoxConstraints.expand(),
                                child: FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LawyerPage()));
                                    },
                                    padding: EdgeInsets.all(0.0),
                                    child: Column(
                                      children: [
                                        Image.asset('assets/lawyer.jpg'),
                                        Text(
                                          'Lawyer List',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )))),
                      ],
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
