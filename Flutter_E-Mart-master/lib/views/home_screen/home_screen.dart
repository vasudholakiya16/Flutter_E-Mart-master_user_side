import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/views/home_screen/components/featured_components.dart';
import 'package:emart_app/widgets_same/home_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 50,
            color: lightGrey,
            child: TextFormField(
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: Searchanythings,
                  hintStyle: TextStyle(color: textfieldGrey)),
            ),
          ),
          10.heightBox,

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // code for swipers
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      itemCount: slidersList.length,
                      enlargeCenterPage: true,
                      itemBuilder: (context, index) {
                        return Container(
                            child: Image.asset(
                          slidersList[index],
                          fit: BoxFit.fill,
                        )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(EdgeInsets.symmetric(horizontal: 8))
                                .make());
                        // Replace this with your actual item builder logic
                      }),
                  10.heightBox,
                  //deles buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        2,
                        (index) => homeButtons(
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 2.5,
                            icon: index == 0 ? icTodaysDeal : icFlashDeal,
                            title: index == 0 ? todayDeal : flashsale)),
                  ),
                  10.heightBox,
                  // code for 2-swipers
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      itemCount: secondSliderList.length,
                      enlargeCenterPage: true,
                      itemBuilder: (context, index) {
                        return Container(
                            child: Image.asset(
                          secondSliderList[index],
                          fit: BoxFit.fill,
                        )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(EdgeInsets.symmetric(horizontal: 8))
                                .make());
                        // Replace this with your actual item builder logic
                      }),
                  10.heightBox,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          3,
                          (index) => homeButtons(
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth / 3.5,
                                icon: index == 0
                                    ? icTopCategories
                                    : index == 1
                                        ? icBrands
                                        : icTopSeller,
                                title: index == 0
                                    ? topCategories
                                    : index == 1
                                        ? brand
                                        : topSellers,
                              ))),
                  10.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: featuredCategories.text
                        .color(darkFontGrey)
                        .size(17)
                        .fontFamily(semibold)
                        .make(),
                  ),
                  10.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    featuredButton(
                                        icon: feeturedImages1[index],
                                        title: feeturedTitle1[index]),
                                    10.heightBox,
                                    featuredButton(
                                        icon: feeturedImages2[index],
                                        title: feeturedTitle2[index]),
                                  ],
                                )).toList()),
                  ),
                  //freatued product
                  20.heightBox,
                  Container(
                    padding: EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: redColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        fetauredProduct.text.white
                            .fontFamily(bold)
                            .size(18)
                            .make(),
                        10.heightBox,
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
                                          .margin(EdgeInsets.symmetric(
                                              horizontal: 4))
                                          .white
                                          .roundedSM
                                          .padding(EdgeInsets.all(8))
                                          .make())),
                        ),
                      ],
                    ),
                  ),
                  10.heightBox,
                  // thirdswiper
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      itemCount: secondSliderList.length,
                      enlargeCenterPage: true,
                      itemBuilder: (context, index) {
                        return Container(
                            child: Image.asset(
                          secondSliderList[index],
                          fit: BoxFit.fill,
                        )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(EdgeInsets.symmetric(horizontal: 8))
                                .make());
                        // Replace this with your actual item builder logic
                      }),
                  // all product section
                  20.heightBox,
                  GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 6,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              mainAxisExtent: 300),
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              imgP5,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            const Spacer(),
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
                            .roundedSM
                            .padding(EdgeInsets.all(18))
                            .make();
                      })
                ],
              ),
            ),
          ),

          //featuredCateogary
        ],
      )),
    );
  }
}
