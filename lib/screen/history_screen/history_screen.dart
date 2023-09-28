import 'package:flutter/material.dart';
import 'package:game_inventory/constants/app_colors.dart';
import 'package:game_inventory/constants/images.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('History'),
        ),
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.08), blurRadius: 5, offset: const Offset(0, 4))]),
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20), image: const DecorationImage(image: AssetImage(Images.cardImage))),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "20 May 2023, 10:55 PM",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Game Name",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      SizedBox(height: 5),
                      RichText(
                          text: TextSpan(
                              text: "Qty:",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
                              children: [TextSpan(text: " 2", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey))]))
                    ],
                  )
                ],
              ),
            );
          },
        ));
  }
}
