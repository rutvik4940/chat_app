import 'package:chat_app_2/screen/chat/model/chat_model.dart';
import 'package:chat_app_2/screen/profile/model/profile_model.dart';
import 'package:chat_app_2/utils/helper/auth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FireDBHelper {
  static FireDBHelper helper = FireDBHelper._();

  FireDBHelper._();

  var db = FirebaseFirestore.instance;
  String? chatId ;
  profileModel? currentUsear;

  Future<void> userProfile(profileModel model) async {
    await db.collection("user1").doc(AuthHelper.helper.user!.uid).set({
      "name": model.name,
      "email": model.email,
      "profile": model.profile,
      "number": model.number,
      "uid": model.uid,
      "token":model.token,
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile() {
    return db.collection("user1").doc(AuthHelper.helper.user!.uid).get();
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getData()
  {

    return db
        .collection("chat")
        .where("uid", arrayContainsAny: [AuthHelper.helper.user!.uid])
        .snapshots();
  }
  Future<void> getCurrentUser()
  async {
   DocumentSnapshot ds =await db.collection("user1").doc(AuthHelper.helper.user!.uid).get();
   Map m1=ds.data()as Map;
   currentUsear=profileModel.mapToModel(m1, ds.id);

  }

  Future<QuerySnapshot<Map<String, dynamic>>> allContact() {
    return db
        .collection("user1")
        .where("uid", isNotEqualTo: AuthHelper.helper.user!.uid)
        .get();
  }

  Future<void> sendMessage(ChatModel model, profileModel p1) async {
    if (chatId!=null) {
      AddMessage(chatId!, model, p1);
    } else {
       chatId = await addChatUID(p1);
      AddMessage(chatId!, model, p1);
    }
  }

  Future<void> AddMessage(
      String docId, ChatModel model, profileModel p1) async {
    await db.collection("chat").doc(docId).collection("msg").add({
      "date": "${model.date}",
      "time": "${model.time}",
      "uid": "${AuthHelper.helper.user!.uid}",
      "msg": "${model.msg}"
    });
  }

  Future<String> addChatUID(profileModel p1) async {
    DocumentReference reference = await db.collection("chat").add({
      "uid": [p1.uid, AuthHelper.helper.user!.uid],
      "name":[p1.name,currentUsear!.name],
      "number":[p1.number,currentUsear!.number],
      "email":[p1.email,currentUsear!.email],
      "profile":[p1.profile,currentUsear!.profile]
    });
    return reference.id;
  }
  Future<void> getChat(String myUid,String userUid)
  async {
    QuerySnapshot qs=await db.collection("chat").where("uid",arrayContainsAny: [myUid,userUid]).get();
    List<DocumentSnapshot>dsList=qs.docs.where((e) {
      List uids=e['uid'];
      if(uids.contains(myUid) && uids.contains(userUid))
        {
          return true;
        }
      return false;
    },).toList();
    if(dsList.isNotEmpty)
      {
        chatId=dsList[0].id;
      }
    else
      {
        chatId=null;
      }
  }
  Stream<QuerySnapshot<Map<String, dynamic>>>? getchat(String myUid,String userUid)
  {
    if (chatId!=null) {
       return  db.collection("chat").doc(chatId).collection("msg").orderBy("date").snapshots();
    }
  }
  Future<void> deleteMessage( String docId)
  async{
    return db.collection("chat").doc(chatId).collection("msg").doc(docId).delete();
  }

}
