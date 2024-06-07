import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helper/auth_helper.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              "assets/image/p1.png",
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              fit: BoxFit.cover,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/image/b1.png",
                        height: 150,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Login",
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        autofocus: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Enter your email"),
                        ),
                        controller: txtEmail,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        autofocus: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Enter your password"),
                        ),
                        controller: txtPassword,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStatePropertyAll(Colors.blue)),
                        onPressed: () async {
                          String msg = await AuthHelper.helper
                              .signIn(txtEmail.text, txtPassword.text);
                          if (msg == 'success') {
                            Get.offAllNamed('profile');
                          } else {
                            Get.snackbar('$msg', "");
                          }
                          txtPassword.clear();
                          txtEmail.clear();
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed('singup');
                        },
                        child: const Text(
                          "Creat a account",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Or Login with ",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              String msg = await AuthHelper.helper.gLoging();
                              if (msg == 'Success') {
                                Get.offAllNamed('profile');
                              } else {
                                Get.snackbar('$msg', "");
                              }
                            },
                            child: Container(
                              height: 50,
                              width: 185,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(0.30),
                              ),
                              child: Container(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/logo/google.png",
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Continue with Google ")
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              String msg = await AuthHelper.helper.guestSignIn();
                              if (msg == 'Success') {
                                Get.offAllNamed('profile');
                              } else {
                                Get.snackbar('$msg', "");
                              }
                            },
                            child: Container(
                              height: 50,
                              width: 185,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(0.30),
                              ),
                              child: Container(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/logo/d1.png",
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Continue with Guest ")
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
