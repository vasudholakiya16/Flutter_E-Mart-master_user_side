import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/views/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../consts/firebase_constent.dart';

class ChatsController extends GetxController {
  ChatsController(this.currentUserId, this.ownerId) {
    getChatId();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    getChatId();
  }

  String ownerId;
  String currentUserId;
  var chats = firestore.collection(chatCollections);
  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];
  var senderName = Get.find<HomeContainer>().username;
  var currentId = currentUser!.uid;
  var msgController = TextEditingController();
  dynamic chatDocId;
  var isLoading = true.obs;

  dynamic fromId;

  getChatId() async {
    isLoading(true);

    print("Have a nice day");
    await chats
        .where('user', isEqualTo: {
          friendId: ownerId,
          currentId: currentUserId,
        })
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          print("vasu D");
          if (snapshot.docs.isNotEmpty) {
            print("abcd");
            chatDocId = snapshot.docs.first.id;
            print(chatDocId);
            // print(fromId);
            print(ownerId);
          } else {
            chats.add({
              'created_on': null,
              'last_msg': '',
              'user': {friendId: ownerId, currentId: currentUserId},
              'toId': '',
              'fromId': '',
              'friend_name': friendName,
              'sender_name': senderName
            }).then((value) {
              {
                chatDocId = value.id;
              }
            });
          }
        });
    isLoading(false);
  }

  sendMsg(String chatID, String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatID).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': ownerId,
        'formId': currentUserId
      });
      chats.doc(chatID).collection(messagesCollections).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentUserId,
        'toId' :ownerId
      });
    }
  }
}
