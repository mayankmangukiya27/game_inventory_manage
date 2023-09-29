import 'package:flutter/material.dart';
import 'package:game_inventory/constants/app_colors.dart';
import 'package:game_inventory/constants/images.dart';
import 'package:game_inventory/controller/all_inventory_controller.dart';
import 'package:game_inventory/model/inventory_model.dart';
import 'package:get/get.dart';

class ShareInventorySheet extends StatefulWidget {
  final InventoryModel data;
  const ShareInventorySheet({
    super.key,
    required this.data,
  });

  @override
  State<ShareInventorySheet> createState() => _ShareInventorySheetState();
}

class _ShareInventorySheetState extends State<ShareInventorySheet> {
  final con = Get.put(AllInventoryController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 40),
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
                      widget.data.img ?? "",
                      fit: BoxFit.cover,
                      height: 150,
                      width: Get.width,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        Images.cardImage,
                        fit: BoxFit.cover,
                        height: 150,
                        width: Get.width,
                      ),
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
                        widget.data.name ?? "",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.data.cat ?? "",
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          con.useNow(widget.data);
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Use Now",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                          ),
                        ),
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
                            con.gameQty.value.toString(),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                          )),
                    ),
                  ),
                  Expanded(child: InkWell(onTap: () => con.increment(widget.data.qty), child: const Icon(Icons.add))),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Obx(
              () => DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    fillColor: Colors.white38,
                    filled: true,
                    hintText: "Select user"),
                value: con.selectedUser.value,
                items: con.userList
                    .map(
                      (e) => DropdownMenuItem(value: e, child: Text(e.fullName ?? "")),
                    )
                    .toList(),
                onChanged: (value) {
                  con.selectedUser.value = value;
                },
              ),
            ),
            const SizedBox(height: 40),
            InkWell(
              onTap: () {
                if (con.selectedUser.value == null) return;
                con.transferInventory(widget.data, con.selectedUser.value?.id ?? "");
              },
              child: Container(
                height: 65,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Transfer to user",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
