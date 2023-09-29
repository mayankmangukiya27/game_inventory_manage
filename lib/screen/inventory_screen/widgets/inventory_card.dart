import 'package:flutter/material.dart';
import 'package:game_inventory/constants/images.dart';
import 'package:game_inventory/model/inventory_model.dart';
import 'package:get/get.dart';

class InventoryCard extends StatelessWidget {
  InventoryCard({
    super.key,
    required this.data,
  });

  final InventoryModel data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blueGrey.shade400, boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 1,
                color: Colors.black38,
                offset: Offset(0, 2),
              ),
            ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      data.img ?? "",
                      fit: BoxFit.cover,
                      height: 150,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        Images.cardImage,
                        fit: BoxFit.cover,
                        height: 150,
                        width: Get.width,
                      ),
                      width: Get.width,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name ?? "",
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black, overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        data.cat ?? "",
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          if ((data.qty ?? 0) > 0)
            Positioned(
              top: 5,
              right: 15,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 1,
                        color: Colors.black38,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  height: 30,
                  width: 30,
                  child: Center(child: Text(data.qty.toString()))),
            ),
          if (data.isUsed == true)
            Positioned.fill(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const ColoredBox(
                color: Colors.black54,
                child: Center(
                    child: Text(
                  "Item is Used",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                )),
              ),
            ))
        ],
      ),
    );
  }
}
