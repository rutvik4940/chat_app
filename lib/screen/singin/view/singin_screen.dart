import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helper/auth_helper.dart';
import '../../home/controller/home_controller.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Image.asset(
                    "assets/image/r3.png",
                    height: 150,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Sign in to your Account",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    autofocus: false,
                    decoration:controller.Theme==true?InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(color: Colors.white)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50) ,
                        borderSide: const BorderSide(
                          color: Colors.white ,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      label:  Text(
                        "Email",
                        style: TextStyle(color:controller.Theme==true?  Colors.white: Colors.black),
                      ),
                    ): InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Colors.black)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50) ,
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      label:  Text(
                        "Email",
                        style: TextStyle(color:controller.Theme==true?  Colors.white: Colors.black),
                      ),
                    ),
                    controller: txtEmail,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() => TextField(
                      obscureText: controller.isHide.value,
                      autofocus: false,
                      decoration:controller.Theme==true?InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50) ,
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                            color: Colors.white ,

                          ),
                        ),
                        suffixIcon: InkWell(
                            onTap: () {
                              controller.hidePassword();
                            },
                            child: Icon(controller.isHide.value?Icons.visibility_off:Icons.visibility)),
                        label:  Text(
                          "Password",
                          style: TextStyle(color:controller.Theme==true?  Colors.white: Colors.black),
                        ),
                      ): InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50) ,
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                            color: Colors.black,

                          ),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            controller.hidePassword();
                          },
                            child: Icon(controller.isHide.value?Icons.visibility_off:Icons.visibility)),
                        label: const Text(
                          "Password",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      controller: txtPassword,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color(0xff031C48D),
                      ),
                    ),
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
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                        child: Image.asset(
                          "assets/logo/google.png",
                          height: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          String msg = await AuthHelper.helper.guestSignIn();
                          if (msg == 'Success') {
                            Get.offAllNamed('profile');
                          } else {
                            Get.snackbar('$msg', "");
                          }
                        },
                        child: Image.asset(
                          "assets/image/user.png",
                          height: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                        "Did you have an Account?",
                        style: TextStyle(color:controller.Theme==true?  Colors.white: Colors.black, fontSize: 15),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed('singup');
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff031C48D),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
