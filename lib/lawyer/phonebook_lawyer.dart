import 'package:advisories_lawyer/lawyer/chat_lawyer/message_page.dart';
import 'package:flutter/material.dart';

class LawyerPhoneBook extends StatefulWidget {
  @override
  _PhoneBookState createState() => _PhoneBookState();
}

class _PhoneBookState extends State<LawyerPhoneBook> {
  List<String> imageUrl = [
    "https://i.pinimg.com/originals/2e/2f/ac/2e2fac9d4a392456e511345021592dd2.jpg",
    "https://randomuser.me/api/portraits/men/86.jpg",
    "https://randomuser.me/api/portraits/women/80.jpg",
    "https://randomuser.me/api/portraits/men/43.jpg",
  ];
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget appBarTitle = Text('Advisory Lawyer');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(29.5),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                icon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            )
        ),
        SizedBox(height: 20,),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
              child: ListView(
                children: [
                  chatTile(imageUrl[0], "Alex", "customer", "9Am", false),
                  chatTile(imageUrl[1], "Tom", "customer", "8Am", true),
                  chatTile(imageUrl[2], "Emily", "coworker", "6Am", true),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget chatTile( String imgUrl, String userName, String msg, String date, bool seen) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatDetailPage()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imgUrl),
              radius: 28.0,
            ),
            SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          userName,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(date),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Expanded(child: Text(msg)),
                      if (seen)
                        Icon(
                          Icons.check_circle,
                          size: 18.0,
                          color: Colors.green,
                        ),
                      if (!seen)
                        Icon(
                          Icons.check_circle_outline,
                          color: Colors.grey,
                          size: 18.0,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
