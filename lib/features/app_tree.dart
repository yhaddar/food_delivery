import 'package:flutter/material.dart';
import 'package:food_delivery/features/restaurant/ui/restaurant_screen.dart';
import 'package:food_delivery/features/setting/ui/setting_screen.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../shared/widgets/custom_appbar.dart';
import 'home/ui/home_screen.dart';

class AppTree extends StatelessWidget {
  const AppTree({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppbar("food delivery"),
          Expanded(
            child: SingleChildScrollView(
              child: Obx(
                () => controller.screens[controller._selectedItem.value],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          elevation: 0,
          height: 80,
          selectedIndex: controller._selectedItem.value,
          backgroundColor: Colors.transparent,
          onDestinationSelected: (index) =>
              controller._selectedItem.value = index,
          destinations: [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.receipt), label: 'Food'),
            NavigationDestination(
              icon: Icon(Iconsax.menu_board),
              label: 'Restaurant',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.heart),
              label: 'Favorite',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.setting),
              label: 'Setting',
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> _selectedItem = 0.obs;
  final screens = [
    HomeScreen(),
    SettingScreen(),
    RestaurantScreen(),
    HomeScreen(),
    SettingScreen(),
  ];
}

