import 'package:chat_app_2/screen/chat/model/chat_model.dart';
import 'package:chat_app_2/screen/profile/model/profile_model.dart';
import 'package:chat_app_2/utils/helper/auth_helper.dart';
import 'package:chat_app_2/utils/helper/firedb_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';

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

        // shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: CircleAvatar(
            radius: 20,
            child: Text(
              "${model.name!.substring(0, 1)}",
            ),
          ),
        ),

        centerTitle: true,
        title: Text("${model.name}",),
      ),
      body: Stack(
        children: [
         Obx(() =>
           controller.Theme.value==true?Image.asset(
                   "assets/image/w2.png",
                   height: MediaQuery.sizeOf(context).height,
                   width: MediaQuery.sizeOf(context).width,
                   fit: BoxFit.cover,
                 ):  Image.asset(
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
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: l1.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onLongPress: () async {
                                    await FireDBHelper.helper.deletMessage(
                                        AuthHelper.helper.user!.uid,
                                        l1[index].uid!);
                                  },
                                  child: Container(
                                    alignment: l1[index].uid ==
                                            AuthHelper.helper.user!.uid
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      width:MediaQuery.sizeOf(context).width*0.20,
                                      alignment: Alignment.topCenter,
                                      decoration: BoxDecoration(
                                        color: l1[index].uid ==
                                                AuthHelper.helper.user!.uid
                                            ? Colors.green.shade100
                                            : Colors.white,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight:Radius.circular(5),
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        ),
                                      ),
                                      child: Text("${l1[index].msg}",
                                         style: const TextStyle(color: Colors.black),),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    // hintStyle: TextStyle(color: Colors.white),
                    hintText: "Type",
                    suffixIcon: IconButton(
                      onPressed: () {
                        ChatModel c1 = ChatModel(
                            uid: AuthHelper.helper.user!.uid,
                            date: "${DateTime.now()}",
                            time: "${TimeOfDay.now()}",
                            msg: txtMessage.text);
                        txtMessage.clear();
                        FireDBHelper.helper.sendMessage(c1, model);
                      },
                      icon: const Icon(
                        Icons.send,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
