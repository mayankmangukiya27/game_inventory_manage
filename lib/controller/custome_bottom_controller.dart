import 'package:game_inventory/screen/home_screen/home_screen.dart';
import 'package:game_inventory/screen/inventory_screen/inventory_screen.dart';
import 'package:game_inventory/screen/profile_screen/profile_screen.dart';
import 'package:get/get.dart';

class CustomBottomBarController extends GetxController {
  RxInt currentIndex = 1.obs;
  var pageList = [const InventoryScreen(), const HomeScreen(), ProfileScreen()];
}
