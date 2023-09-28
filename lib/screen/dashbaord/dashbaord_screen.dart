import 'package:flutter/material.dart';

import 'package:game_inventory/controller/custome_bottom_controller.dart';
import 'package:get/get.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final con = Get.put(CustomBottomBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: con.currentIndex.value,

        // backgroundColor: colorScheme.surface,
        // selectedItemColor: colorScheme.onSurface,
        // unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        // selectedLabelStyle: textTheme.caption,
        // unselectedLabelStyle: textTheme.caption,
        onTap: (value) {
          // Respond to item press.
          setState(() {
            con.currentIndex.value = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'inventory',
            icon: Icon(Icons.inventory_2),
          ),
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'profile',
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: con.pageList[con.currentIndex.value],
    );
  }
}
