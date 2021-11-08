import 'package:flutter/material.dart';
import 'package:test2/modals/background.dart';
import 'package:test2/services/auth.dart';
import 'home_screen.dart';

AuthMethods _authMethods = AuthMethods();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _pw1EditingController = TextEditingController();

  String userEmail = '';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: height,
            width: width,
            child: Background(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.mail),
                        labelText: 'email',
                      ),
                      controller: _emailEditingController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: '密碼',
                      ),
                      controller: _pw1EditingController,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'registerScreen');
                          },
                          child: const Text(
                            '沒有賬號?',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () async {
                        final String email =
                            _emailEditingController.text.trim();
                        final String password =
                            _pw1EditingController.text.trim();

                        var user = await _authMethods.signIn(email, password);
                        if (user == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              action: SnackBarAction(
                                label: '關閉',
                                onPressed: () {},
                              ),
                              content: const Text('賬號與密碼錯誤!'),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                userEmailFromOthers: email,
                              ),
                            ),
                          );
                          // Navigator.pushNamed(context, 'homeScreen',
                          //     arguments: userEmail = email);
                        }
                      },
                      child: const Text('登入'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
