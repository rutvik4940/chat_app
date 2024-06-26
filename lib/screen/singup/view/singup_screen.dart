import 'package:chat_app_2/utils/helper/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../home/controller/home_controller.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/image/r3.png",
                    height: 150,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Sign up to your Account",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                          .signup(txtEmail.text, txtPassword.text);
                      if (msg == 'success') {
                        Get.back();
                      } else {
                        Get.snackbar('$msg', "");
                      }
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child:  Text(
                      "All ready your account",
                      style: TextStyle(color: controller.Theme==true?Colors.white:Colors.black, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
