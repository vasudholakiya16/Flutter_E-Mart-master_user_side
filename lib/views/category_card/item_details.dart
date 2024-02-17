// ignore_for_file: depend_on_referenced_packages

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/views/chat_screen/chat_screen.dart';
import 'package:emart_app/views/controller/product_controller.dart';
import 'package:emart_app/widgets_same/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;

  const ItemDetails({Key? key, required this.title, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(productController());
    // print(Colors.pink.value);
    // print(Colors.orange.value);
    // print(Colors.green.value);
    // print(Colors.purple.value);
    // print(Colors.yellow.value);

    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.resetValues();
                Get.back();
              },
              icon: Icon(Icons.arrow_back)),
          title: title != null
              ? title!.text.color(darkFontGrey).fontFamily(bold).make()
              : Text('No Title'), // Handle null title gracefully
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
              ),
            ),
            Obx(
              () => IconButton(
                onPressed: () {
                  if (controller.isFav.value) {
                    controller.removeFromWishlist(data.id, context);
                    controller.isFav(false);
                  } else {
                    controller.addToWishlist(data.id, context);
                    controller.isFav(true);
                  }
                },
                icon: Icon(
                  Icons.favorite_outlined,
                  color: controller.isFav.value ? redColor : darkFontGrey,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Swiper section
                      VxSwiper.builder(
                          autoPlay: true,
                          height: 350,
                          itemCount: data['p_images'].length,
                          // itemCount: 3,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          itemBuilder: (context, index) {
                            return Image.network(
                              data["p_images"][index],
                              // imgB2,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          }),
                      10.heightBox,
                      // Title and some extra details
                      title!.text
                          .size(16)
                          .color(darkFontGrey)
                          .fontFamily(bold)
                          .make(),
                      10.heightBox,
                      // Rating
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data['p_rating']),
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        count: 5,
                        size: 25,
                        maxRating: 5,
                      ),
                      10.heightBox,
                      "${data['p_price']}"
                          .numCurrency
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(18)
                          .make(),
                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Seller".text.white.fontFamily(semibold).make(),
                                5.heightBox,
                                "${data['p_seller']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .size(16)
                                    .make(),
                                10.heightBox,
                              ],
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.message_rounded,
                              color: darkFontGrey,
                            ),
                          ).onTap(() {
                            Get.to(
                              () => Chatscreen(ownerId: data['vender_id']),
                              arguments: [data['p_seller'], data['vender_id']],
                            );
                          })
                        ],
                      )
                          .box
                          .height(60)
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .color(textfieldGrey)
                          .make(),
                      // Color Section
                      20.heightBox,
                      Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Color: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Row(
                                  children: List.generate(
                                    data["p_color"].length,
                                        (index) => Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        VxBox()
                                            .size(40, 40)
                                            .roundedFull
                                            .color(Color(data["p_color"][index]))
                                            .margin(EdgeInsets.symmetric(
                                            horizontal: 3))
                                            .make()
                                            .onTap(() {
                                          controller.changeColorIndex(index);
                                        }),
                                        Visibility(
                                            visible: index ==
                                                controller.colorIndex.value,
                                            child: Icon(
                                              Icons.done,
                                              color: Colors.white,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ).box.padding(EdgeInsets.all(6)).make(),

                            // Quantity row
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quantity: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      IconButton(
                                          // use to decreaseQuantity
                                          onPressed: () {
                                            controller.decreaseQuantity();
                                            controller.calculateTotalPrice(
                                                int.parse(data['p_price']));
                                          },
                                          icon: Icon(Icons.remove)),
                                      controller.quantity.value.text
                                          .size(16)
                                          .fontFamily(bold)
                                          .make(),
                                      IconButton(
                                          // use to increaseQuantity
                                          onPressed: () {
                                            controller.increaseQuantity(
                                                int.parse(data['p_quantity']));
                                            controller.calculateTotalPrice(
                                                int.parse(data['p_price']));
                                          },
                                          icon: Icon(Icons.add)),
                                      10.widthBox,
                                      "${data['p_quantity']} Available"
                                          .text
                                          .color(textfieldGrey)
                                          .make(),
                                    ],
                                  ),
                                ),
                              ],
                            ).box.white.shadowSm.make(),
                            // Total row
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Total: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                "${controller.totalPrice.value}"
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .size(16)
                                    .fontFamily(bold)
                                    .make(),
                              ],
                            ).box.padding(EdgeInsets.all(6)).make(),
                          ],
                        ),
                      ),
                      // Description Section
                      10.heightBox,
                      "Description"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,
                      "${data['p_dec']} ".text.color(darkFontGrey).make(),
                      // buttons section
                      10.heightBox,
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          itemDetailButtonList.length,
                          (index) => ListTile(
                            title: itemDetailButtonList[index]
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            trailing: Icon(Icons.arrow_forward),
                          ),
                        ),
                      ),
                      10.heightBox,
                      //Product you may like Section
                      productsyoumayLike.text
                          .fontFamily(bold)
                          .size(16)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,

                      // copy form home section
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: List.generate(
                                6,
                                (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          imgP1,
                                          width: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        10.heightBox,
                                        "Laptop 4gb/64gb"
                                            .text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make(),
                                        10.heightBox,
                                        "\$600"
                                            .text
                                            .color(redColor)
                                            .fontFamily(bold)
                                            .size(16)
                                            .make(),
                                      ],
                                    )
                                        .box
                                        .margin(
                                            EdgeInsets.symmetric(horizontal: 4))
                                        .white
                                        .roundedSM
                                        .padding(EdgeInsets.all(8))
                                        .make())),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                  color: redColor,
                  textColor: whiteColor,
                  title: "Add to cart",
                  onPress: () {},
                  onpress: () {
                    if (controller.quantity.value > 0) {
                      controller.addToCart(
                          color: data['p_color'][controller.colorIndex.value],
                          context: context,
                          vender_id: data['vender_id'],
                          img: data['p_images'],
                          qty: controller.quantity.value,
                          sellerName: data['p_seller'],
                          title: data['product_name'],
                          tPrice: controller.totalPrice.value);
                      VxToast.show(context, msg: "Added to Cart");
                    }else{
                      VxToast.show(context, msg: "Quantity Cant be Zero");
                    }
                  },


              ),
            ),
          ],
        ),
      ),
    );
  }
}
