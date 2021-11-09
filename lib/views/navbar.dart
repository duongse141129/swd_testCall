import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'Name: ' + user.displayName!,
            ),
            accountEmail: Text(
              'Email: ' + user.email!,
            ),
            currentAccountPicture: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            decoration: BoxDecoration(
              color: Colors.purple,
              image: DecorationImage(
                image: NetworkImage(
                  'https://i.pinimg.com/originals/6b/a7/cd/6ba7cd81a0bef63d482a8f7a0e5fc6cd.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Friends'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () => {},
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                width: 20,
                height: 20,
                child: Center(
                  child: Text(
                    '8',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Message'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.schedule),
            title: Text('Schedule'),
            onTap: () => {},
          ),
          Divider(
            color: Colors.purple,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Setting'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text('Help'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.report_gmailerrorred),
            title: Text('Report Error'),
            onTap: () => {},
          ),
          Divider(
            color: Colors.purple,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log out'),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}
