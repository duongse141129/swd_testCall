
import 'package:advisories_lawyer/lawyer/home_lawyer.dart';
import 'package:advisories_lawyer/lawyer/navbar_lawyer.dart';
import 'package:advisories_lawyer/lawyer/phonebook_lawyer.dart';
import 'package:advisories_lawyer/lawyer/schedule_lawyer.dart';
import 'package:advisories_lawyer/lawyer/settings_lawyer.dart';
import 'package:flutter/material.dart';

class LawyerMain extends StatefulWidget {
  const LawyerMain({ Key? key }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LawyerMain> {
  int _currentIndex = 0;
  Icon actionIcon=new Icon(Icons.search, color: Colors.white,);
  Widget appBarTitle= Text('Advisory Lawyer');
  final List pages = [
    LawyerHomePage(),
    LawyerPhoneBook(),
    LawyerSchedule(),
    LawyerSettings(),
  ];

  /*final tabs = [
    Center(child: Text('Home')),
    Center(child: Text('Contacts')),
    Center(child: Text('Calendar')),
    Center(child: Text('Settings')),
  ];*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: LawyerNavBar(),
        backgroundColor: Colors.purple[50],
        appBar: AppBar(
          backgroundColor: Colors.purple[400],
          title: appBarTitle,

          actions: <Widget>[
            IconButton(        
              icon: actionIcon,
              onPressed: (){
                setState(() {
                  if(this.actionIcon.icon == Icons.search){
                    this.actionIcon = Icon(Icons.close);
                      appBarTitle = TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration:  InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        hintText: "Search ...",
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    );
                    
                  }
                  else{
                    this.actionIcon =  Icon(Icons.search);
                    this.appBarTitle= Text("Advisory Lawyer");
                  }
                });
              },
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.notifications, color: Colors.white),
            ),
          ],


          ),
          body: pages[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            fixedColor: Colors.purple,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
    
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),            
                backgroundColor: Colors.purple
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.recent_actors),
                title: Text('Contacts'),
                backgroundColor: Colors.purple
                
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                title: Text('Calendar'),
                backgroundColor: Colors.purple
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.settings_applications_outlined),
                title: Text('Settings'),
                backgroundColor: Colors.purple
              ),
            ],
            onTap: (index){
              setState(() {
                _currentIndex=index;
              });
            },
          ),
      ),
    );
  }
}