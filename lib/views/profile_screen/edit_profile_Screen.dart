import 'dart:io';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/controller/profile_controller.dart';
import 'package:emart_app/widgets_same/background_widget.dart';
import 'package:emart_app/widgets_same/custome_text_fild.dart';
import 'package:emart_app/widgets_same/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          // Wrap the Column with SingleChildScrollView
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                controller.ProfileImagePath.isEmpty
                    ? Image.asset(
                        imgProfile2,
                        width: 70,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : Image.file(
                        File(controller.ProfileImagePath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                ourButton(
                    onpress: () {
                      controller.changeImage(context);
                    },
                    color: redColor,
                    textColor: whiteColor,
                    title: "change",
                    onPress: () {}),
                Divider(),
                10.heightBox,
                customTextField(
                  controller: controller.nameController,
                  // Name
                  hint: NameHint,
                  title: Name,
                  isPass: false,
                ),
                10.heightBox,
                customTextField(
                  controller: controller.oldpassController,
                  // password
                  hint: passwordHint,
                  title: oldpassword,
                  isPass: true,
                ),
                10.heightBox,
                customTextField(
                  controller: controller.newpassController,
                  // password
                  hint: passwordHint,
                  title: newpassword,
                  isPass: true,
                ),
                20.heightBox,
                controller.isloading.value
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : SizedBox(
                        width: context.screenWidth - 40,
                        child: ourButton(
                            onpress: () async {
                              controller.isloading(true);
                              // if Image is not selected
                              if (controller
                                  .ProfileImagePath.value.isNotEmpty) {
                                await controller.uplodeProfileImage();
                              } else {
                                controller.profileImageLink = data['imageUrl'];
                              }
                              // old password matches your database
                              if (data['password'] ==
                                  controller.oldpassController.text) {
                                await controller.changeAuthPassword(
                                    email: data['email'],
                                    password: controller.oldpassController.text,
                                    newpassword:
                                        controller.newpassController.text);
                                await controller.updateProfile(
                                    imageUrl: controller.profileImageLink,
                                    name: controller.nameController.text,
                                    password:
                                        controller.newpassController.text);
                                VxToast.show(context, msg: "Updated");
                              } else {
                                VxToast.show(context,
                                    msg: "Your password is incorrect");
                                controller.isloading(false);
                              }
                            },
                            color: redColor,
                            textColor: whiteColor,
                            title: "Save",
                            onPress: () {}),
                      ),
              ],
            )
                .box
                .white
                .shadowSm
                .padding(EdgeInsets.all(16))
                .margin(EdgeInsets.only(top: 50, left: 12, right: 12))
                .rounded
                .make(),
          ),
        ),
      ),
    );
  }
}
