import 'package:advisories_lawyer/lawyer/model_lawyer/customer_case.dart';
import 'package:advisories_lawyer/lawyer/network_lawyer/network_request.dart';
import 'package:flutter/material.dart';

class ProfileOfCustomerCase extends StatefulWidget {

  final int customerCaseID;
  ProfileOfCustomerCase(this.customerCaseID);


  @override
  _ProfileOfCustomerCaseState createState() => _ProfileOfCustomerCaseState();
}

class _ProfileOfCustomerCaseState extends State<ProfileOfCustomerCase> {
  CustomerCaseDTO? customerCase;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkRequest.fetachCustomerCase(widget.customerCaseID).then((dataFromSever){
      setState(() {
        customerCase = dataFromSever;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Customer ${widget.customerCaseID}"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            Text(customerCase!.name),
            Text(customerCase!.description),
          ],
        ),
      ),
      
    );
  }
}