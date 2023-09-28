import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_inventory/model/game_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InventoryController extends GetxController {
  late TabController tabController;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  RxInt qty = 1.obs;
  var userList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
  ];
  increment() {
    qty++;
  }

  decrement() {
    if (qty > 1) {
      qty--;
    }
  }

  String docID = "";
  getAllUsers() async {
    final pref = await SharedPreferences.getInstance();
    FirebaseFirestore.instance.collection('users').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc['id']);
        // if (doc['id'] == pref.getString('userId')) {
        //   getDocID(querySnapshot);
        // }
      });
    }).then((value) {
      log("Sucuss");
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  // getDocID(QuerySnapshot querySnapshot) {
  //   for (var i = 0; i < querySnapshot.docs.length; i++) {
  //     log("doc:${querySnapshot.docs[i].id}");
  //     docID = querySnapshot.docs[i].id;
  //     log(docID);
  //   }
  // }

  addInventory(GameModel gameData) async {
    users
        .doc(docID)
        .collection("inventory")
        .add({"name": gameData.title, "img": gameData.thumbnail, "cat": gameData.genre, "time": DateTime.now(), "qty": qty, "isUsed": false});
  }
}
