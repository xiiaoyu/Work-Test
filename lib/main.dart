import 'package:flutter/material.dart';
import 'package:test2/screens/home_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegisterScreen(),
      initialRoute: 'loginScreen',
      routes: {
        'loginScreen': (context) => const LoginScreen(),
        'registerScreen': (context) => const RegisterScreen(),
        'homeScreen': (context) => const HomeScreen(
              userEmailFromOthers: '',
            ),
      },
    );
  }
}
