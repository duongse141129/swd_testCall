import 'package:advisories_lawyer/models/advisory.dart';
import 'package:advisories_lawyer/models/customer_case.dart';
import 'package:advisories_lawyer/models/network_lawyer/network_request.dart';
import 'package:flutter/material.dart';

class ProfileOfCustomerCase extends StatefulWidget {
  final int customerCaseID;
  final int bookingID;
  ProfileOfCustomerCase(this.customerCaseID, this.bookingID);

  @override
  _ProfileOfCustomerCaseState createState() => _ProfileOfCustomerCaseState();
}

class _ProfileOfCustomerCaseState extends State<ProfileOfCustomerCase> {
  CustomerCase? customerCase;
  AdvisoryDTO? advisoryDTO;
  final TextEditingController _controllerAnswer = TextEditingController();
  String answerOfLawyer = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkRequest.fetachCustomerCaseByIDcusCase(widget.customerCaseID)
        .then((dataCustomerCaseFromSever) {
      setState(() {
        customerCase = dataCustomerCaseFromSever;
      });
    });
    NetworkRequest.fetachAdvisory(widget.bookingID)
        .then((dataAdvisoryFromSever) {
      setState(() {
        advisoryDTO = dataAdvisoryFromSever;
        _controllerAnswer.text = advisoryDTO!.answer;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Customer ${widget.customerCaseID}"),
        backgroundColor: Colors.purple.shade400,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              child: Column(
            children: [
              Card(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Chủ đề: ",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '  - ${customerCase?.name}',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Nội dung: ",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '  - ${customerCase?.description}',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Câu hỏi: ",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '  - ${advisoryDTO?.question}',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Tư vấn từ luật sư: ",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '  - ${advisoryDTO?.answer}',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ))),
    );
  }

  /*void getAnswerOfLawyer(String answer){
    if(advisoryDTO!.answer.isEmpty){
      answerOfLawyer = "";
    }
    else{
      answerOfLawyer=advisoryDTO!.answer;
    }

  }*/
}
