import 'package:flutter/material.dart';

class LawyerSettings extends StatefulWidget {
  const LawyerSettings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<LawyerSettings> {
  Color titleColor = Color(0xa896c7);
  Color space = Color(0xf6f6fe);
  Color fontWord = Color(0x2f2247);
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(30),
      child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          title("Account"),
          Divider(height: 1,color: Color(0xff6f6fe),),
          ListTile(
            leading: Icon(Icons.password ),
            title: Text('Change password'),
            onTap: () => {},
            tileColor: Colors.white,
          ),
          Divider(height: 1,color: Color(0xff6f6fe),),
          ListTile(
            leading: Icon(Icons.phone_bluetooth_speaker_outlined),
            title: Text('Change phone number'),
            onTap: () => {},
            tileColor: Colors.white,
          ),
          Divider(height: 1,color: Color(0xff6f6fe),),
          ListTile(
            leading: Icon(Icons.assignment_ind_rounded),
            title: Text('Update profile'),
            onTap: () => {},
            tileColor: Colors.white,
          ),
          Divider(height: 1,color: Color(0xff6f6fe),),
          title("General"),
          Divider(height: 1,color: Color(0xff6f6fe),),
          ListTile(
            leading: Icon(Icons.not_listed_location_outlined),
            title: Text('Frequently asked questions'),
            onTap: () => {},
            tileColor: Colors.white,
          ),
          Divider(height: 1,color: Color(0xff6f6fe),),
          ListTile(
            leading: Icon(Icons.support_agent ),
            title: Text('Support'),
            onTap: () => {},
            tileColor: Colors.white,
          ),
          Divider(height: 1,color: Color(0xff6f6fe),),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share with friends'),
            onTap: () => {},
            tileColor: Colors.white,
          ),
          Divider(height: 1,color: Color(0xff6f6fe),),
          title("Application"),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Settings notification'),
            onTap: () => {},
            tileColor: Colors.white,
          ),
          Divider(height: 1,color: Color(0xff6f6fe),),
          ListTile(
            leading: Icon(Icons.star_border),
            title: Text('Rating'),
            onTap: () => {},
            tileColor: Colors.white,
          ),
          Divider(height: 1,color: Color(0xff6f6fe),),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            onTap: () => {},
            tileColor: Colors.white,
          ),
          Divider(height: 1,color: Color(0xff6f6fe),),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log out'),
            onTap: () => {},
            tileColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget title(String title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 20,
            color: Colors.purple[600],
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
