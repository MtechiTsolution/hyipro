import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyip_pro/controller/bottom_navbar_controller.dart';
import 'package:hyip_pro/utils/colors/app_colors.dart';
import 'package:upgrader/upgrader.dart';

class BottomNavBar extends StatefulWidget {
  static const String routeName = '/bottomNavbar';

  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  final selectedLanguageStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      init: BottomNavController(),
      builder: (controller) => WillPopScope(
        onWillPop: () async {
      if (controller.selectedIndex == 0) {
        return await  Get.defaultDialog(
          titlePadding: EdgeInsets.symmetric(vertical: 10),
          radius: 10,
          backgroundColor: AppColors.getContainerBgDarkLight(),
          titleStyle: GoogleFonts.publicSans(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.appPrimaryColor,
          ),
          title: "Alert!",
          content: Column(
            children: [
              Container(
                height: 1.h,
                width: 350.w,
                color: Get.isDarkMode? Colors.white12:Colors.black12,
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                "${selectedLanguageStorage.read("languageData")["Do you want to Exit?"] ?? "Do you want to Exit?"}",
                style: GoogleFonts.publicSans(
                  fontSize: 17.sp,
                  color: AppColors.getTextDarkLight(),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
            ],
          ),
          actions: [
            SizedBox(height: 10.h,),
            ElevatedButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
              //  primary: AppColors.appDashBoardTransactionRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "${selectedLanguageStorage.read("languageData")["No"] ?? "No"}",
                style: TextStyle(color: AppColors.appWhiteColor),
              ),
            ),
            SizedBox(width: 16.w,),
            ElevatedButton(
              onPressed: () async {
               exit(0);
              },
              style: ElevatedButton.styleFrom(
             //   primary: AppColors.appDashBoardTransactionGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "${selectedLanguageStorage.read("languageData")["Yes"] ?? "Yes"}",
                style: TextStyle(color: AppColors.appWhiteColor),
              ),
            ),
            SizedBox(height: 10.h,),
          ],

        );
      } else {
        setState(() {
          controller.selectedIndex = 0;
        });
        return false;
      }},
        child: UpgradeAlert(
         // upgrader: Upgrader(dialogStyle: UpgradeDialogStyle.material),
          dialogStyle: UpgradeDialogStyle.cupertino,
          child: Scaffold(
            //backgroundColor: AppColors.getBackgroundDarkLight(),
            body: controller.currentScreen,
            bottomNavigationBar: BottomAppBar(
              height: 70.h,
              elevation: 1,
              color: AppColors.getAppBarBgDarkLight(),
              notchMargin: 8,
              shape: const CircularNotchedRectangle(
              ),
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //
              //     IconButton(
              //       icon: Image.asset(
              //         "assets/images/plan.png",
              //         height: 25.h,
              //         width: 25.w,
              //         color: controller.selectedIndex == 1
              //             ? AppColors. appWhiteColor
              //             : AppColors.appBlackColor80,
              //       ),
              //       onPressed: () => controller.changeScreen(1),
              //     ),
              //     IconButton(
              //       icon: Image.asset(
              //         "assets/images/transaction.png",
              //         height: 25.h,
              //         width: 25.w,
              //         color: controller.selectedIndex == 3
              //             ? AppColors. appWhiteColor
              //             : AppColors.appBlackColor80,
              //       ),
              //       onPressed: () => controller.changeScreen(3),
              //     ),
              //
              //     IconButton(
              //       icon: Image.asset(
              //         "assets/images/menu_icon_new.png",
              //         height: 25.h,
              //         width: 25.w,
              //         color: controller.selectedIndex == 4
              //             ? AppColors. appWhiteColor
              //             : AppColors.appBlackColor80,
              //       ),
              //       onPressed: () => controller.changeScreen(4),
              //     ),
              //     // IconButton(
              //     //   icon: Image.asset(
              //     //     "assets/images/referral_bonus.png",
              //     //     height: 25.h,
              //     //     width: 25.w,
              //     //     color: controller.selectedIndex == 0
              //     //         ? AppColors. appWhiteColor
              //     //         : AppColors.appBlackColor80,
              //     //   ),
              //     //   onPressed: () => controller.changeScreen(0),
              //     // ),
              //     IconButton(
              //       icon: Icon(
              //         Icons.account_balance_wallet, // Wallet icon from Flutter's Icons class
              //         size: 25.h, // Set the size of the icon
              //         color: controller.selectedIndex == 0
              //             ? AppColors.appWhiteColor
              //             : AppColors.appBlackColor80, // Color of the icon based on the condition
              //       ),
              //       onPressed: () {
              //         // Add your onPressed logic here
              //         // This function will be called when the IconButton is pressed
              //         // For example, you can call a function to change the screen
              //         controller.changeScreen(0);
              //       },
              //     ),
              //
              //   ],
              // ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Image.asset(
                      "assets/images/plan.png",
                      height: 25.h,
                      width: 25.w,
                      color: controller.selectedIndex == 0 // Changed to index 0
                          ? AppColors.appWhiteColor
                          : AppColors.appBlackColor80,
                    ),
                    onPressed: () => controller.changeScreen(0),
                  ),
                  IconButton(
                    icon: Image.asset(
                      "assets/images/transaction.png",
                      height: 25.h,
                      width: 25.w,
                      color: controller.selectedIndex == 1 // Changed to index 1
                          ? AppColors.appWhiteColor
                          : AppColors.appBlackColor80,
                    ),
                    onPressed: () => controller.changeScreen(1),
                  ),
                  IconButton(
                    icon: Image.asset(
                      "assets/images/menu_icon_new.png",
                      height: 25.h,
                      width: 25.w,
                      color: controller.selectedIndex == 2 // Changed to index 2
                          ? AppColors.appWhiteColor
                          : AppColors.appBlackColor80,
                    ),
                    onPressed: () => controller.changeScreen(2),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.account_balance_wallet,
                      size: 25.h,
                      color: controller.selectedIndex == 3 // Changed to index 3
                          ? AppColors.appWhiteColor
                          : AppColors.appBlackColor80,
                    ),
                    onPressed: () => controller.changeScreen(3),
                  ),
                ],
              ),

            ),
            // floatingActionButton: ClipOval(
            //   child: FloatingActionButton(
            //     backgroundColor: AppColors.appPrimaryColor,
            //     child: Image.asset(
            //       "assets/images/transfer_bottom.png",
            //       height: 20.h,
            //       width: 20.w,
            //       fit: BoxFit.cover,
            //     ),
            //     onPressed: () {
            //       controller.changeScreen(2);
            //     },
            //   ),
            // ),
            // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          ),
        ),
      ),
    );
  }
}
