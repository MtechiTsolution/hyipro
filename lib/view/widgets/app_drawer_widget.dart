import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyip_pro/controller/dashboard_controller.dart';
import 'package:hyip_pro/utils/colors/app_colors.dart';
import 'package:hyip_pro/view/screens/badges/badges_screen.dart';
import 'package:hyip_pro/view/screens/deposit/deposit_screen.dart';
import 'package:hyip_pro/view/screens/history/deposit_history_screen.dart';
import 'package:hyip_pro/view/screens/history/payout_history_screen.dart';
import 'package:hyip_pro/view/screens/payout/payout_screen.dart';
import 'package:hyip_pro/view/screens/plan/plan_screen.dart';
import 'package:hyip_pro/view/screens/referral/referral_screen.dart';
import 'package:hyip_pro/view/screens/support/support_ticket_screen.dart';
import 'package:hyip_pro/view/screens/transfer/transfer_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/history/invest_history_screen.dart';
import '../screens/referral/referral_bonus_screen.dart';

final selectedLanguageStorage = GetStorage();

Widget appDrawer() {
  return Drawer(
    width: 286.w,
    elevation: 0,
    backgroundColor: AppColors.getBackgroundDarkLight(),
    child: GetBuilder<DashBoardController>(builder: (dashBoardController) {
     // print("imgp- ${dashBoardController.message!.userImage!}");
      return ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          dashBoardController.isLoading == false
              ? Container(
                  height: 310.h,
                  width: double.infinity,
                  decoration: Get.isDarkMode
                      ? BoxDecoration(color: AppColors.getAppBarBgDarkLight())
                      : BoxDecoration(
                          border: Border.all(color: AppColors.appWhiteColor),
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/images/drawer_header.png",
                              ),
                              fit: BoxFit.cover)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70.h,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl:
                                "${dashBoardController.message!.userImage}",
                            height: 72.h,
                            width: 72.w,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            // Placeholder while loading
                            errorWidget: (context, url, error) => Icon(
                                Icons.error), // Error widget if loading fails
                          )),
                      SizedBox(
                        height: 24.h,
                      ),
                      //  Text("${selectedLanguageStorage.read("languageData")["Main Balance:"]??"Main Balance:"}   ${dashBoardController.message!.currency}${dashBoardController.message!.mainBalance}",
                      //      style: GoogleFonts.publicSans(
                      //    fontWeight: FontWeight.w500,
                      //    fontSize: 16.sp,
                      //    color: AppColors.getTextDarkLight()
                      //  )),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                          "${selectedLanguageStorage.read("languageData")["Current Balance:"] ?? "Current Balance:"}   ${dashBoardController.message!.currency}${ dashBoardController.message!.mainBalance}",
                          style: GoogleFonts.publicSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: AppColors.getTextDarkLight())),
                      SizedBox(
                        height: 24.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(PayoutScreen.routeName);
                              },
                              child: Container(
                                height: 40.h,
                                width: 112.w,
                                decoration: BoxDecoration(
                                    color: AppColors.appFillColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/payout.png",
                                      height: 18.h,
                                      width: 18.w,
                                    ),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    Text(
                                        "${selectedLanguageStorage.read("languageData")["Withdraw"] ?? "Withdraw"}",
                                        style: GoogleFonts.niramit(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                            color: AppColors.appWhiteColor)),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(PlanScreen.routeName,
                                    arguments: "true");
                              },
                              child: Container(
                                height: 40.h,
                                width: 112.w,
                                decoration: BoxDecoration(
                                    color: AppColors.appFillColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/total_invest.png",
                                      height: 20.h,
                                      width: 20.w,
                                    ),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    Text(
                                        "${selectedLanguageStorage.read("languageData")["Purchase"] ?? "Purchase"}",
                                        style: GoogleFonts.niramit(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                            color: AppColors.appWhiteColor)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: EdgeInsets.only(top: 32.h, left: 24.w),
            child: Column(
              children: [
                // InkWell(
                //   onTap: (){
                //     Get.toNamed(DepositHistoryScreen.routeName,arguments: "[false]");
                //   },
                //   child: Row(
                //     children: [
                //       Image.asset("assets/images/deposit_history.png",
                //         color: AppColors.getTextDarkLight(),
                //       height: 20.h,width: 20.w,
                //       ),
                //       SizedBox(width: 16.w,),
                //       Text("${selectedLanguageStorage.read("languageData")["Deposit History"]??"Deposit History"}",style: GoogleFonts.publicSans(
                //         fontSize: 16.sp,
                //         fontWeight: FontWeight.w400,
                //         color: AppColors.getTextDarkLight()
                //       ),)
                //
                //     ],
                //   ),
                // ),
                // SizedBox(height: 32.h,),

                InkWell(
                  onTap: () {
                    Get.toNamed(InvestHistoryScreen.routeName);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/invest_history.png",
                        color: AppColors.getTextDarkLight(),
                        height: 20.h,
                        width: 20.w,
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Text(
                        "${selectedLanguageStorage.read("languageData")["Purchase History"] ?? "Purchase History"}",
                        style: GoogleFonts.publicSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.getTextDarkLight(),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),

                InkWell(
                  onTap: () {
                    Get.toNamed(PayoutScreen.routeName);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/payout.png",
                        color: AppColors.getTextDarkLight(),
                        height: 20.h,
                        width: 20.w,
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Text(
                        "${selectedLanguageStorage.read("languageData")["Withdraw"] ?? "Withdraw"}",
                        style: GoogleFonts.publicSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.getTextDarkLight(),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),

                InkWell(
                  onTap: () {
                    Get.toNamed(PayoutHistoryScreen.routeName);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/payout_history.png",
                        color: AppColors.getTextDarkLight(),
                        height: 20.h,
                        width: 20.w,
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Text(
                        "${selectedLanguageStorage.read("languageData")["Withdraw History"] ?? "Withdraw History"}",
                        style: GoogleFonts.publicSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.getTextDarkLight(),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),

                // InkWell(
                //   onTap: (){
                //     Get.toNamed(TransferScreen.routeName);
                //   },
                //   child: Row(
                //     children: [
                //       Image.asset("assets/images/transfer_icon.png",
                //         height: 20.h,width: 20.w,
                //         color: AppColors.getTextDarkLight(),
                //       ),
                //       SizedBox(width: 16.w,),
                //       Text("${selectedLanguageStorage.read("languageData")["Transfer"]??"Transfer"}",style: GoogleFonts.publicSans(
                //           fontSize: 16.sp,
                //           fontWeight: FontWeight.w400,
                //         color: AppColors.getTextDarkLight(),
                //       ),)
                //
                //     ],
                //   ),
                // ),
                // SizedBox(height: 32.h,),µ≤cxc µ≤∫ç

                InkWell(
                  onTap: () {
                    Get.toNamed(ReferralScreen.routeName);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/referral.png",
                        color: AppColors.getTextDarkLight(),
                        height: 20.h,
                        width: 20.w,
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Text(
                        "${selectedLanguageStorage.read("languageData")["My Referral"] ?? "My Referral"}",
                        style: GoogleFonts.publicSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.getTextDarkLight(),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),

                InkWell(
                  onTap: () {
                    Get.toNamed(ReferralBonusScreen.routeName);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/referral_bonus.png",
                        color: AppColors.getTextDarkLight(),
                        height: 20.h,
                        width: 20.w,
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Text(
                        "${selectedLanguageStorage.read("languageData")["Referral Bonus"] ?? "Referral Bonus"}",
                        style: GoogleFonts.publicSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.getTextDarkLight(),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),

                // InkWell(
                //   onTap: (){
                //     Get.toNamed(BadgesScreen.routeName);
                //   },
                //   child: Row(
                //     children: [
                //       Image.asset("assets/images/badges.png",
                //         color: AppColors.getTextDarkLight(),
                //         height: 20.h,width: 20.w,
                //       ),
                //       SizedBox(width: 16.w,),
                //       Text("${selectedLanguageStorage.read("languageData")["Badges"]??"Badges"}",style: GoogleFonts.publicSans(
                //           fontSize: 16.sp,
                //           fontWeight: FontWeight.w400,
                //         color: AppColors.getTextDarkLight(),
                //       ),)
                //
                //     ],
                //   ),
                // ),
                //
                // SizedBox(height: 32.h,),

                // InkWell(
                //   onTap: (){
                //     Get.toNamed(SupportTicketScreen.routeName);
                //   },
                //   child: Row(
                //     children: [
                //       Image.asset("assets/images/support.png",
                //         color: AppColors.getTextDarkLight(),
                //         height: 20.h,width: 20.w,
                //       ),
                //       SizedBox(width: 16.w,),
                //       Text("${selectedLanguageStorage.read("languageData")["Support Ticket"]??"Support Ticket"}",style: GoogleFonts.publicSans(
                //           fontSize: 16.sp,
                //           fontWeight: FontWeight.w400,
                //         color: AppColors.getTextDarkLight(),
                //       ),)
                //
                //     ],
                //   ),
                // ),


                InkWell(
                  onTap: () async {
                    // Replace 'phoneNumber' with the actual phone number you want to open in WhatsApp
                    String phoneNumber = "+923205555828";

                    // Construct the WhatsApp URL
                    String whatsappUrl = "https://wa.me/$phoneNumber";

                    // Launch the URL using the url_launcher package
                    if (await canLaunch(whatsappUrl)) {
                      await launch(whatsappUrl);
                    } else {
                      // Handle error, e.g., show an error message
                      print("Could not launch $whatsappUrl");
                    }
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/whatsapp.png",
                        // Replace with the actual path to the WhatsApp SVG logo
                        color: AppColors.getTextDarkLight(),
                        height: 20.h,
                        width: 20.w,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        "${selectedLanguageStorage.read("languageData")["WhatsApp"] ?? "WhatsApp"}",
                        style: GoogleFonts.publicSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.getTextDarkLight(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }),
  );
}
