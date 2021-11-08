import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test2/services/auth.dart';

AuthMethods _authMethods = AuthMethods();

String userEmail = '';
String userName = '';
String createdTime = '';

class HomeScreen extends StatefulWidget {
  final String userEmailFromOthers;
  const HomeScreen({Key? key, required this.userEmailFromOthers})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future getUserInfo() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userEmailFromOthers)
          .get();

      String time = documentSnapshot.get('createdAt');
      String mail = documentSnapshot.get('userEmail');
      String name = documentSnapshot.get('userName');

      setState(() {
        createdTime = time;
        userEmail = mail;
        userName = name;
      });

      return;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(userEmail),
            Text(userName),
            Text(createdTime),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                await _authMethods.logOut().then(
                      (value) => Navigator.pushNamed(context, 'loginScreen'),
                    );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              child: const Text(
                '登出',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(userName),
//             Text('asd'),
//             SizedBox(
//               height: 20,
//             ),
//             TextButton(
//               onPressed: () async {
//                 await _authMethods.logOut().then(
//                       (value) => Navigator.pushNamed(context, 'loginScreen'),
//                     );
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//               ),
//               child: const Text(
//                 '登出',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
