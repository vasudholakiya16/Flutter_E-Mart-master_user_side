import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/loadingIndicator.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/chat_screen/component/sender_bubble.dart';
import 'package:emart_app/views/controller/chat_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chatscreen extends StatelessWidget {
  Chatscreen({Key? key,required this.ownerId}) : super(key: key);

  String ownerId;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(
        ChatsController(ownerId, FirebaseAuth.instance.currentUser!.uid));
    final StreamController streamController = StreamController();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${controller.friendName}"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: loadingIndicator(),
                    )
                  : Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FireStoreServices.getChatMessages(
                            controller.chatDocId),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: loadingIndicator(),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            //return Text('data');
                            return Center(
                              child: "Send a massage..."
                                  .text
                                  .color(darkFontGrey)
                                  .make(),
                            );
                          } else {
                            Text("data");

                            return ListView(
                              children: snapshot.data!.docs
                                  .mapIndexed((currentValue, index) {
                                var data = snapshot.data!.docs[index];
                                return Align(
                                    alignment: data['uid'] == currentUser!.uid
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: senderBubble(data));
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: controller.msgController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey),
                      ),
                      hintText: "Type a message..."),
                )),
                IconButton(
                    onPressed: () {
                      controller.sendMsg(
                          controller.chatDocId, controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: Icon(
                      Icons.send,
                      color: redColor,
                    ))
              ],
            )
                .box
                .height(75)
                .padding(EdgeInsets.all(12))
                .margin(EdgeInsets.only(bottom: 10))
                .make(),
          ],
        ),
      ),
    );
  }
}
