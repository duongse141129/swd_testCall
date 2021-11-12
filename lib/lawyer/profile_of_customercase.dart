import 'package:advisories_lawyer/lawyer/model_lawyer/customer_case.dart';
import 'package:advisories_lawyer/lawyer/network_lawyer/network_request.dart';
import 'package:advisories_lawyer/models/advisory.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileOfCustomerCase extends StatefulWidget {
  final int customerCaseID;
  final int bookingID;
  ProfileOfCustomerCase(this.customerCaseID,this.bookingID);

  @override
  _ProfileOfCustomerCaseState createState() => _ProfileOfCustomerCaseState();
}

class _ProfileOfCustomerCaseState extends State<ProfileOfCustomerCase> {
  CustomerCaseDTO? customerCase;
  AdvisoryDTO? advisoryDTO;
  final TextEditingController _controllerAnswer = TextEditingController();
  String answerOfLawyer="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkRequest.fetachCustomerCase(widget.customerCaseID).then((dataCustomerCaseFromSever) {
      setState(() {
        customerCase = dataCustomerCaseFromSever;
      });
    });
    NetworkRequest.fetachAdvisory(widget.bookingID).then((dataAdvisoryFromSever) {
      setState(() {
        advisoryDTO = dataAdvisoryFromSever;
        _controllerAnswer.text=advisoryDTO!.answer;
      });
    });
    //_controllerAnswer.text=advisoryDTO!.answer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Customer ${widget.customerCaseID}"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Chủ đề: ${customerCase?.name}',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Nội dung: ${customerCase?.description}',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Câu hỏi: ${advisoryDTO?.question}',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            "Câu Trả lời",
            style: TextStyle(fontSize: 30),
          ),
          TextField(
            maxLines: 6,
            controller: _controllerAnswer,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Giải quyết thắc mắc về vấn đề của khách hàng'),
          ),
          ElevatedButton(
            style: (ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            )),
            onPressed: () async {
              advisoryDTO = await  NetworkRequest.updateAnswer(advisoryDTO!, _controllerAnswer.text);
              Fluttertoast.showToast(
                msg: "SEND ANSWER SUCCESS", toastLength: Toast.LENGTH_SHORT);
   
              /*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfileCustomer(bookingData[index].customerId)));*/
            },
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
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
