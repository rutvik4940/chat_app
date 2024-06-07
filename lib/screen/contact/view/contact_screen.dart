import 'package:chat_app_2/screen/profile/model/profile_model.dart';
import 'package:chat_app_2/utils/helper/auth_helper.dart';
import 'package:chat_app_2/utils/helper/firedb_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select contect"),

      ),
      body: FutureBuilder(
        future: FireDBHelper.helper.allContact(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {
            List<profileModel> list = [];
            QuerySnapshot? q1 = snapshot.data;
              List<QueryDocumentSnapshot>? listq = q1?.docs;
              for (var x in listq!) {
                Map m1 = x.data() as Map;
                profileModel p1 = profileModel.mapToModel(m1,x.id);
                list.add(p1);
              }
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    await FireDBHelper.helper.getChat(AuthHelper.helper.user!.uid, list[index].uid!);
                    Get.toNamed('chat',arguments: list[index]);
                  },
                  child: ListTile(
                    leading:  CircleAvatar(radius: 30,child: Text("${list[index].name!.substring(0,1)}",style: TextStyle(fontSize: 30),),),
                    title:Text("${list[index].name}",style:
                        Theme.of(context).textTheme.titleSmall),
                    subtitle: Text("${list[index].number}",style:
                    Theme.of(context).textTheme.titleSmall),
                  ),
                );
              },
            );
          }
          return  const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
