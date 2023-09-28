import 'package:flutter/material.dart';
import 'package:game_inventory/constants/images.dart';
import 'package:game_inventory/model/game_model.dart';
import 'package:get/get.dart';

class GameCard extends StatelessWidget {
  GameModel gameModel;
  GameCard({
    required this.gameModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.teal, boxShadow: const [
        BoxShadow(
          blurRadius: 5,
          spreadRadius: 0,
          color: Colors.black38,
          offset: Offset(0, 2),
        ),
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  gameModel.thumbnail ?? '',
                  fit: BoxFit.cover,
                  height: 135,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  gameModel.title ?? '',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white, overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(height: 2),
                Text(
                  gameModel.genre ?? "",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
