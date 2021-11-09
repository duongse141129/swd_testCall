import 'package:advisories_lawyer/lawyer/category_page.dart';
import 'package:advisories_lawyer/lawyer/profile_of_booking.dart';
import 'package:advisories_lawyer/lawyer/slot_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LawyerHomePage extends StatefulWidget {
  const LawyerHomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<LawyerHomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget listObj = Container(
    //padding: EdgeInsets.all(40),
    child: GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        Card(
          child: InkWell(
            onTap: () {},
            splashColor: Colors.green,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.home,
                    size: 70,
                  ),
                  Text(
                    "Office",
                    style: new TextStyle(fontSize: 17.0),
                  )
                ],
              ),
            ),
          ),
        ),
        Card(
          child: InkWell(
            onTap: () {},
            splashColor: Colors.green,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.schedule,
                    size: 70,
                  ),
                  Text(
                    "Office",
                    style: new TextStyle(fontSize: 17.0),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Hello Laywer ${user.displayName},",
            style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                fontFamily: 'avenir'),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color(0xfff1f3f6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your task today:",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "8:00 advice for Tom ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "13:00 meet the department ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xffffac30)),
                  child: Icon(
                    Icons.more_vert,
                    size: 30,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              children: [
                serviceWidget("sendMoney", "Profile of customer"),
                serviceWidget("receiveMoney", "Document"),
                serviceWidget("phone", "Contact"),
                serviceWidget("electricity", "News"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column serviceWidget(String img, String name) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              switch (name) {
                case "Profile of customer":
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileBooking()));
                  break;
                case "Document":
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CategoryPage()));
                  break;
                case "Contact":
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SlotPage()));
                  break;
              }
            },
            //splashColor: Colors.blue[500],
            child: Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xfff1f3f6),
              ),
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    //image: AssetImage('assets/images/document.png'),

                    image: NetworkImage(
                        'https://www.computerhope.com/jargon/d/doc.png'),
                    fit: BoxFit.cover,
                  )),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'avenir',
            fontSize: 18,
            color: Colors.blue[600],
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
