import 'package:flutter/material.dart';
import 'package:game_inventory/constants/app_colors.dart';
import 'package:game_inventory/controller/all_inventory_controller.dart';
import 'package:game_inventory/screen/inventory_screen/widgets/inventory_card.dart';
import 'package:game_inventory/screen/inventory_screen/widgets/share_inventory_widget.dart';
import 'package:game_inventory/widgets/common_loader.dart';
import 'package:get/get.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> with SingleTickerProviderStateMixin {
  final con = Get.put(AllInventoryController());
  @override
  void initState() {
    con.getAllUsers();
    con.getInventory();
    con.tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Inventory"),
      ),
      body: Obx(
        () => ConmanLoader(
          loadingState: con.isLoader.value,
          child: Column(
            children: [
              TabBar(controller: con.tabController, unselectedLabelColor: Colors.black87, labelColor: Colors.teal, tabs: const [
                Tab(child: Text('New')),
                Tab(child: Text('Used')),
              ]),
              Expanded(
                child: TabBarView(controller: con.tabController, children: [newInventory(), usedInventory()]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget newInventory() {
    return Obx(
      () => GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.82,
        ),
        itemCount: con.inventoryNew.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final data = con.inventoryNew[index];
          return InkWell(
              onTap: () {
                con.gameQty.value = 1;
                con.selectedUser.value = null;
                Get.bottomSheet(
                    backgroundColor: AppColors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                    ShareInventorySheet(
                      data: data,
                    ));
              },
              child: InventoryCard(data: data));
        },
      ),
    );
  }

  Widget usedInventory() {
    return Obx(
      () => GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.82,
        ),
        itemCount: con.inventoryUsed.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final data = con.inventoryUsed[index];
          return InventoryCard(data: data);
        },
      ),
    );
  }
}
