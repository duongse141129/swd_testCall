import 'package:advisories_lawyer/lawyer/document_page.dart';
import 'package:advisories_lawyer/lawyer/model_lawyer/category.dart';
import 'package:advisories_lawyer/models/network_lawyer/network_request.dart';
import 'package:advisories_lawyer/views/document_page.dart';
import 'package:flutter/material.dart';

class CategoryCusPage extends StatefulWidget {
  const CategoryCusPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryCusPage> {
  List<CategoryDTO> categoryData = <CategoryDTO>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkRequest.fetachCategories().then((dataFromSever) {
      setState(() {
        categoryData = dataFromSever;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        backgroundColor: Colors.purple[400],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  //list
                  itemCount: categoryData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DocPage(categoryData[index].id)));
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
                                '${categoryData[index].categoryName}',
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
