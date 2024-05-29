import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyip_pro/controller/dashboard_controller.dart';
import 'package:hyip_pro/controller/notification_controller.dart';
import 'package:hyip_pro/utils/colors/app_colors.dart';
import 'package:hyip_pro/view/screens/notification/notification_screen.dart';
import 'package:hyip_pro/view/screens/payout/payout_screen.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../controller/referral_bonus_controller.dart';
import '../../widgets/app_drawer_widget.dart';

class DashBoardScreen extends StatelessWidget {
  static const String routeName = "/dashBoardScreen";
  DashBoardScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String formatApiDate(String apiDate) {
    // Parse the API response date
    DateTime dateTime = DateTime.parse(apiDate);

    // Format it as 'dd MMM, yyyy h.mm a'
    String formattedDate = DateFormat('dd MMM, yyyy h.mm a').format(dateTime);

    return formattedDate;
  }

  final selectedLanguageStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(builder: (dashBoardController) {
      // // Access the ReferralBonusController instance
      // ReferralBonusController referralBonusController =
      // Get.find<ReferralBonusController>();
      //
      // // Access the total referral amount
      // double totalReferralAmount =
      //     referralBonusController.totalReferralAmount;
      return RefreshIndicator(
        onRefresh: () async {
          dashBoardController.getDashBoardData();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: AppColors.getAppBarBgDarkLight(),
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    child: Image.asset(
                      "assets/images/menu.png",
                      height: 28.h,
                      width: 28.w,
                      color: AppColors.appWhiteColor,
                    )),
                InkWell(onTap: () {
                  Get.toNamed(NotificationScreen.routeName);
                }, child: GetBuilder<NotificationController>(
                    builder: (notificationController) {
                  return Stack(
                    children: [
                      Image.asset(
                        "assets/images/notification_icon.png",
                        height: 26.h,
                        width: 26.w,
                      ),
                      notificationController.eventCount.value > 1
                          ? Positioned(
                              top: 0,
                              right: 5,
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 4,
                              ))
                          : const SizedBox.shrink(),
                    ],
                  );
                }))
              ],
            ),
          ),
          key: _scaffoldKey,
          drawer: appDrawer(),
          backgroundColor: AppColors.getBackgroundDarkLight(),
          body: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: dashBoardController.isLoading == false &&
                          dashBoardController.message != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(horizontal: 24.w),
                            //   child: dashBoardController.isLoading == false &&
                            //       dashBoardController.message != null
                            //       ? Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       SizedBox(
                            //         height: 20.h,
                            //       ),
                            //       // Add your SizedBox widget here
                            //       SizedBox(
                            //         height: 200.h, // Set the height of the SizedBox as needed
                            //         child: ListView.builder(
                            //           scrollDirection: Axis.horizontal, // Make it scroll horizontally
                            //           itemCount: 5, // Replace 5 with the actual number of items
                            //           itemBuilder: (context, index) {
                            //             // Return each item for the horizontal slider
                            //             // You can customize this based on your requirement
                            //             return Container(
                            //               width: MediaQuery.of(context).size.width * 0.8, // Set the width of each item
                            //               margin: EdgeInsets.symmetric(horizontal: 8.w), // Adjust margin as needed
                            //               decoration: BoxDecoration(
                            //                 color: Colors.grey[300],
                            //                 borderRadius: BorderRadius.circular(10),
                            //               ),
                            //               child: Center(
                            //                 child: Text(
                            //                   'Item $index',
                            //                   style: TextStyle(fontSize: 20),
                            //                 ),
                            //               ),
                            //             );
                            //           },
                            //         ),
                            //       ),
                            //     ],
                            //   ) : CircularProgressIndicator(), // Add a loading indicator if data is still loading
                            // ),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, PayoutScreen.routeName);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 16,
                                              left: 10,
                                              right: 16,
                                              bottom: 16),
                                          decoration: BoxDecoration(
                                            color: Get.isDarkMode
                                                ? AppColors.appContainerBgColor
                                                : AppColors.appFillColor,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 40,
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      AppColors.appBlackColor80,
                                                ),
                                                child: CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: ClipOval(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(2),
                                                      child: Image.asset(
                                                        "assets/images/main_balance.png",
                                                        width: 40,
                                                        height: 40,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 8.w),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${selectedLanguageStorage.read("languageData")["Current Balance"] ?? "Current Balance"}",
                                                      style:
                                                          GoogleFonts.aBeeZee(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20.sp,
                                                        color: AppColors
                                                            .getTextDarkLight(),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${dashBoardController.dashBoardModel.message!.currency}${(dashBoardController.dashBoardModel.message!.mainBalance).toStringAsFixed(1)}",
                                                      style:
                                                          GoogleFonts.anticSlab(
                                                        fontSize: 24.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .appWhiteColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15.w),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 16,
                                            left: 10,
                                            right: 16,
                                            bottom: 16),
                                        decoration: BoxDecoration(
                                          color: Get.isDarkMode
                                              ? AppColors.appContainerBgColor
                                              : AppColors.appFillColor,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    AppColors.appBlackColor80,
                                              ),
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: ClipOval(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(2),
                                                    child: Image.asset(
                                                      "assets/images/total_deposit.png",
                                                      width: 40,
                                                      height: 40,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${selectedLanguageStorage.read("languageData")["Total Withdraw"] ?? "Total Withdraw"}",
                                                    style: GoogleFonts.aBeeZee(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20.sp,
                                                      color: AppColors
                                                          .getTextDarkLight(),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${dashBoardController.dashBoardModel.message!.currency}${dashBoardController.dashBoardModel.message!.totalPayout}",
                                                    style:
                                                        GoogleFonts.anticSlab(
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: AppColors
                                                          .appWhiteColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                // Add your third card here
                              ],
                            ),

//Vertical design file

                            //
                            //
                            // Container(
                            //   padding: EdgeInsets.only(
                            //       top: 16, left: 10, right: 16, bottom: 16),
                            //   decoration: BoxDecoration(
                            //       color: Get.isDarkMode
                            //           ? AppColors.appContainerBgColor
                            //           : AppColors.appBlackColor10,
                            //       borderRadius: BorderRadius.circular(16)),
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Row(
                            //         mainAxisAlignment: MainAxisAlignment.start,
                            //         children: [
                            //           Expanded(
                            //             flex: 2,
                            //             child: Container(
                            //               width: 40,
                            //               height: 40,
                            //               padding: EdgeInsets.all(5),
                            //               decoration: BoxDecoration(
                            //                 shape: BoxShape.circle,
                            //                color: AppColors.appBlackColor80,
                            //               ),
                            //               child: CircleAvatar(
                            //                 radius: 15,
                            //                 backgroundColor: Colors.transparent,
                            //                 child: ClipOval(
                            //                   child: Padding(
                            //                     padding:  EdgeInsets.all(2),
                            //                     child: Image.asset(
                            //                      "assets/images/main_balance.png",
                            //                      // fit: BoxFit.cover,
                            //                       width: 40,
                            //                       height: 40,
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //             ),
                            //
                            //
                            //           ),
                            //           SizedBox(
                            //             width: 8.w,
                            //           ),
                            //           Expanded(
                            //               flex: 9,
                            //               child: Column(
                            //                 crossAxisAlignment:
                            //                 CrossAxisAlignment.start,
                            //                 children: [
                            //
                            //                   Text(
                            //                     "${selectedLanguageStorage.read("languageData")["Current Balance"] ?? "Current Balance"}",
                            //                     style: GoogleFonts.aBeeZee(
                            //                         fontWeight: FontWeight.w600,
                            //                         fontSize: 20.sp,
                            //                         color: AppColors
                            //                             .getTextDarkLight()),
                            //                   ),
                            //                   Text(
                            //                     "${dashBoardController.dashBoardModel.message!.currency}${(dashBoardController.dashBoardModel.message!.interestBalance + dashBoardController.dashBoardModel.message!.mainBalance).toStringAsFixed(1)}",
                            //                     style: GoogleFonts.anticSlab(
                            //                         fontSize: 24.sp,
                            //                         fontWeight: FontWeight.w700,
                            //                         color:
                            //                         AppColors.getTextDarkLight()),
                            //                   ),
                            //
                            //                 ],
                            //               ))
                            //         ],
                            //       ),
                            //
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 15.h,
                            // ),
                            // Container(
                            //   padding: EdgeInsets.only(
                            //       top: 16, left: 10, right: 16, bottom: 16),
                            //   decoration: BoxDecoration(
                            //       color: Get.isDarkMode
                            //           ? AppColors.appContainerBgColor
                            //           : AppColors.appBrandColor3,
                            //       borderRadius: BorderRadius.circular(16)),
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Row(
                            //         mainAxisAlignment: MainAxisAlignment.start,
                            //         children: [
                            //           Expanded(
                            //             flex: 2,
                            //             child: Container(
                            //               width: 40,
                            //               height: 40,
                            //               padding: EdgeInsets.all(5),
                            //               decoration: BoxDecoration(
                            //                 shape: BoxShape.circle,
                            //                 color: AppColors.appBlackColor80,
                            //               ),
                            //               child: CircleAvatar(
                            //                 radius: 15,
                            //                 backgroundColor: Colors.transparent,
                            //                 child: ClipOval(
                            //                   child: Padding(
                            //                     padding:  EdgeInsets.all(2),
                            //                     child: Image.asset(
                            //                       "assets/images/total_deposit.png",
                            //                       // fit: BoxFit.cover,
                            //                       width: 40,
                            //                       height: 40,
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //             ),
                            //             // child: Container(
                            //             //   padding: EdgeInsets.all(8),
                            //             //   height: 70.h,
                            //             //   width: 70.w,
                            //             //   decoration: BoxDecoration(
                            //             //     shape: BoxShape.circle, // Makes the container circular
                            //             //     color: Colors.grey[800], // Sets the background color to a dark shade of grey
                            //             //   ),
                            //             //   child: CircleAvatar(
                            //             //
                            //             //     backgroundImage: AssetImage("assets/images/main_balance.png"),
                            //             //   ),
                            //             // ),
                            //
                            //           ),
                            //           SizedBox(
                            //             width: 8.w,
                            //           ),
                            //           Expanded(
                            //               flex: 9,
                            //               child: Column(
                            //                 crossAxisAlignment:
                            //                 CrossAxisAlignment.start,
                            //                 children: [
                            //
                            //                   Text(
                            //                     "${selectedLanguageStorage.read("languageData")["Total Withdraw"] ?? "Total Withdraw"}",
                            //                     style: GoogleFonts.aBeeZee(
                            //                         fontWeight: FontWeight.w600,
                            //                         fontSize: 20.sp,
                            //                         color: AppColors
                            //                             .getTextDarkLight()),
                            //                   ),
                            //                   Text(
                            //                     "${dashBoardController.dashBoardModel.message!.currency}${dashBoardController.dashBoardModel.message!.totalPayout}",
                            //                     style: GoogleFonts.anticSlab(
                            //                         fontSize: 24.sp,
                            //                         fontWeight: FontWeight.w700,
                            //                         color:
                            //                         AppColors.getTextDarkLight()),
                            //                   ),
                            //
                            //                 ],
                            //               ))
                            //         ],
                            //       ),
                            //
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 15.h,
                            // ),

                            //3rd card
                            Container(
                              padding: EdgeInsets.only(
                                  top: 16, left: 10, right: 10, bottom: 16),
                              decoration: BoxDecoration(
                                  color: Get.isDarkMode
                                      ? AppColors.appContainerBgColor
                                      : AppColors.appBrandColor2,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 117.w,
                                    decoration: BoxDecoration(
                                      color: Get.isDarkMode
                                          ? AppColors.appContainerBgColor
                                          : AppColors.appBrandColor2,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 22.h, left: 16.w, bottom: 22.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            height: 44.h,
                                            width: 44.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: AppColors
                                                  .appTotalDepositIconColor,
                                            ),
                                            child: Image.asset(
                                                "assets/images/payout.png"),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          GetBuilder<ReferralBonusController>(
                                            builder: (referralBonusController) {
                                              return Text(
                                                dashBoardController
                                                            .dashBoardModel
                                                            .message!
                                                            .roi!
                                                            .totalInvestAmount !=
                                                        null
                                                    ? "${dashBoardController.dashBoardModel.message!.currency}${dashBoardController.dashBoardModel.message!.roi!.totalInvestAmount!}"
                                                    : "${dashBoardController.dashBoardModel.message!.currency}0.00",
                                                style: GoogleFonts.publicSans(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors
                                                      .getTextDarkLight(),
                                                ),
                                              );
                                            },
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                            "${selectedLanguageStorage.read("languageData")["Total Purchased"] ?? "Total Purchased"}",
                                            style: GoogleFonts.niramit(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.appBlackColor50,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Container(
                                    width: 117.w,
                                    decoration: BoxDecoration(
                                      color: Get.isDarkMode
                                          ? AppColors.appContainerBgColor
                                          : AppColors.appBrandColor2,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 22.h, left: 16.w, bottom: 22.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            height: 44.h,
                                            width: 44.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: AppColors
                                                  .appTotalDepositIconColor,
                                            ),
                                            child: Image.asset(
                                                "assets/images/referral.png"),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          GetBuilder<ReferralBonusController>(
                                            builder: (referralBonusController) {
                                              return Text(
                                                "${dashBoardController.dashBoardModel.message!.currency}${referralBonusController.totalReferralAmount.toStringAsFixed(1)}",
                                                style: GoogleFonts.publicSans(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors
                                                      .getTextDarkLight(),
                                                ),
                                              );
                                            },
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                            "${selectedLanguageStorage.read("languageData")["Referral Earn"] ?? "Referral Earn"}",
                                            style: GoogleFonts.niramit(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.appBlackColor50,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Container(
                                  //   width: 117.w,
                                  //   decoration: BoxDecoration(
                                  //       color: Get.isDarkMode? AppColors.appContainerBgColor:AppColors.appBrandColor2,
                                  //       borderRadius: BorderRadius.circular(16)
                                  //   ),
                                  //   child: Padding(
                                  //     padding: EdgeInsets.only(
                                  //         top: 22.h,
                                  //         left: 16.w,
                                  //         bottom: 22.h
                                  //     ),
                                  //     child: Column(
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //       children: [
                                  //         Container(
                                  //           padding: EdgeInsets.all(8),
                                  //           height: 44.h,
                                  //           width: 44.w,
                                  //           decoration: BoxDecoration(
                                  //               borderRadius: BorderRadius.circular(8),
                                  //               color: AppColors.appTotalDepositIconColor
                                  //           ),
                                  //           child: Image.asset("assets/images/total_deposit.png",),
                                  //         ),
                                  //         SizedBox(height: 20.h,),
                                  //         Text("${dashBoardController.dashBoardModel.message!.currency}${dashBoardController.dashBoardModel.message!.totalDeposit!.toStringAsFixed(2)}",style: GoogleFonts.publicSans(
                                  //             fontSize: 14.sp,
                                  //             fontWeight: FontWeight.w700,
                                  //             color: AppColors.getTextDarkLight()
                                  //         ),),
                                  //         SizedBox(height: 4.h,),
                                  //         Text("${selectedLanguageStorage.read("languageData")["Referral Earn"]??"Referral Earn"}",style: GoogleFonts.niramit(
                                  //             fontSize: 14.sp,
                                  //             fontWeight: FontWeight.w500,
                                  //             color: AppColors.appBlackColor50
                                  //         ),),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  Container(
                                    width: 117.w,
                                    decoration: BoxDecoration(
                                        color: Get.isDarkMode
                                            ? AppColors.appContainerBgColor
                                            : AppColors.appBrandColor2,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 22.h, left: 16.w, bottom: 22.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            height: 44.h,
                                            width: 44.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: AppColors
                                                    .appTotalEarnIconColor),
                                            child: Image.asset(
                                              "assets/images/total_earn.png",
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Text(
                                            "${dashBoardController.dashBoardModel.message!.currency}${dashBoardController.dashBoardModel.message!.totalEarn!.toStringAsFixed(1)}",
                                            style: GoogleFonts.publicSans(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors
                                                    .getTextDarkLight()),
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                            "${selectedLanguageStorage.read("languageData")["Total Earn"] ?? "Total Earn"}",
                                            style: GoogleFonts.niramit(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    AppColors.appBlackColor50),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //total team investment ,tottal refrells,invest refrals
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 16, left: 10, right: 10, bottom: 16),
                                  decoration: BoxDecoration(
                                      color: Get.isDarkMode
                                          ? AppColors.appContainerBgColor
                                          : AppColors.appBlackColor30,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      //Team Investment
                                      Container(
                                        width: 117.w,
                                        decoration: BoxDecoration(
                                            color: Get.isDarkMode
                                                ? AppColors.appContainerBgColor
                                                : AppColors.appBlackColor30,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 22.h,
                                              left: 1.w,
                                              bottom: 22.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(8),
                                                height: 44.h,
                                                width: 44.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: AppColors
                                                        .appBlackColor60),
                                                child: Image.asset(
                                                  "assets/images/refer_txtfield_img.png",
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),

                                              // Text("${dashBoardController.dashBoardModel.message!.currency}${dashBoardController.dashBoardModel.message!.mainBalance!.toStringAsFixed(2)}",style: GoogleFonts.publicSans(
                                              //   fontSize: 15.sp,
                                              //     fontWeight: FontWeight.w700,
                                              //   color: AppColors.getTextDarkLight()
                                              // ),),

                                              Text(
                                                "${dashBoardController.dashBoardModel.message!.currency}${dashBoardController.dashBoardModel.message!.total_referrals_investment!.toStringAsFixed(1)}",
                                                style: GoogleFonts.publicSans(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors
                                                        .getTextDarkLight()),
                                              ),

                                              SizedBox(
                                                height: 4.h,
                                              ),

                                              Text(
                                                "${selectedLanguageStorage.read("languageData")["Team Purchased"] ?? "Team Purchased"}",
                                                style: GoogleFonts.niramit(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors
                                                        .appBlackColor50),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      //total referrals

                                      Container(
                                        width: 117.w,
                                        decoration: BoxDecoration(
                                          color: Get.isDarkMode
                                              ? AppColors.appContainerBgColor
                                              : AppColors.appBlackColor30,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 22.h,
                                              left: 1.w,
                                              bottom: 22.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(8),
                                                height: 44.h,
                                                width: 44.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color:
                                                      AppColors.appBrandColor3,
                                                ),
                                                child: Image.asset(
                                                    "assets/images/referral_bonus.png"),
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              GetBuilder<
                                                  ReferralBonusController>(
                                                builder:
                                                    (referralBonusController) {
                                                  return Text(
                                                    "${dashBoardController.dashBoardModel.message!.total_referral!}",
                                                    style:
                                                        GoogleFonts.publicSans(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: AppColors
                                                          .getTextDarkLight(),
                                                    ),
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              Text(
                                                "${selectedLanguageStorage.read("languageData")["Total referrals"] ?? "Total referrals"}",
                                                style: GoogleFonts.niramit(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.appBlackColor50,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      //invest referrals
                                      Container(
                                        width: 117.w,
                                        decoration: BoxDecoration(
                                            color: Get.isDarkMode
                                                ? AppColors.appContainerBgColor
                                                : AppColors.appBlackColor30,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 22.h,
                                              left: 1.w,
                                              bottom: 22.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(8),
                                                height: 44.h,
                                                width: 44.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color:
                                                        AppColors.appBrandDeep),
                                                child: Image.asset(
                                                  "assets/images/payout.png",
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Text(
                                                "${dashBoardController.dashBoardModel.message!.total_investor_referral!}",
                                                style: GoogleFonts.publicSans(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors
                                                        .getTextDarkLight()),
                                              ),
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              Text(
                                                "${selectedLanguageStorage.read("languageData")["Purchased referrals"] ?? "Purchased referrals"}",
                                                style: GoogleFonts.niramit(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors
                                                        .appBlackColor50),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${selectedLanguageStorage.read("languageData")["Recent Transaction"] ?? "Recent Transaction"}",
                                  style: GoogleFonts.publicSans(
                                      color: AppColors.getTextDarkLight(),
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600),
                                ),

                                // Text("${selectedLanguageStorage.read("languageData")["See All"]??"See All"}",style: GoogleFonts.publicSans(
                                //   color: AppColors.getTextDarkLight(),
                                //   fontSize: 16.sp,
                                //   fontWeight: FontWeight.w400
                                // ),),
                              ],
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            dashBoardController.dashBoardModel.message!
                                    .transaction!.isNotEmpty
                                ? ListView.builder(
                                    itemCount: dashBoardController
                                        .dashBoardModel
                                        .message!
                                        .transaction!
                                        .length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 12.h),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Get.isDarkMode
                                                  ? AppColors
                                                      .appContainerBgColor
                                                  : AppColors
                                                      .appTransactionCardColor,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 40.h,
                                                        width: 40.w,
                                                        decoration: BoxDecoration(
                                                            color: dashBoardController
                                                                        .dashBoardModel
                                                                        .message!
                                                                        .transaction![
                                                                            index]
                                                                        .trxType ==
                                                                    "+"
                                                                ? AppColors
                                                                    .appDashBoardTransactionGreen
                                                                : AppColors
                                                                    .appDashBoardTransactionRed,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: dashBoardController
                                                                      .dashBoardModel
                                                                      .message!
                                                                      .transaction![
                                                                          index]
                                                                      .trxType ==
                                                                  "+"
                                                              ? Image.asset(
                                                                  "assets/images/transaction_down.png",
                                                                  height: 16.h,
                                                                  width: 16.w,
                                                                )
                                                              : Image.asset(
                                                                  "assets/images/transaction_up.png",
                                                                  height: 16.h,
                                                                  width: 16.w,
                                                                ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 12.w,
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 16.h,
                                                                  bottom: 16.h),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "${dashBoardController.dashBoardModel.message!.transaction![index].remarks}"
                                                                    .replaceAll(
                                                                        "profit",
                                                                        "profit"),
                                                                style: GoogleFonts.publicSans(
                                                                    fontSize:
                                                                        16.sp,
                                                                    color: AppColors
                                                                        .getTextDarkLight(),
                                                                    height: 1.5,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                height: 6.h,
                                                              ),
                                                              Text(
                                                                "${formatApiDate(dashBoardController.dashBoardModel.message!.transaction![index].time.toString())}",
                                                                style: GoogleFonts.publicSans(
                                                                    fontSize:
                                                                        14.sp,
                                                                    color: AppColors
                                                                        .appBlackColor50,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Center(
                                                  child: dashBoardController
                                                              .dashBoardModel
                                                              .message!
                                                              .transaction![
                                                                  index]
                                                              .trxType ==
                                                          "+"
                                                      ? Text(
                                                          "${dashBoardController.dashBoardModel.message!.transaction![index].trxType} ${dashBoardController.dashBoardModel.message!.currency}${dashBoardController.dashBoardModel.message!.transaction![index].amount}",
                                                          style: GoogleFonts
                                                              .publicSans(
                                                                  fontSize:
                                                                      18.sp,
                                                                  color: AppColors
                                                                      .appDashBoardTransactionGreen,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        )
                                                      : Text(
                                                          "${dashBoardController.dashBoardModel.message!.transaction![index].trxType} ${dashBoardController.dashBoardModel.message!.currency}${dashBoardController.dashBoardModel.message!.transaction![index].amount}",
                                                          style: GoogleFonts
                                                              .publicSans(
                                                                  fontSize:
                                                                      18.sp,
                                                                  color: AppColors
                                                                      .appDashBoardTransactionRed,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                : Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Get.isDarkMode
                                              ? Image.asset(
                                                  "assets/images/dark_no_data_found.png",
                                                  height: 150.h,
                                                  width: 150.w,
                                                )
                                              : Image.asset(
                                                  "assets/images/no_data_found.png",
                                                  height: 150.h,
                                                  width: 150.w,
                                                ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: Text(
                                              "${selectedLanguageStorage.read("languageData")["No data found."] ?? "No data found."}",
                                              style: GoogleFonts.publicSans(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18.sp,
                                                color:
                                                    AppColors.appBlackColor50,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: 30.h,
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.appPrimaryColor,
                            ),
                          ),
                        ))
            ],
          ),
        ),
      );
    });
  }
}
