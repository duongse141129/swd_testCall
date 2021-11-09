import 'package:advisories_lawyer/lawyer/model_lawyer/customer.dart';
import 'package:advisories_lawyer/lawyer/network_lawyer/network_request.dart';
import 'package:flutter/material.dart';

class ProfileCustomer extends StatefulWidget {
  final int customerID;
  ProfileCustomer(this.customerID);

  @override
  _ProfileCustomerState createState() => _ProfileCustomerState();
}

class _ProfileCustomerState extends State<ProfileCustomer> {
  CustomerDTO? customerDTO;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkRequest.fetachProfileUser(widget.customerID).then((dataFromSever){
      setState(() {
        customerDTO = dataFromSever;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Customer ${widget.customerID}"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Text(
            '${customerDTO?.name}',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '${customerDTO?.address}',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '${customerDTO?.location}',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '${customerDTO?.phoneNumber}',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '${customerDTO?.sex == 0 ? "nu" : "nam"}',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          
        ],
      ),
    );
  }
}
