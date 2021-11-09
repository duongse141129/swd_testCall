
// import 'package:advisories_lawyer/models/user_account.dart';
// import 'package:flutter/cupertino.dart';

// class UserPage extends StatefulWidget {
//   const UserPage({ Key? key }) : super(key: key);

//   @override
//   _UserPageState createState() => _UserPageState();
// }

// class _UserPageState extends State<UserPage> {
//   late Future<List<Users>> futureUsers;
//   Future<Users>? _futureUser;
//   @override
//   void initState() {
//     super.initState();
//     futureUsers = fetchUser();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }

//   FutureBuilder<List<Users>> buildUserFutureBuilder(){
//   return FutureBuilder<List<Users>>(
//           future: futureUsers,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               List<Users> users = snapshot.data!;

//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Các Câu Hỏi Về " + users[0].role),
//                         Text(users[0].name + "\n"),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             } else if (snapshot.hasError) {
//               return Text('${snapshot.error} lỗi ');
//             }

//             // By default, show a loading spinner.
//             return const CircularProgressIndicator();
//           },
//         ),
// }
// }


