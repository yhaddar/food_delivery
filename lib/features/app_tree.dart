import 'package:flutter/material.dart';
import 'package:food_delivery/features/setting/ui/setting_screen.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;

import '../shared/widgets/custom_appbar.dart';
import 'home/home_screen.dart';

class AppTree extends StatefulWidget {
  const AppTree({super.key});

  @override
  State<AppTree> createState() => _AppTreeState();
}

class _AppTreeState extends State<AppTree> {

  final List<Widget> _pages = [
    HomeScreen(),
    SettingScreen(),
  ];

  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppbar("Home"),
          SizedBox(height: 10,),
          // SingleChildScrollView(
          //   child: _pages[_selectedItem],
          // )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedItem,
          selectedItemColor: colors.Colors.dark,
          onTap: (int index) {
            setState(() {
              _selectedItem = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: "")
          ]
      ),
    );;
  }
}
