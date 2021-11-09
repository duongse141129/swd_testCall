import 'package:advisories_lawyer/lawyer/main_lawyer.dart';
import 'package:advisories_lawyer/models/user_account.dart';
import 'package:advisories_lawyer/provider/google_sign_in.dart';
import 'package:advisories_lawyer/views/lawyer_page.dart';
import 'package:advisories_lawyer/views/logged_in.dart';
import 'package:advisories_lawyer/views/login_page.dart';
import 'package:advisories_lawyer/views/main_customer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Future<Users>? futureUsers;
  @override
  void initState() {
    super.initState();
    futureUsers = getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/theme2.png'), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Center(child: Container(child: buildFutureBuilder())),
        ),
      ),
    );
  }

  FutureBuilder<Users> buildFutureBuilder() {
    return FutureBuilder<Users>(
      future: futureUsers,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome Back",
                  style: TextStyle(fontSize: 40, color: Colors.yellow)),
              SizedBox(
                height: 20,
              ),
              Text("My " + snapshot.data!.role,
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(
                height: 10,
              ),
              Text(
                "Hello: " + snapshot.data!.name,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    if (snapshot.data!.role == "customer") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CustomerMain();
                            },
                            settings: RouteSettings(
                              arguments: snapshot.data!.id,
                            ),
                          ));
                    } else if (snapshot.data!.role == "lawyer") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LawyerMain();
                            },
                            settings: RouteSettings(
                              arguments: snapshot.data!.id,
                            ),
                          ));
                    } else {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ));
                    }
                  },
                  child: Text('continue')),
              TextButton(
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.logout();
                  },
                  child: Text('Logout'))
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
