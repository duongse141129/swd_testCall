import 'dart:io';

import 'package:advisories_lawyer/lawyer/model_lawyer/category.dart';

import 'package:advisories_lawyer/models/catagories.dart';
import 'package:advisories_lawyer/models/customer_case.dart';
import 'package:advisories_lawyer/models/documents.dart';
import 'package:advisories_lawyer/models/lawyer.dart';
import 'package:advisories_lawyer/models/network_lawyer/network_request.dart';
import 'package:advisories_lawyer/models/order.dart';
import 'package:advisories_lawyer/models/users.dart';
import 'package:advisories_lawyer/views/lawyer_list_page.dart';
import 'package:advisories_lawyer/views/lawyer_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class CustomerCasePage extends StatefulWidget {
  const CustomerCasePage({Key? key}) : super(key: key);

  @override
  _CustomerCasePageState createState() => _CustomerCasePageState();
}

class _CustomerCasePageState extends State<CustomerCasePage> {
  // late Catagories? _mySelection;
  // late Doc? _mySelection2;
  // late Future<List<Catagories?>> futureCata;
  // late Future<List<Doc?>> futureDoc;
  @override
  void initState() {
    super.initState();
    // futureCata = fetchCatagories();
  }

  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerDes = TextEditingController();
  final TextEditingController _controllerQuestion = TextEditingController();
  Future<CustomerCase>? _futureCustomerCase;

  @override
  Widget build(BuildContext context) {
    final doc = ModalRoute.of(context)!.settings.arguments as Doc;
    return Scaffold(
      appBar: AppBar(
        title: Text('Vấn đề của khách hàng'),
        backgroundColor: Colors.purple[400],
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Câu hỏi: ' + doc.name,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(8.0),
                      child: (_futureCustomerCase == null)
                          ? buildColumn()
                          : buildFutureBuilder(),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Text(
          "Chủ đề",
          style: TextStyle(fontSize: 30),
        ),
        TextField(
          controller: _controllerTitle,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: 'Mời bạn nhập chủ đề'),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Nội dung",
          style: TextStyle(fontSize: 30),
        ),
        TextField(
          maxLines: 6,
          controller: _controllerDes,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Mời bạn nhập chi tiết vấn đề mà bạn muốn giải quyết'),
        ),
        Text(
          "Câu hỏi",
          style: TextStyle(fontSize: 30),
        ),
        TextField(
          maxLines: 6,
          controller: _controllerQuestion,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Mời bạn nhập những thắc mắc về vấn đề của bạn'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _futureCustomerCase = createCustomerCase(
                      _controllerTitle.text, _controllerDes.text);
                });
              },
              child: const Text('Submit'),
            ),
          ],
        )
      ],
    );
  }

  FutureBuilder<CustomerCase> buildFutureBuilder() {
    final doc = ModalRoute.of(context)!.settings.arguments as Doc;
    return FutureBuilder<CustomerCase>(
      future: _futureCustomerCase,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        '  - ${snapshot.data!.name}',
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
                        '  - ${snapshot.data!.description}',
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
                        '  - ${_controllerQuestion.text}',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              RaisedButton(
                color: Colors.purple.shade400,
                onPressed: () {
                  CustomerCase cusCase = CustomerCase(
                      id: snapshot.data!.id,
                      name: snapshot.data!.name,
                      description: snapshot.data!.description);

                  //print("CUS"+customerCaseDTO.id.toString());

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LawyerListPage(doc.category_id, cusCase, _controllerQuestion.text)));
                },
                child: Text(
                  "Chọn Luật sư",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }

  // FutureBuilder<List<Catagories?>> buildFutureCataBuilder() {
  //   return FutureBuilder<List<Catagories?>>(
  //       future: futureCata,
  //       builder:
  //           (BuildContext context, AsyncSnapshot<List<Catagories?>> snapshot) {
  //         if (!snapshot.hasData)
  //           return CupertinoActivityIndicator(
  //             animating: true,
  //           );
  //         return DropdownButtonFormField<Catagories?>(
  //           isDense: true,
  //           // decoration: spinnerDecoration('Select your Cate'),
  //           items: snapshot.data!
  //               .map((category) => DropdownMenuItem<Catagories>(
  //                     child: Text(category!.categoryName),
  //                     value: category,
  //                   ))
  //               .toList(),
  //           onChanged: (selectedState) {
  //             setState(() {
  //               _mySelection2 = null;
  //               _mySelection = selectedState;
  //               futureCata =
  //                   fetchDoc(_mySelection!.id) as Future<List<Catagories?>>;
  //             });
  //           },
  //           value: _mySelection,
  //         );
  //       });
  // }

  // FutureBuilder<List<Doc?>> buildFutureDocBuilder() {
  //   return FutureBuilder<List<Doc?>>(
  //       future: futureDoc,
  //       builder: (BuildContext context, AsyncSnapshot<List<Doc?>> snapshot) {
  //         if (!snapshot.hasData)
  //           return CupertinoActivityIndicator(
  //             animating: true,
  //           );
  //         return DropdownButtonFormField<Doc?>(
  //           isDense: true,
  //           // decoration: spinnerDecoration('Select your Cate'),
  //           items: snapshot.data!
  //               .map((category) => DropdownMenuItem<Doc?>(
  //                     child: Text(category!.name),
  //                     value: category,
  //                   ))
  //               .toList(),
  //           onChanged: (selectedValue) {
  //             setState(() {
  //               _mySelection2 = selectedValue;
  //             });
  //           },
  //           value: _mySelection2,
  //         );
  //       });
  // }

  // FutureBuilder<List<Catagories>> buildFutureCateBuilder() {
  //   return FutureBuilder<List<Catagories>>(
  //     future: futureCata,
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         List<Catagories> cata = snapshot.data!;
  //         return Column(
  //           children: [
  //             new Center(
  //       child: new DropdownButton(
  //         items: cata.map((item) {
  //           return new DropdownMenuItem(
  //             child: new Text(item.categoryName),
  //             value: item.id.toString(),
  //           );
  //         }).toList(),
  //         onChanged: (newVal) {
  //           setState(() {
  //             _mySelection = newVal;
  //           });
  //         },
  //         value: _mySelection,
  //       ),
  //     ),
  //   );
  //           ],
  //         );
  //       } else if (snapshot.hasError) {
  //         return Text('${snapshot.error}');
  //       }

  //       return const CircularProgressIndicator();
  //     },
  //   );
  // }
}
