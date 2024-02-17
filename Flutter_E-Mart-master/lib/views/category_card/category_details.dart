import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/category_card/item_details.dart';
import 'package:emart_app/views/controller/product_controller.dart';
import 'package:emart_app/widgets_same/background_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetail extends StatelessWidget {
  final String? title;
  const CategoryDetail({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<productController>();
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(title: title!.text.fontFamily(bold).white.make()),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
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
                          .size(120, 60)
                          .roundedSM
                          .margin(EdgeInsets.symmetric(horizontal: 4))
                          .make())),
            ),
// item container
            20.heightBox,
            Expanded(
                child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 250,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8),
                    itemBuilder: ((context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            imgP5,
                            height: 150,
                            width: 200,
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
                          .margin(EdgeInsets.symmetric(horizontal: 4))
                          .white
                          .outerShadowSm
                          .roundedSM
                          .padding(EdgeInsets.all(18))
                          .make()
                          .onTap(() {
                        Get.to(() => ItemDetails(title: "Dummy Titel"));
                      });
                    })))
          ],
        ),
      ),
    ));
  }
}
