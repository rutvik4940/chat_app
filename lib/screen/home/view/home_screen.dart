import 'package:chat_app_2/screen/profile/model/profile_model.dart';
import 'package:chat_app_2/utils/helper/auth_helper.dart';
import 'package:chat_app_2/utils/helper/firedb_helper.dart';
import 'package:chat_app_2/utils/service/notification_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    FireDBHelper.helper.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chat",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              NotificationHelper.helper
                  .showNotification("Hello", "How are You");
            },
            icon: const Icon(Icons.notifications_active),
          ),
          IconButton(
            onPressed: () {
              NotificationHelper.helper.SchedulingNotification();
            },
            icon: const Icon(Icons.timer),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FireDBHelper.helper.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {
            List<profileModel> l1 = [];
            QuerySnapshot? qs = snapshot.data;
            List<QueryDocumentSnapshot> qList = qs!.docs;

            for (var x in qList) {
              Map m1 = x.data() as Map;
              List uids = m1['uid'];
              List name = m1['name'];
              List email = m1['email'];
              List number = m1['number'];
              List profile = m1['profile'];
              String uid = "";
              String name1 = "";
              String email1 = "";
              String number1 = "";
              String profile1 = "";
              if (uids[0] == AuthHelper.helper.user!.uid) {
                uid = uids[1];
                name1 = name[1];
                email1 = email[1];
                number1 = number[1];
                profile1 = profile[1];
              } else {
                uid = uids[0];
                name1 = name[0];
                email1 = email[0];
                number1 = number[0];
                profile1 = profile[0];
              }
              profileModel p1 = profileModel(
                name: name1,
                uid: uid,
                email: email1,
                number: number1,
                profile: profile1,
              );

              l1.add(p1);
            }
            return ListView.builder(
              itemCount: l1.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    await FireDBHelper.helper
                        .getChat(AuthHelper.helper.user!.uid, l1[index].uid!);
                    Get.toNamed('chat', arguments: l1[index]);
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xff031C48D),
                      child: Text(
                        "${l1[index].name!.substring(0, 1)}",
                        style: const TextStyle(fontSize: 30,color: Colors.black),
                      ),
                    ),
                    title: Text(
                      "${l1[index].name}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${l1[index].number}",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff031C48D),
        onPressed: () {
          Get.toNamed('contact');
        },
        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    FirebaseAuth.instance.currentUser!.photoURL == null
                        ? const Icon(
                            Icons.person,
                            size: 50,
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                "${FirebaseAuth.instance.currentUser!.photoURL}"),
                          ),
                    const SizedBox(
                      height: 5,
                    ),
                    Visibility(
                      visible: FirebaseAuth.instance.currentUser!.displayName !=
                          null,
                      child: Text(
                        "${FirebaseAuth.instance.currentUser!.displayName}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Visibility(
                      visible: FirebaseAuth.instance.currentUser!.email != null,
                      child: Text(
                        "${FirebaseAuth.instance.currentUser!.email}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                        Color(0xff031C48D),
                      )),
                      onPressed: () {
                        Get.toNamed('profile');
                      },
                      child: const Text(
                        " Edit profile",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Logout",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      IconButton(
                          onPressed: () async {
                            AuthHelper.helper.logOut();
                            Get.offAllNamed('signin');
                          },
                          icon: const Icon(Icons.login_outlined))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Theme",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Obx(
                        () => IconButton(
                          onPressed: () {
                            bool theme = controller.Theme.value;
                            theme = !theme;
                            controller.setData(theme);
                          },
                          icon: Icon(controller.icon.value),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
