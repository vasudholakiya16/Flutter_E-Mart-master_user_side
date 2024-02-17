import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/controller/auth_controllerCreat.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets_same/appLogo_widgets.dart';
import 'package:emart_app/widgets_same/background_widget.dart';
import 'package:emart_app/widgets_same/custome_text_fild.dart';
import 'package:emart_app/widgets_same/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  // Text Controller
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwoedcontroller = TextEditingController();
  var contretupePasswordroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            5.heightBox,
            "Join the $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      hint: NameHint,
                      title: Name,
                      controller: namecontroller,
                      isPass: false),
                  customTextField(
                      hint: emailHint,
                      title: email,
                      controller: emailcontroller,
                      isPass: false),
                  customTextField(
                      hint: passwordHint,
                      title: password,
                      controller: passwoedcontroller,
                      isPass: true),
                  customTextField(
                      hint: passwordHint,
                      title: retypePassword,
                      controller: contretupePasswordroller,
                      isPass: true),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgetPass.text.make())),

                  Row(
                    children: [
                      Checkbox(
                          activeColor: redColor,
                          checkColor: whiteColor,
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          }),
                      5.widthBox,
                      Expanded(
                        child: RichText(
                            text: const TextSpan(
                          children: [
                            TextSpan(
                                text: "I aggre to to the",
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: fontGrey,
                                )),
                            TextSpan(
                                text: termAndCond,
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: redColor,
                                )),
                            TextSpan(
                                text: "&",
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: fontGrey,
                                )),
                            TextSpan(
                                text: privacyPolicy,
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: redColor,
                                )),
                          ],
                        )),
                      )
                    ],
                  ),
                  5.heightBox,
                  // ourButton().box.width(context.screenWidth - 50).make(),
                  controller.isloading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : ourButton(
                              color: isCheck == true ? redColor : lightGrey,
                              title: Signup,
                              textColor: whiteColor,
                              onpress: () async {
                                if (isCheck != false) {
                                  controller.isloading(true);
                                  try {
                                    await controller.SignupMethod(
                                            context: context,
                                            email: emailcontroller.text,
                                            password: passwoedcontroller.text)
                                        .then((value) {
                                      return controller.storeUserData(
                                          email: emailcontroller.text,
                                          password: passwoedcontroller.text,
                                          Name: namecontroller.text);
                                    }).then((value) {
                                      VxToast.show(context, msg: loggedin);
                                      Get.offAll(() => Home());
                                    });
                                  } catch (e) {
                                    auth.signOut();
                                    VxToast.show(context, msg: e.toString());
                                    controller.isloading(false);
                                  }
                                }
                              },
                              onPress: () {})
                          .box
                          .width(context.screenWidth - 50)
                          .make(),
                  10.heightBox,
                  // RichText(
                  //   text: TextSpan(
                  //     children: [
                  //       TextSpan(
                  //           text: alreadyHaveAccount,
                  //           style: TextStyle(
                  //             fontFamily: bold,
                  //             color: fontGrey,
                  //           ))
                  //     ],
                  //   ),
                  // )
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ),
            10.heightBox,

            // wrapping into gested detector widgets
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: alreadyHaveAccount,
                    style: TextStyle(fontFamily: bold, color: fontGrey),
                  ),
                  TextSpan(
                    text: login,
                    style: TextStyle(fontFamily: bold, color: redColor),
                  )
                ],
              ),
            ).onTap(() {
              Get.back();
            })
          ],
        ),
      ),
    ));
  }
}
