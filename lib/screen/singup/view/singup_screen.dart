import 'package:chat_app_2/utils/helper/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/image/p1.png",
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            fit: BoxFit.cover,
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                      "Sing up",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
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
                        String msg = await AuthHelper.helper.signup(txtEmail.text, txtPassword.text);
                        if (msg == 'success') {
                          Get.back();
                        } else {
                          Get.snackbar('$msg', "");
                        }
                      },
                      child: const Text("Sing up",style: TextStyle(color: Colors.white),),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("All ready your account"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],

      ),
    );
  }
}
