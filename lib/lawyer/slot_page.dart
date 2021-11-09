import 'package:advisories_lawyer/lawyer/document_page.dart';
import 'package:advisories_lawyer/lawyer/model_lawyer/category.dart';
import 'package:advisories_lawyer/lawyer/model_lawyer/slot.dart';
import 'package:advisories_lawyer/lawyer/network_lawyer/network_request.dart';
import 'package:flutter/material.dart';

class SlotPage extends StatefulWidget {
  const SlotPage({Key? key}) : super(key: key);

  @override
  _SlotPageState createState() => _SlotPageState();
}

class _SlotPageState extends State<SlotPage> {
  List<SlotDTO> slotData = <SlotDTO>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkRequest.fetachSlot().then((dataFromSever) {
      setState(() {
        slotData = dataFromSever;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slot"),
        backgroundColor: Colors.purple[400],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  //list
                  itemCount: slotData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocumentPage()));*/
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${slotData[index].id}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${slotData[index].lawyerId}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${slotData[index].price}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${slotData[index].startAt}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${slotData[index].endAt}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
