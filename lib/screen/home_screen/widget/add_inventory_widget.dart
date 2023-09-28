import 'package:flutter/material.dart';
import 'package:game_inventory/constants/app_colors.dart';
import 'package:game_inventory/constants/images.dart';
import 'package:game_inventory/controller/home_controller.dart';
import 'package:game_inventory/model/game_model.dart';
import 'package:get/get.dart';

class AddInventorySheet extends StatelessWidget {
  GameModel gameModel;
  AddInventorySheet({super.key, required this.gameModel});
  final con = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.25), blurRadius: 4)]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    gameModel.thumbnail ?? "",
                    fit: BoxFit.cover,
                    height: 150,
                    width: Get.width,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      gameModel.title ?? "",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    SizedBox(height: 5),
                    Text(
                      gameModel.genre ?? "",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            width: Get.width,
            height: 60,
            decoration: BoxDecoration(color: AppColors.grey, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Expanded(child: InkWell(onTap: () => con.decrement(), child: const Icon(Icons.remove))),
                Expanded(
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.25), blurRadius: 4)]),
                    child: Obx(() => Text(
                          con.qty.value.toString(),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                        )),
                  ),
                ),
                Expanded(child: InkWell(onTap: () => con.increment(), child: const Icon(Icons.add))),
              ],
            ),
          ),
          const SizedBox(height: 40),
          InkWell(
            onTap: () {
              con.addInventory(gameModel);
            },
            child: Container(
              height: 65,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Add to my Inventory",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
