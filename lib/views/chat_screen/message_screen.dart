import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/loadingIndicator.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "No Messages yet!".text.color(darkFontGrey).make(),
            );
          } else {
            var data=snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(child: ListView.builder(itemCount:data.length ,itemBuilder: (BuildContext context,int index){
                    return Card(
                      child: ListTile(
                        onTap: (){
                          Get.to(()=>Chatscreen(ownerId:data[index]['toId']),
                          arguments:
[data[index]['friend_name'].toString(), data[index]['toId'].toString()]

                          );
                        },
                        leading: CircleAvatar(
                          backgroundColor: redColor,
                          child: Icon(Icons.person,color: Colors.white,),
                        ),
                        title: "${data[index]['friend_name']}".text.fontFamily(semibold).make(),
                        subtitle: "${data[index]['last_msg']}".text.fontFamily(semibold).make(),
                      ),
                    );

                  })),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

