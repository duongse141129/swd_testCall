import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatDetailPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xff14142b),
      flexibleSpace: SafeArea(
        child: Container(
          padding: EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage("https://randomuser.me/api/portraits/women/49.jpg"),
                maxRadius: 20,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Đức Đặng",
                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Online",
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
