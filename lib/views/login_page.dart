import 'package:advisories_lawyer/provider/google_sign_in.dart';
import 'package:advisories_lawyer/views/lawyer_page.dart';
import 'package:advisories_lawyer/views/logged_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  // Users? users;
  // getUser(BuildContext context) async {
  //   final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
  //   users = await provider.googleLogin();
  //   if (users!.role == "customer") {
  //     Navigator.push(context, MaterialPageRoute(
  //       builder: (context) {
  //         return LoggedIn();
  //       },
  //     ));
  //   } else if (users!.role == "lawyer") {
  //     Navigator.push(context, MaterialPageRoute(
  //       builder: (context) {
  //         return LawyerPage();
  //       },
  //     ));
  //   } else {
  //     Navigator.push(context, MaterialPageRoute(
  //       builder: (context) {
  //         return LoginPage();
  //       },
  //     ));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Widget titileSection = Container(
      child: Row(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 110),
                child: Container(
                  child: Text(
                    "ADVISORIES LAWYER",
                    style: TextStyle(
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 100),
                child: Container(
                  child: Text(
                    "WELCOME",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
              ),
              //textfield
            ],
          ))
        ],
      ),
    );

    Widget buttonSection = Container(
      child:
          //Button
          Padding(
        padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
        child: SizedBox(
            width: 200,
            height: 56,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    minimumSize: Size(double.infinity, 50)),
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin();
                },
                icon: FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.red,
                ),
                label: Text('Sign Up with google'))),
      ),
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/theme2.png'), fit: BoxFit.cover),
        ),
        child: ListView(
          children: [
            titileSection,
            Column(
              children: [
                Image.asset(
                  'loginCus.png',
                  fit: BoxFit.fill,
                ),
                Center(
                  child: buttonSection,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
