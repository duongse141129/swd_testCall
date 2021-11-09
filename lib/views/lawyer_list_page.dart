import 'dart:io';

import 'package:advisories_lawyer/models/customer_case.dart';
import 'package:advisories_lawyer/models/documents.dart';
import 'package:advisories_lawyer/models/lawyer.dart';
import 'package:advisories_lawyer/views/booking_page.dart';
import 'package:advisories_lawyer/views/customer_case_page.dart';
import 'package:advisories_lawyer/views/login_page.dart';
import 'package:advisories_lawyer/views/lawyer_slot_page.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class LawyerListPage extends StatefulWidget {
  final int categoryID;

  final CustomerCase customerCase;
  const LawyerListPage(this.categoryID, this.customerCase);

  @override
  _LawyerPageState createState() => _LawyerPageState(categoryID: categoryID, customerCase: customerCase);
}

class _LawyerPageState extends State<LawyerListPage> {
  late Future<List<Lawyer>> futureLawyer;
  late final int categoryID;
  late final CustomerCase customerCase;
  _LawyerPageState({required this.categoryID, required this.customerCase});
  @override
  void initState() {
    super.initState();
    futureLawyer = fetchLawyer(categoryID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lawyer List'),
        backgroundColor: Colors.purple[400],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: FutureBuilder<List<Lawyer>>(
                future: futureLawyer,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Lawyer> lawyer = snapshot.data!;

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: InkWell(
                            onTap: () {
                              
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LawyerListSchedule(
                                          lawyer[index].id, customerCase)));
                            },
                            child: Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: Text(lawyer[index].name[0]),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lawyer[index].name,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.green),
                                    ),
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Text(lawyer[index].description,
                                            style: TextStyle(
                                              color: Colors.black,
                                            )),
                                      ],
                                    ),
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Text(
                                            'Phone: ${lawyer[index].phoneNumber}',
                                            style: TextStyle(
                                              color: Colors.black,
                                            )),
                                      ],
                                    ),
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Text(
                                            'Website: ${lawyer[index].website}',
                                            style: TextStyle(
                                              color: Colors.black,
                                            )),
                                      ],
                                    ),
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Text(lawyer[index].sex,
                                            style: TextStyle(
                                              color: Colors.black,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error} lỗi ');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
