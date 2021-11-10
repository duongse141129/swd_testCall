import 'package:advisories_lawyer/models/lawyer.dart';
import 'package:flutter/material.dart';

class LawyerPage extends StatefulWidget {
  const LawyerPage({Key? key}) : super(key: key);

  @override
  _LawyerPageState createState() => _LawyerPageState();
}

class _LawyerPageState extends State<LawyerPage> {
  late Future<List<Lawyer>> futureLawyer;
  @override
  void initState() {
    super.initState();
    futureLawyer = fetchAllLawyer();
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
                            onTap: () {},
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
                                          fontSize: 40,
                                          color: Colors.purple.shade400),
                                    ),
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Text(lawyer[index].description,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20)),
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
                                                fontSize: 20)),
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
                                                fontSize: 20)),
                                      ],
                                    ),
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Text(lawyer[index].sex,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20)),
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
