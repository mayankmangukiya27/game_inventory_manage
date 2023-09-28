import 'package:flutter/material.dart';
import 'package:game_inventory/constants/app_colors.dart';
import 'package:game_inventory/controller/home_controller.dart';
import 'package:game_inventory/screen/history_screen/history_screen.dart';
import 'package:game_inventory/screen/home_screen/widget/add_inventory_widget.dart';
import 'package:get/get.dart';

import 'widget/game_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final con = Get.put(HomeController());

  @override
  void initState() {
    con.getAllGames();
    // con.getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => HistoryScreen()),
            icon: const Icon(
              Icons.history,
              size: 30,
              color: AppColors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                con.filterSearch(value);
              },
              decoration: InputDecoration(
                hintText: "Search",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() => GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.87,
                    ),
                    itemCount: con.duplicate.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          con.qty.value = 1;
                          Get.bottomSheet(
                              backgroundColor: AppColors.white,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              )),
                              AddInventorySheet(gameModel: con.duplicate[index]));
                        },
                        child: GameCard(gameModel: con.duplicate[index]),
                      );
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
