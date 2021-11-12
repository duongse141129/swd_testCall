import 'package:advisories_lawyer/models/lawyer.dart';
import 'package:advisories_lawyer/models/network_lawyer/network_request.dart';
import 'package:flutter/material.dart';

class ProfileLawyerInBooking extends StatefulWidget {
  final int lawyerID;
  const ProfileLawyerInBooking(this.lawyerID);

  @override
  _ProfileLawyerInBookingState createState() =>
      _ProfileLawyerInBookingState(lawyerID: lawyerID);
}

class _ProfileLawyerInBookingState extends State<ProfileLawyerInBooking> {
  late final int lawyerID;
  _ProfileLawyerInBookingState({required this.lawyerID});
  Lawyer? lawyerDTO;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkRequest.fetachProfileLawyer(lawyerID).then((dataFromSever) {
      setState(() {
        lawyerDTO = dataFromSever;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Lawyer "),
        backgroundColor: Colors.purple[400],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.account_circle_rounded,
                  color: Colors.purple,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Lawyer: ${lawyerDTO?.name}',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.email,
                  color: Colors.purple,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Email: ${lawyerDTO?.email}',
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.phone,
                  color: Colors.purple,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                    'Phone number: ${lawyerDTO?.phoneNumber == null ? "Chưa cập nhật" : "${lawyerDTO?.phoneNumber}"}',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.home,
                  color: Colors.purple,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Address: ${lawyerDTO?.address} - ${lawyerDTO?.location}',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.school,
                  color: Colors.purple,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Degree: ${lawyerDTO?.description}',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.class_,
                  color: Colors.purple,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Office: ${lawyerDTO?.lawyerOfficeName}',
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.purple,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Level: ${lawyerDTO?.level}',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
