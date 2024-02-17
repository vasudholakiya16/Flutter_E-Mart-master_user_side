import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/cart_screen/cart_screen.dart';
import 'package:emart_app/views/category_card/category_screen.dart';
import 'package:emart_app/views/controller/home_controller.dart';
import 'package:emart_app/views/home_screen/home_screen.dart';
import 'package:emart_app/views/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //init Home controler

    var Controller = Get.put(HomeContainer());
    var navbarItem = [
      BottomNavigationBarItem(
        icon: Image.asset(
          icHome,
          width: 26.0,
        ),
        label: home,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          icCategories,
          width: 26.0,
        ),
        label: categories,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          icCart,
          width: 26.0,
        ),
        label: Cart,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          icProfile,
          width: 26.0,
        ),
        label: account,
      ),
    ];

    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: navBody.elementAt(Controller.CurrentNavIndex.value),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: Controller.CurrentNavIndex.value,
          selectedItemColor: redColor,
          selectedLabelStyle: TextStyle(fontFamily: semibold),
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          items: navbarItem, // Add the 'navbarItem' list here
          onTap: (value) {
            Controller.CurrentNavIndex.value = value;
          },
        ),
      ),
    );
  }
}
