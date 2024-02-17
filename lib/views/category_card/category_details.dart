import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/loadingIndicator.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/category_card/item_details.dart';
import 'package:emart_app/views/controller/product_controller.dart';
import 'package:emart_app/widgets_same/background_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetail extends StatefulWidget {
  final String? title;

  const CategoryDetail({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FireStoreServices.getSubCategoryProduct(title);
    } else {
      productMethod = FireStoreServices.getProducts(title);
    }
  }

  var controller = Get.find<productController>();
  dynamic productMethod;

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
          appBar:
              AppBar(title: widget.title!.text.fontFamily(bold).white.make()),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      children: List.generate(
                          controller.subcat.length,
                          (index) => "${controller.subcat[index]}"
                              .text
                              .size(14)
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .makeCentered()
                              .box
                              .white
                              .size(150, 60)
                              .roundedSM
                              .margin(EdgeInsets.symmetric(horizontal: 4))
                              .make().onTap(() {
                            switchCategory("${controller.subcat[index]}");
                            setState(() {

                            });
                          }),
                      )),
                ),
              ),
              20.heightBox,
              StreamBuilder(
                  // stream: FireStoreServices.getProducts(widget.title),
                  stream: productMethod,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        child: Center(
                          child: loadingIndicator(),
                        ),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Expanded(
                        child: "No Product Find!!.. see again "
                            .text
                            .color(darkFontGrey)
                            .makeCentered(),
                      );
                    } else {
                      var data = snapshot.data!.docs;
                      return Expanded(
                          child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 350,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8),
                              itemBuilder: ((context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      data[index]['p_images'][0],
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    10.heightBox,
                                    "${data[index]['product_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "${data[index]['p_price']}"
                                        .numCurrency
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .margin(EdgeInsets.symmetric(horizontal: 4))
                                    .white
                                    .outerShadowSm
                                    .roundedSM
                                    .padding(EdgeInsets.all(18))
                                    .make()
                                    .onTap(() {
                                  // controller.checkIfFav(data[index]);
                                  Get.to(() => ItemDetails(
                                      title: "${data[index]['product_name']}",
                                      data: data[index]));
                                });
                              })));
                    }
                  }),
            ],
          )),
    );
  }
}
