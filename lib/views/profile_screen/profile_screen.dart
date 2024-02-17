import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/consts/loadingIndicator.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/auth_screen/loginScreen.dart';
import 'package:emart_app/views/controller/auth_controllerCreat.dart';
import 'package:emart_app/views/controller/profile_controller.dart';
import 'package:emart_app/views/profile_screen/components/details_card.dart';
import 'package:emart_app/views/profile_screen/edit_profile_Screen.dart';
import 'package:emart_app/views/wishlist_screen/wishlist_screen.dart';
import 'package:emart_app/widgets_same/background_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../chat_screen/message_screen.dart';
import '../orders_screen/orders_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FireStoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            print(snapshot.data);
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor)),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                child: Column(
                  children: [
                    // edit profile buttons
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.edit,
                            color: whiteColor,
                          )).onTap(() {
                        controller.nameController.text = data["name"];
                        Get.to(() => EditProfileScreen(data: data));
                      }),
                    ),
                    // user detail section

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          data['imageUrl'] == ''
                              ? Image
                              .asset(
                            imgProfile2,
                            width: 70,
                            fit: BoxFit.cover,
                          )
                              .box
                              .roundedFull
                              .clip(Clip.antiAlias)
                              .make()
                              : Image
                              .network(
                            data['imageUrl'],
                            width: 70,
                            fit: BoxFit.cover,
                          )
                              .box
                              .roundedFull
                              .clip(Clip.antiAlias)
                              .make(),
                          5.widthBox,
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data['name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .white
                                      .make(),
                                  "${data['email']}".text.white.make()
                                ],
                              )),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: whiteColor)),
                              onPressed: () async {
                                await Get.put(AuthController())
                                    .signoutMethod(context);
                                Get.offAll(() => const LoginScreen());
                              },
                              child:
                              logout.text
                                  .fontFamily(semibold)
                                  .white
                                  .make())
                        ],
                      ),
                    ),
                    20.heightBox,

                    FutureBuilder(future: FireStoreServices.getCounts(),
                        builder: (BuildContext context,
                            AsyncSnapshot snapshots) {
                      if(!snapshot.hasData){
                        print("abc");
                        return Center(child: loadingIndicator());
                      } else{
                        print(snapshot.data);
                        return  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCard(
                                count: data['cart_count'],
                                title: "in your cart",
                                width: context.screenWidth / 3.4),
                            detailsCard(
                                count: data['wishlist_count'],
                                title: "in your wishlist",
                                width: context.screenWidth / 3.2),
                            detailsCard(
                                count: data['order_count'],
                                title: "your orders",
                                width: context.screenWidth / 3.4),
                          ],
                        );
                      }

                        }),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     detailsCard(
                    //         count: data['cart_count'],
                    //         title: "in your cart",
                    //         width: context.screenWidth / 3.4),
                    //     detailsCard(
                    //         count: data['wishlist_count'],
                    //         title: "in your wishlist",
                    //         width: context.screenWidth / 3.2),
                    //     detailsCard(
                    //         count: data['order_count'],
                    //         title: "your orders",
                    //         width: context.screenWidth / 3.4),
                    //   ],
                    // ),
                    // buttons section
                    // 40.heightBox,

                    ListView
                        .separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: lightGrey,
                        );
                      },
                      itemCount: profileButtonsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => WishlistScreen());

                                break;
                              case 1:
                                Get.to(() => OrdersScreen());
                                break;
                              case 2:
                                Get.to(() => MessagesScreen());
                                break;
                            }
                          },
                          leading: Image.asset(
                            profileButtonIcons[index],
                            width: 25,
                          ),
                          title: "${profileButtonsList[index]}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                        );
                      },
                    )
                        .box
                        .white
                        .rounded
                        .margin(EdgeInsets.all(12))
                        .padding(EdgeInsets.symmetric(horizontal: 16))
                        .shadowSm
                        .make()
                        .box
                        .color(redColor)
                        .make(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
