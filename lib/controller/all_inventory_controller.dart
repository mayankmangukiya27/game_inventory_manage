import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_inventory/model/inventory_model.dart';
import 'package:game_inventory/model/user_model.dart';
import 'package:get/get.dart';

class AllInventoryController extends GetxController {
  final currentUser = FirebaseAuth.instance.currentUser;
  late TabController tabController;
  RxList<InventoryModel> inventoryNew = <InventoryModel>[].obs;
  RxList<InventoryModel> inventoryUsed = <InventoryModel>[].obs;
  RxList<UserDataModel> userList = <UserDataModel>[].obs;
  Rx<UserDataModel?> selectedUser = Rx<UserDataModel?>(null);
  RxBool isLoader = false.obs;
  RxInt gameQty = 1.obs;

  getInventory() async {
    isLoader.value = true;
    FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).collection('inventory').get().then((QuerySnapshot querySnapshot) {
      inventoryNew.clear();
      inventoryUsed.clear();
      querySnapshot.docs.forEach((doc) {
        log(jsonEncode(doc.data()));
        InventoryModel inventoryModel = InventoryModel.fromJson(doc.data() as Map<String, dynamic>)..inventoryId = doc.id;
        inventoryModel.isUsed == true ? inventoryUsed.add(inventoryModel) : inventoryNew.add(inventoryModel);

        // getInventory();
      });

      log("inventoryUsed :--${inventoryUsed.length}");
      log("inventoryNew :--${inventoryNew.length}");
    }).then((value) {
      log("Sucuss");
      isLoader.value = false;
    }).onError((error, stackTrace) {
      log(error.toString());
      isLoader.value = false;
    });
  }

  increment(int? max) {
    if (max == null) {
      gameQty++;
    } else {
      if (gameQty < max) {
        gameQty++;
      }
    }
  }

  decrement() {
    if (gameQty > 1) {
      gameQty--;
    }
  }

  getAllUsers() async {
    userList.clear();

    FirebaseFirestore.instance.collection('users').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        log(jsonEncode(doc.data()));
        UserDataModel userData = UserDataModel.fromJson(doc.data() as Map<String, dynamic>);
        if (currentUser?.uid != userData.id) {
          userList.add(userData);
        }
      });
      log("userList :--${userList.length}");
    }).then((value) {
      isLoader.value = false;
      log("Sucuss");
    }).onError((error, stackTrace) {
      isLoader.value = false;
      log(error.toString());
    });
  }

  transferInventory(
    InventoryModel inventoryData,
    String userId,
  ) async {
    var myInventoryQ = FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).collection('inventory').doc(inventoryData.inventoryId);
    var otherPersonInventoryRef = FirebaseFirestore.instance.collection('users').doc(userId).collection('inventory');
    var otherPersonInventoryQ = otherPersonInventoryRef.where("id", isEqualTo: inventoryData.gameId);
    final myInventoryDS = await myInventoryQ.get();
    final otherPersonInventoryQS = await otherPersonInventoryQ.get();

    if (otherPersonInventoryQS.docs.isEmpty) {
      var inventoryJsonData = inventoryData.toJson();
      inventoryJsonData["qty"] = gameQty.value;
      inventoryJsonData["dateTime"] = DateTime.now().toIso8601String();
      otherPersonInventoryRef.add(inventoryJsonData);
      await myInventoryQ.update({"qty": myInventoryDS.data()?["qty"] - gameQty.value, "dateTime": DateTime.now().toIso8601String()});
      getInventory();
      Get.back();
    } else {
      var oldData = otherPersonInventoryQS.docs.first.data();
      await otherPersonInventoryRef
          .doc(otherPersonInventoryQS.docs.first.id)
          .update({"qty": oldData['qty'] + gameQty.value, "dateTime": DateTime.now().toIso8601String()});
      await myInventoryQ.update({"qty": myInventoryDS.data()?["qty"] - gameQty.value, "dateTime": DateTime.now().toIso8601String()});
      getInventory();
      Get.back();
    }
  }

  useNow(InventoryModel inventoryData) {
    var myInventoryQ = FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).collection('inventory').doc(inventoryData.inventoryId);
    myInventoryQ.update({
      "qty": 0,
      "dateTime": DateTime.now().toIso8601String(),
      "isUsed": true,
    }).then((value) {
      getInventory();
      Get.back();
    });
  }
}
