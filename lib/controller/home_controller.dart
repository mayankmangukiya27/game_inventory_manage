import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_inventory/constants/api_constants.dart';
import 'package:game_inventory/constants/api_service.dart';
import 'package:game_inventory/model/game_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxInt qty = 1.obs;
  RxList<GameModel> gamesList = <GameModel>[].obs;
  RxList<GameModel> duplicate = <GameModel>[].obs;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Api api = Api();
  getAllGames() async {
    var response = await api.get(ApiConstants.gameListUrl);
    if (response.statusCode == 200) {
      for (var game in response.data) {
        gamesList.add(GameModel.fromJson(game));
        duplicate.value = gamesList;
      }
    }
  }

  void filterSearch(String query) {
    duplicate.value = gamesList
        .where((e) => (e.title ?? "").toLowerCase().contains(query.toLowerCase()) || (e.genre ?? "").toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  increment() {
    qty++;
  }

  decrement() {
    if (qty > 1) {
      qty--;
    }
  }

  addInventory(GameModel gameData) async {
    final currentUser = await FirebaseAuth.instance.currentUser;
    var inventoryCol = FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).collection('inventory');
    var inventroryQS = await inventoryCol.where("id", isEqualTo: gameData.id).get();
    if (inventroryQS.docs.isNotEmpty) {
      await users.doc(currentUser?.uid).collection("inventory").doc(inventroryQS.docs[0].id).update({
        "isUsed": false,
        "qty": qty.value + (inventroryQS.docs[0].data()["qty"] ?? 0),
        "dateTime": DateTime.now().toIso8601String(),
      }).then((value) {
        Get.back();
        log("Success");
      }).onError((error, stackTrace) {
        log("$error");
      });
    } else {
      await users.doc(currentUser?.uid).collection("inventory").add({
        "name": gameData.title,
        "img": gameData.thumbnail,
        "cat": gameData.genre,
        "qty": qty.value,
        "id": gameData.id,
        "isUsed": false,
        "dateTime": DateTime.now().toIso8601String()
      }).then((value) {
        Get.back();
        log("Success");
      }).onError((error, stackTrace) {
        log("$error");
      });
    }
  }

  String inId = "";
  getInventoryID(QuerySnapshot querySnapshot) {
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      log("doc:${querySnapshot.docs[i].id}");
      inId = querySnapshot.docs[i].id;
      log(inId);
    }
  }
}
