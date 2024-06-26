import 'package:chat_app_2/screen/chat/model/chat_model.dart';
import 'package:chat_app_2/screen/profile/model/profile_model.dart';
import 'package:chat_app_2/utils/helper/auth_helper.dart';
import 'package:chat_app_2/utils/helper/firedb_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/controller/home_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  profileModel model = Get.arguments;
  TextEditingController txtMessage = TextEditingController();
  HomeController controller = Get.put(HomeController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.black,
        leadingWidth: 100,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back,color:  Color(0xff031C48D),),
            ),
            CircleAvatar(
              backgroundColor: Color(0xff031C48D),
              radius: 20,
              child: Text("${model.name!.substring(0, 1)}",style: TextStyle(color: Colors.black),),
            )
          ],
        ),
        centerTitle: true,
        title: Text(
          "${model.name}",
        ),
      ),
      body: Stack(
        children: [
          Obx(
                () => controller.Theme.value == true
                ? Image.asset(
              "assets/image/w2.png",
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              fit: BoxFit.cover,
            )
                : Image.asset(
              "assets/image/r1.png",
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FireDBHelper.helper
                      .getchat(AuthHelper.helper.user!.uid, model.uid!),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      List<ChatModel> l1 = [];
                      QuerySnapshot? qs = snapshot.data;
                      List<QueryDocumentSnapshot>? qsList = qs?.docs;
                      for (var x in qsList!) {
                        String id = x.id;
                        Map? m1 = x.data() as Map;
                        ChatModel chat = ChatModel.mapToModel(m1, id);
                        l1.add(chat);
                      }
                          return ListView.builder(
                            itemCount: l1.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  Get.defaultDialog(
                                      title: "are you sure ?",
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            if(l1[index].uid==AuthHelper.helper.user!.uid)
                                            {
                                              await FireDBHelper.helper.deleteMessage(l1[index].id!);
                                            }
                                            Get.back();
                                          },
                                          child: const Text("Yes",style: TextStyle(color: Colors.blue),),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text("No"),
                                        ),
                                      ]);
                                },
                                child: Container(
                                  alignment: l1[index].uid ==
                                      AuthHelper.helper.user!.uid
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: l1[index].uid ==
                                          AuthHelper.helper.user!.uid
                                          ?Color(0xffDDFFEC)
                                          : Colors.white,
                                      borderRadius:  BorderRadius.circular(10)
                                    ),
                                    child: Row(
                                     mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "${l1[index].msg}",
                                          style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          "${l1[index].time}",
                                          style: const TextStyle(color: Colors.black,fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                    }
                    return Container();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: txtMessage,
                  decoration:controller.Theme ==true? InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50) ,
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.white  ,

                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Type...",
                    suffixIcon: IconButton(
                      onPressed: () {
                        ChatModel c1 = ChatModel(
                          uid: AuthHelper.helper.user!.uid,
                          // date: "${DateTime.now().hour}:${DateTime.now().minute}",
                          time: "${DateTime.now().hour}:${DateTime.now().minute}",
                          msg: txtMessage.text,
                        );
                        txtMessage.clear();
                        FireDBHelper.helper.sendMessage(c1, model);
                      },
                      icon: const Icon(
                        Icons.send,
                      ),
                    ),
                  ):InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50) ,
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.black,

                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Type...",
                    suffixIcon: IconButton(
                      onPressed: () {
                        ChatModel c1 = ChatModel(
                          uid: AuthHelper.helper.user!.uid,
                          // date: "${DateTime.now().hour}:${DateTime.now().minute}",
                          time: "${DateTime.now().hour}:${DateTime.now().minute}",
                          msg: txtMessage.text,
                        );
                        txtMessage.clear();
                        FireDBHelper.helper.sendMessage(c1, model);
                      },
                      icon: const Icon(
                        Icons.send,
                      ),
                    ),
                  )
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
