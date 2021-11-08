import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test2/modals/background.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:intl/intl.dart';
import 'package:test2/services/auth.dart';

import 'home_screen.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
AuthMethods _authMethods = AuthMethods();

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _pw1EditingController = TextEditingController();
  final TextEditingController _pw2EditingController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String userEmail = '';

  insertUserInfoWhenRegister() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat.yMd().add_jms();
    final String time = formatter.format(now);

    Map<String, dynamic> userInfo = {
      'userName': _nameEditingController.text,
      'userEmail': _emailEditingController.text,
      'createdAt': time,
    };

    try {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('users')
          .doc(_emailEditingController.text);

      documentReference.set(userInfo);
    } catch (e) {
      print(e.toString());
    }
  }

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
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: '姓名',
                        ),
                        controller: _nameEditingController,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.mail),
                          labelText: 'email',
                        ),
                        controller: _emailEditingController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!)
                              ? null
                              : "Email格式不正確.";
                        },
                      ),
                      TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: '密碼',
                          ),
                          controller: _pw1EditingController,
                          obscureText: true,
                          validator: Validators.compose([
                            Validators.required('密碼不能空!'),
                            Validators.patternString(
                                r'^(?=.*?[a-zA-Z])(?=.*?[0-9]).{8,}$',
                                '密碼最少為8個字和至少一個英文跟一個數字!')
                          ])
                          // validator: (value) {
                          //   Pattern pattern =
                          //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                          //   RegExp regex = RegExp(pattern);
                          //
                          //   if (value!.isEmpty) {
                          //     return '密碼不能空!';
                          //   } else if (value.length < 8) {
                          //     return '密碼最少為8個字!';
                          //   } else if (regex.hasMatch(value)) {
                          //     return '密碼最少為至少一個英文跟一個數字!';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: '確認密碼',
                        ),
                        controller: _pw2EditingController,
                        obscureText: true,
                        validator: (value) {
                          if (value != _pw1EditingController.text) {
                            return 'must same';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'loginScreen');
                            },
                            child: const Text(
                              '有賬號了?',
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

                          if (formKey.currentState!.validate()) {
                            var user =
                                await _authMethods.signUp(email, password);
                            if (user == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  action: SnackBarAction(
                                    label: '關閉',
                                    onPressed: () {},
                                  ),
                                  content: const Text('Email已被註冊!'),
                                ),
                              );
                            } else {
                              insertUserInfoWhenRegister();

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
                          }
                        },
                        child: const Text(
                          '註冊',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
