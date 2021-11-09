
import 'package:advisories_lawyer/lawyer/model_lawyer/document.dart';
import 'package:advisories_lawyer/lawyer/network_lawyer/network_request.dart';
import 'package:flutter/material.dart';


class DocumentPage extends StatefulWidget {
  final int categoryID;
  DocumentPage(this.categoryID);
  //const DocumentPage({ Key? key }) : super(key: key);

  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  

  List<DocumentDTO> documentData  = <DocumentDTO>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkRequest.fetachDocument(widget.categoryID).then((dataFromSever){
      setState(() {
        documentData = dataFromSever;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Documents"), backgroundColor: Colors.purple[400],),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              //list
              itemCount: documentData.length,
              itemBuilder: (context, index){
                return Card(
                  child: InkWell(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${documentData[index].name}',
                            style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('${documentData[index].description}',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                );
              }
            )
          )
        ],
      ),
    );
  }
}