import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/loadingIndicator.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'components/order_status.dart';
import 'order_details.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "No Order yet!".text.color(darkFontGrey).make(),
            );
          } else {
            var data= snapshot.data!.docs;
            return ListView.builder(itemCount: data.length,
                itemBuilder: (BuildContext context,int index){
              return ListTile(
                leading: "${index+1}".text.fontFamily(bold).color(darkFontGrey).xl.make(),
                // tileColor: lightGrey,
                title: data[index]['order_code'].toString().text.color(redColor).fontFamily(semibold).make(),
                subtitle: data[index]['total_amount'].toString().numCurrency.text.fontFamily(semibold).make(),
                trailing: IconButton(onPressed: (){
                  Get.to(() => OrderDetails(
                    data: snapshot.data!.docs[index],
                  ));
                },icon:Icon(Icons.arrow_forward_ios_rounded,color:darkFontGrey)),
              ) ;
                }
            );
          }
        },
      ),
    );
  }
}
