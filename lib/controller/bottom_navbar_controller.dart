import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_pro/view/screens/menu/menu_screen.dart';

import '../view/screens/dashboard/dashboard_sreen.dart';
import '../view/screens/plan/plan_screen.dart';
import '../view/screens/transaction/transaction_history_screen.dart';
import '../view/screens/transfer/transfer_screen.dart';


class BottomNavController extends GetxController {
  int selectedIndex = 0;
  List<Widget> screens = [

    PlanScreen(),
    TransactionHistoryScreen(),
    //TransferScreen(),
    MenuScreen(),
    DashBoardScreen(),

  ];

  Widget get currentScreen => screens[selectedIndex];

  void changeScreen(int index) {
    selectedIndex = index;
    update();
  }
}