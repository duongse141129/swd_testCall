import 'dart:io';

import 'package:advisories_lawyer/lawyer/model_lawyer/category.dart';
import 'package:advisories_lawyer/models/documents.dart';
import 'package:advisories_lawyer/views/customer_case_page.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DocPage extends StatefulWidget {
  final int categoryID;
  const DocPage(this.categoryID);

  @override
  _DocPageState createState() => _DocPageState(categoryID: categoryID);
}

class _DocPageState extends State<DocPage> {
  _DocPageState({required this.categoryID});
  late Future<List<Doc>> futureDoc;
  final int categoryID ;
  @override
  void initState() {
    super.initState();
    futureDoc = fetchDoc(categoryID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document'),
        backgroundColor: Colors.purple[400],
      ),
      body: Center(
        child: FutureBuilder<List<Doc>>(
          future: futureDoc,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Doc> doc = snapshot.data!;
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomerCasePage(),
                            settings: RouteSettings(
                              arguments: doc[index],
                            
                            ),
                          ));
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Câu hỏi: ' + doc[index].name,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            doc[index].description + "\n",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
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
    );
  }
}
