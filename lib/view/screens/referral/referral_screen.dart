import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyip_pro/controller/dashboard_controller.dart';
import 'package:hyip_pro/controller/referral_controller.dart';
import 'package:hyip_pro/utils/colors/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:responsive_text_widget/responsive_text_widget.dart';



class ReferralScreen extends StatefulWidget {
  static const String routeName = "/referralScreen";

  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  final PageController _pageController = PageController();
  int selectedIndex = 0;

  List<bool> selectedIndexColor = List.generate(7, (index) => false);
  int selectedButtonIndex = -1;

  String formatApiDate(String apiDate) {
    // Parse the API response date
    DateTime dateTime = DateTime.parse(apiDate);

    // Format it as 'dd MMM, yyyy h.mm a'
    String formattedDate = DateFormat('dd MMM, yyyy h.mm a').format(dateTime);

    return formattedDate;
  }

  final selectedLanguageStorage = GetStorage();

  // static const String imageAPath = 'assets/images/logo.png'; // Replace with your image paths
  // static const String imageBPath = 'assets/images/logo.png';
// ... Similarly for other image paths

  // static var list = '['
  //     '{"id":"A","next":[{"outcome":"B"}]},'
  //     '{"id":"B","next":[{"outcome":"A"}]},'
  //     '{"id":"C","next":[{"outcome":"A"}]},'
  //     '{"id":"D","next":[{"outcome":"A"}]},{"id":"E","next":[{"outcome":"A"}]},'
  //     '{"id":"J","next":[{"outcome":"A"}]},'
  //     '{"id":"I","next":[{"outcome":"A"}]},{"id":"F","next":[{"outcome":"A"}]},'
  //     '{"id":"K","next":[{"outcome":"A"}]},'
  //     '{"id":"H","next":[{"outcome":"A"}]},{"id":"L","next":[{"outcome":"A"}]},'
  //     '{"id":"P","next":[{"outcome":"A"}]},'
  //     '{"id":"M","next":[]},{"id":"N","next":[]}'
  //     ']';



  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReferralController>(builder: (referralController) {
      // NodeInput node;
      // list=referralController.message!.referrals.toString();
      return RefreshIndicator(
        onRefresh: () async {
          Get.find<ReferralController>().getReferralData();
        },
        child: Scaffold(
            backgroundColor: AppColors.getBackgroundDarkLight(),
            appBar: AppBar(
              backgroundColor: AppColors.getAppBarBgDarkLight(),
              automaticallyImplyLeading: false,
              centerTitle: true,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(19.0),
                  child: Image.asset(
                    "assets/images/arrow_back_btn.png",
                    height: 20.h,
                    width: 20.w,
                    color: AppColors.getTextDarkLight(),
                  ),
                ),
              ),
              title: Text(
                "${selectedLanguageStorage.read("languageData")["My Referral"] ?? "My Referral"}",
                style: GoogleFonts.publicSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  color: AppColors.getTextDarkLight(),
                ),
              ),
            ),
            body:
                referralController.isLoading == false &&
                        referralController.message != null
                    ? ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.getContainerBgDarkLight(),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Text(
                                        "${selectedLanguageStorage.read("languageData")["Referral Link"] ?? "Referral Link"}",
                                        style: GoogleFonts.niramit(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                            color:
                                                AppColors.getTextDarkLight()),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Container(
                                      height: 72.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Get.isDarkMode
                                            ? AppColors.appContainerBgColor
                                            : AppColors.appFillColor,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Get.isDarkMode
                                                    ? AppColors
                                                        .appContainerBgColor
                                                    : AppColors.appFillColor,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 16.h,
                                                    bottom: 16.w,
                                                    left: 16.w),
                                                child: Text(
                                                  "${referralController.message!.referralLink}".substring(30),
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              child: GestureDetector(
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(
                                                  text:
                                                      "${referralController.message!.referralLink}".substring(30)));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    backgroundColor: AppColors
                                                        .appDashBoardTransactionGreen,
                                                    content: Text(
                                                      'Text copied to clipboard',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                right: 16,
                                              ),
                                              child: Container(
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColors.appWhiteColor,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(8),
                                                      bottomRight:
                                                          Radius.circular(8),
                                                    )),
                                                child: Icon(
                                                  Icons.copy_sharp,
                                                  color:
                                                      AppColors.appPrimaryColor,
                                                  size: 20.h,
                                                ),
                                              ),
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
//button level
                          SizedBox(
                            height: 45.h,
                            width: double.infinity,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: referralController
                                    .message!.referrals!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return referralController
                                          .message!.referrals!["1"]!.isEmpty
                                      ? SizedBox.shrink()
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (selectedButtonIndex ==
                                                    index) {
                                                  // Deselect the button
                                                  selectedButtonIndex = -1;
                                                } else {
                                                  // Select the button at the tapped index
                                                  selectedButtonIndex = index;
                                                }
                                                selectedIndex = index;
                                                _pageController
                                                    .jumpToPage(index);
                                              });
                                            },
                                            // child: Padding(
                                            //   padding:
                                            //       const EdgeInsets.only(left: 12),
                                            //   child: Container(
                                            //       height: 35,
                                            //       width: 100,
                                            //       decoration: BoxDecoration(
                                            //           boxShadow: [
                                            //             BoxShadow(
                                            //               color: Get.isDarkMode
                                            //                   ? AppColors
                                            //                       .appPrimaryColor
                                            //                       .withOpacity(0.1)
                                            //                   : AppColors
                                            //                       .appPrimaryColor
                                            //                       .withOpacity(0.1),
                                            //               offset:
                                            //                   const Offset(0, 4),
                                            //               blurRadius: 0,
                                            //               spreadRadius: 0,
                                            //             ),
                                            //           ],
                                            //           border: Border.all(
                                            //             color: selectedIndex !=
                                            //                     index
                                            //                 ? AppColors
                                            //                     .appPrimaryColor
                                            //                 : AppColors
                                            //                     .appPrimaryColor,
                                            //           ),
                                            //           color: selectedIndex != index
                                            //               ? AppColors.appWhiteColor
                                            //               : AppColors
                                            //                   .appPrimaryColor,
                                            //           borderRadius:
                                            //               BorderRadius.circular(5)),
                                            //       child: Center(
                                            //           child: Text(
                                            //         "${selectedLanguageStorage.read("languageData")["Level"] ?? "Level"} ${index + 1}",
                                            //         style: GoogleFonts.niramit(
                                            //             color:
                                            //                 selectedIndex != index
                                            //                     ? Colors.black
                                            //                     : Colors.white,
                                            //             fontWeight: FontWeight.w500,
                                            //             fontSize: 15.sp),
                                            //       ))),
                                            // ),
                                          ),
                                        );
                                }),

                          ),

                          //total team investment ,tottal refrells,invest refrals
                          //
                          // if (referralController.isLoading == false &&
                          //     referralController.message != null &&
                          //     referralController
                          //         .message!.referrals!["1"]!.isNotEmpty)
                          //   Container(
                          //     margin: EdgeInsets.all(16),
                          //     padding: EdgeInsets.only(
                          //         top: 16, left: 10, right: 10, bottom: 16),
                          //     decoration: BoxDecoration(
                          //         color: Get.isDarkMode
                          //             ? AppColors.appContainerBgColor
                          //             : AppColors.appBlackColor30,
                          //         borderRadius: BorderRadius.circular(16)),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         //Team
                          //         Container(
                          //           width: 82.w,
                          //           decoration: BoxDecoration(
                          //               color: Get.isDarkMode
                          //                   ? AppColors.appContainerBgColor
                          //                   : AppColors.appBlackColor30,
                          //               borderRadius: BorderRadius.circular(16)),
                          //           child: Padding(
                          //             padding: EdgeInsets.only(
                          //                 top: 22.h, left: 1.w, bottom: 22.h),
                          //             child: Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.center,
                          //               children: [
                          //                 Container(
                          //                   padding: EdgeInsets.all(8),
                          //                   height: 44.h,
                          //                   width: 44.w,
                          //                   decoration: BoxDecoration(
                          //                       borderRadius:
                          //                           BorderRadius.circular(8),
                          //                       color: AppColors.appBlackColor60),
                          //                   child: Image.asset(
                          //                     "assets/images/refer_txtfield_img.png",
                          //                   ),
                          //                 ),
                          //                 SizedBox(
                          //                   height: 20.h,
                          //                 ),
                          //
                          //                 // Text("${dashBoardController.dashBoardModel.message!.currency}${dashBoardController.dashBoardModel.message!.mainBalance!.toStringAsFixed(2)}",style: GoogleFonts.publicSans(
                          //                 //   fontSize: 15.sp,
                          //                 //     fontWeight: FontWeight.w700,
                          //                 //   color: AppColors.getTextDarkLight()
                          //                 // ),),
                          //
                          //                 Text(
                          //                   // " $selectedIndex ..${referralController.message!.levels!["2"].team}test",
                          //                   "${referralController.message!.currency}${referralController.message!.levels!['${selectedIndex + 1}'].team ?? "0.test"}",
                          //                   style: GoogleFonts.publicSans(
                          //                       fontSize: 15.sp,
                          //                       fontWeight: FontWeight.w700,
                          //                       color:
                          //                           AppColors.getTextDarkLight()),
                          //                 ),
                          //
                          //                 SizedBox(
                          //                   height: 4.h,
                          //                 ),
                          //
                          //                 Text(
                          //                   "${selectedLanguageStorage.read("languageData")["Team "] ?? "Team "}",
                          //                   style: GoogleFonts.niramit(
                          //                       fontSize: 12.sp,
                          //                       fontWeight: FontWeight.w500,
                          //                       color: AppColors.appBlackColor50),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         //commission
                          //         Container(
                          //           width: 82.w,
                          //           decoration: BoxDecoration(
                          //             color: Get.isDarkMode
                          //                 ? AppColors.appContainerBgColor
                          //                 : AppColors.appBlackColor30,
                          //             borderRadius: BorderRadius.circular(16),
                          //           ),
                          //           child: Padding(
                          //             padding: EdgeInsets.only(
                          //                 top: 22.h, left: 1.w, bottom: 22.h),
                          //             child: Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.center,
                          //               children: [
                          //                 Container(
                          //                   padding: EdgeInsets.all(8),
                          //                   height: 44.h,
                          //                   width: 44.w,
                          //                   decoration: BoxDecoration(
                          //                     borderRadius:
                          //                         BorderRadius.circular(8),
                          //                     color: AppColors.appBrandColor3,
                          //                   ),
                          //                   child: Image.asset(
                          //                       "assets/images/referral_bonus.png"),
                          //                 ),
                          //                 SizedBox(
                          //                   height: 20.h,
                          //                 ),
                          //                 GetBuilder<ReferralBonusController>(
                          //                   builder: (referralBonusController) {
                          //                     return Text(
                          //                       "${referralController.message!.currency}${referralController.message!.levels!['${selectedIndex + 1}'].commission ?? "0.test"}",
                          //                       style: GoogleFonts.publicSans(
                          //                         fontSize: 14.sp,
                          //                         fontWeight: FontWeight.w700,
                          //                         color:
                          //                             AppColors.getTextDarkLight(),
                          //                       ),
                          //                     );
                          //                   },
                          //                 ),
                          //                 SizedBox(
                          //                   height: 4.h,
                          //                 ),
                          //                 Text(
                          //                   "${selectedLanguageStorage.read("languageData")["Commission"] ?? "Commission"}",
                          //                   style: GoogleFonts.niramit(
                          //                     fontSize: 12.sp,
                          //                     fontWeight: FontWeight.w500,
                          //                     color: AppColors.appBlackColor50,
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         //Investment
                          //         Container(
                          //           width: 82.w,
                          //           decoration: BoxDecoration(
                          //               color: Get.isDarkMode
                          //                   ? AppColors.appContainerBgColor
                          //                   : AppColors.appBlackColor30,
                          //               borderRadius: BorderRadius.circular(16)),
                          //           child: Padding(
                          //             padding: EdgeInsets.only(
                          //                 top: 22.h, left: 1.w, bottom: 22.h),
                          //             child: Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.center,
                          //               children: [
                          //                 Container(
                          //                   padding: EdgeInsets.all(8),
                          //                   height: 44.h,
                          //                   width: 44.w,
                          //                   decoration: BoxDecoration(
                          //                       borderRadius:
                          //                           BorderRadius.circular(8),
                          //                       color: AppColors.appRed50),
                          //                   child: Image.asset(
                          //                     "assets/images/invest_history.png",
                          //                   ),
                          //                 ),
                          //                 SizedBox(
                          //                   height: 20.h,
                          //                 ),
                          //                 Text(
                          //                   "${referralController.message!.currency}${referralController.message!.levels!['${selectedIndex + 1}'].totalInvest ?? "0.test"}",
                          //                   style: GoogleFonts.publicSans(
                          //                       fontSize: 12.sp,
                          //                       fontWeight: FontWeight.w700,
                          //                       color:
                          //                           AppColors.getTextDarkLight()),
                          //                 ),
                          //                 SizedBox(
                          //                   height: 4.h,
                          //                 ),
                          //                 Text(
                          //                   "${selectedLanguageStorage.read("languageData")["Investment"] ?? "Investment"}",
                          //                   style: GoogleFonts.niramit(
                          //                       fontSize: 14.sp,
                          //                       fontWeight: FontWeight.w500,
                          //                       color: AppColors.appBlackColor50),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         //Team Withdraw
                          //         Container(
                          //           width: 82.w,
                          //           decoration: BoxDecoration(
                          //               color: Get.isDarkMode
                          //                   ? AppColors.appContainerBgColor
                          //                   : AppColors.appBlackColor30,
                          //               borderRadius: BorderRadius.circular(16)),
                          //           child: Padding(
                          //             padding: EdgeInsets.only(
                          //                 top: 22.h, left: 1.w, bottom: 22.h),
                          //             child: Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.center,
                          //               mainAxisAlignment: MainAxisAlignment.center,
                          //               children: [
                          //                 Container(
                          //                   padding: EdgeInsets.all(8),
                          //                   height: 44.h,
                          //                   width: 44.w,
                          //                   decoration: BoxDecoration(
                          //                       borderRadius:
                          //                           BorderRadius.circular(8),
                          //                       color: AppColors.appBrandDeep),
                          //                   child: Image.asset(
                          //                     "assets/images/payout.png",
                          //                   ),
                          //                 ),
                          //                 SizedBox(
                          //                   height: 20.h,
                          //                 ),
                          //                 Text(
                          //                   "${referralController.message!.currency}${referralController.message!.levels!['${selectedIndex + 1}'].teamWithdraw ?? "0.test"}",
                          //                   style: GoogleFonts.publicSans(
                          //                       fontSize: 12.sp,
                          //                       fontWeight: FontWeight.w700,
                          //                       color:
                          //                           AppColors.getTextDarkLight()),
                          //                 ),
                          //                 SizedBox(
                          //                   height: 4.h,
                          //                 ),
                          //                 Align(
                          //                   alignment: Alignment.center,
                          //                   child: Text(
                          //                     "${selectedLanguageStorage.read("languageData")["Withdraw"] ?? "Withdraw"}",
                          //                     style: GoogleFonts.niramit(
                          //                         fontSize: 14.sp,
                          //                         fontWeight: FontWeight.w500,
                          //                         color: AppColors.appBlackColor50),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),

                          // SizedBox(
                          //   height: 10.h,
                          // ),
                          referralController.isLoading == false &&
                                  referralController.message != null
                              ? referralController
                                      .message!.referrals!["1"]!.isEmpty
                                  ? Center(
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Get.isDarkMode
                                                ? Image.asset(
                                                    "assets/images/dark_no_data_found.png",
                                                    height: 200.h,
                                                    width: 200.w,
                                                  )
                                                : Image.asset(
                                                    "assets/images/no_data_found.png",
                                                    height: 200.h,
                                                    width: 200.w,
                                                  ),
                                            SizedBox(
                                              height: 12.h,
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 24),
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
                                    )
                                  : SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height * .8,
                                      width: 36.w,
                                      child:

                                      // GridView.builder(
                                      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      //     crossAxisCount: 2,
                                      //     mainAxisSpacing: 10.0,
                                      //     crossAxisSpacing: 10.0,
                                      //   ),
                                      //   itemCount: 5, // At least 5 items
                                      //   itemBuilder: (context, index) {
                                      //     return Container(
                                      //
                                      //       decoration: BoxDecoration(
                                      //         borderRadius: BorderRadius.circular(10.0),
                                      //         color: Colors.grey[200],
                                      //
                                      //       ),
                                      //
                                      //       padding: EdgeInsets.all(15.0),
                                      //       margin: EdgeInsets.all(15),
                                      //       child: Column(
                                      //         mainAxisAlignment: MainAxisAlignment.center,
                                      //         children: [
                                      //           CircleAvatar(
                                      //             radius: 40.0,
                                      //             backgroundImage: AssetImage('assets/profile_$index.jpg'), // Replace with your image asset
                                      //           ),
                                      //           SizedBox(height: 10.0),
                                      //           Text(
                                      //             'Name $index', // Replace with actual names
                                      //             style: TextStyle(
                                      //               fontSize: 16.0,
                                      //               fontWeight: FontWeight.bold,
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     );
                                      //   },
                                      // )



                                      Column(
                                        children: [
                                          // First row with one item

                                          GetBuilder<DashBoardController>(builder: (dashBoardController){
                                            return  Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                // Profile image and name widget
                                                Container(
                                                  width: 100.0,
                                                  height: 115.h,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.all(4), // Border width
                                                        decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                                                        child: ClipOval(
                                                          child: SizedBox.fromSize(
                                                            size: Size.fromRadius(30), // Image radius
                                                            child:dashBoardController.message!.userImage !=null?Image.network(dashBoardController.message!.userImage,fit: BoxFit.cover,) :Image.asset('assets/images/luxylion226.png', fit: BoxFit.cover),
                                                          ),
                                                        ),
                                                      ),

                                                      SizedBox(height: 10.0),

                                                      ResponsiveText(

                                                       text: "${referralController.message!.referralLink}".substring(30), // Replace with actual name
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                          color: Get.isDarkMode ? AppColors.appContainerBgColor : AppColors.appFillColor,
                                                          // fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),

                                          SizedBox(height: 20.0),

                                          // Second row with two items
                                          if(referralController.message!.referrals!['1']!.length!=0)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Profile image and name widget for item 1
                                              if(referralController.message!.referrals!['1']!.length>=1)
                                              Container(
                                                width: 100.0,
                                                height: 115.h,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [

                                                    referralController.message!.referrals!['1']![0].image!=null?
                                                    CircleAvatar(
                                                      radius:30.0,
                                                      backgroundImage:NetworkImage('https://luxylion.com/assets/uploads/users/${referralController.message!.referrals!['1']![0].image!}')
                                                    ): CircleAvatar(
          radius: 30.0,
          backgroundImage:AssetImage('assets/images/luxylion226.png')
      ),   // Replace with your image asset

                                                    SizedBox(height: 10.0),
                                                    ResponsiveText(
                                                     text:  referralController.message!.referrals!['1']![0].username!, // Replace with actual name
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                          color: Get.isDarkMode ? AppColors.appContainerBgColor : AppColors.appFillColor,
                                                        // fontWeight: FontWeight.bold,
                                                        // color: Colors.orange
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 20.0), // Add spacing between items
                                              // Profile image and name widget for item 2
                                              if(referralController.message!.referrals!['1']!.length>=2)
                                              Container(
                                                width: 100.0,
                                                height: 115.h,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    referralController.message!.referrals!['1']![1].image!=null?
                                                    CircleAvatar(
                                                        radius:30.0,
                                                        backgroundImage:NetworkImage('https://luxylion.com/assets/uploads/users/${referralController.message!.referrals!['1']![1].image!}')
                                                    ): CircleAvatar(
                                                        radius: 30.0,
                                                        backgroundImage:AssetImage('assets/images/luxylion226.png')
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    ResponsiveText(
                                                     text:  referralController.message!.referrals!['1']![1].username!, // Replace with actual name
                                                      style: TextStyle(
                                                        fontSize: 14.0,

                                                        color: Get.isDarkMode ? AppColors.appContainerBgColor : AppColors.appFillColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20.0),

                                          // Third row with four items
                                          for(int i=3;referralController.message!.referrals!['1']!.length>=i;i=i+3)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Profile image and name widget for item 1
                                              if(referralController.message!.referrals!['1']!.length>=i)
                                              Container(
                                                width: 100.0,
                                                height: 115.h,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    referralController.message!.referrals!['1']![i-1].image!=null?
                                                    CircleAvatar(
                                                        radius:30.0,
                                                        backgroundImage:NetworkImage('https://luxylion.com/assets/uploads/users/${referralController.message!.referrals!['1']![i-1].image!}')
                                                    ): CircleAvatar(
                                                        radius: 30.0,
                                                        backgroundImage:AssetImage('assets/images/luxylion226.png')
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    ResponsiveText(
                                                    text:   referralController.message!.referrals!['1']![i-1].username!, // Replace with actual name
                                                      style: TextStyle(
                                                        fontSize: 14.0,

                                                        color: Get.isDarkMode ? AppColors.appContainerBgColor : AppColors.appFillColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 20.0), // Add spacing between items
                                              // Profile image and name widget for item 2
                                              if(referralController.message!.referrals!['1']!.length>=i+1)
                                              Container(
                                                width: 100.0,
                                                height: 115.h,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    referralController.message!.referrals!['1']![i].image!=null?
                                                    CircleAvatar(
                                                        radius:30.0,
                                                        backgroundImage:NetworkImage('https://luxylion.com/assets/uploads/users/${referralController.message!.referrals!['1']![i].image!}')
                                                    ): CircleAvatar(
                                                        radius: 30.0,
                                                        backgroundImage:AssetImage('assets/images/luxylion226.png')
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    ResponsiveText(
                                                     text:  referralController.message!.referrals!['1']![i].username!, // Replace with actual name
                                                      style: TextStyle(
                                                        fontSize: 14.0,

                                                        color: Get.isDarkMode ? AppColors.appContainerBgColor : AppColors.appFillColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 20.0), // Add spacing between items
                                              // Profile image and name widget for item 3
                                              if(referralController.message!.referrals!['1']!.length>=i+2)
                                              Container(
                                                width: 100.0,
                                                height: 115.h,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    referralController.message!.referrals!['1']![i+1].image!=null?
                                                    CircleAvatar(
                                                        radius:30.0,
                                                        backgroundImage:NetworkImage('https://luxylion.com/assets/uploads/users/${referralController.message!.referrals!['1']![i+1].image!}')
                                                    ): CircleAvatar(
                                                        radius: 30.0,
                                                        backgroundImage:AssetImage('assets/images/luxylion226.png')
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    ResponsiveText(
                                                     text: referralController.message!.referrals!['1']![i+1].username!, // Replace with actual name
                                                      style: TextStyle(
                                                        fontSize: 14.0,

                                                        color: Get.isDarkMode ? AppColors.appContainerBgColor : AppColors.appFillColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        ],
                                      )



                            ,
                          )



 //old code of level

                                      // child: PageView.builder(
                                      //   physics:
                                      //       const NeverScrollableScrollPhysics(),
                                      //   controller: _pageController,
                                      //   itemCount: referralController
                                      //       .message!.referrals!.length,
                                      //   scrollDirection: Axis.horizontal,
                                      //   itemBuilder: (context, referralIndex) {
                                      //     return Padding(
                                      //       padding: const EdgeInsets.symmetric(
                                      //           horizontal: 14, vertical: 6),
                                      //       child: SizedBox(
                                      //         width: 360,
                                      //         child: ListView.builder(
                                      //           shrinkWrap: true,
                                      //           itemCount: referralController
                                      //               .message!
                                      //               .referrals![
                                      //                   "${referralIndex + 1}"]!
                                      //               .length,
                                      //           itemBuilder: (context, index) {
                                      //             return Padding(
                                      //               padding: EdgeInsets.only(
                                      //                   bottom: 16.h),
                                      //               child: Container(
                                      //                 width: 360,
                                      //                 decoration: BoxDecoration(
                                      //                   color: Get.isDarkMode
                                      //                       ? AppColors
                                      //                           .appContainerBgColor
                                      //                       : AppColors
                                      //                           .appBrandColor3,
                                      //                   borderRadius:
                                      //                       BorderRadius
                                      //                           .circular(16),
                                      //                 ),
                                      //                 child: Padding(
                                      //                   padding:
                                      //                       const EdgeInsets
                                      //                           .only(
                                      //                           left: 16,
                                      //                           top: 10,
                                      //                           bottom: 10),
                                      //                   child: Column(
                                      //                     crossAxisAlignment:
                                      //                         CrossAxisAlignment
                                      //                             .start,
                                      //                     children: [
                                      //                       Row(
                                      //                         mainAxisAlignment:
                                      //                             MainAxisAlignment
                                      //                                 .spaceBetween,
                                      //                         children: [
                                      //                           Expanded(
                                      //                             flex: 1,
                                      //                             child:
                                      //                                 Container(
                                      //                               height:
                                      //                                   52.h,
                                      //                               width: 50.w,
                                      //                               decoration:
                                      //                                   BoxDecoration(
                                      //                                 color: AppColors
                                      //                                     .appWhiteColor,
                                      //                                 borderRadius:
                                      //                                     BorderRadius.circular(
                                      //                                         8),
                                      //                               ),
                                      //                               child: Center(
                                      //                                   child: Column(
                                      //                                 mainAxisAlignment:
                                      //                                     MainAxisAlignment
                                      //                                         .center,
                                      //                                 children: [
                                      //                                   Text(
                                      //                                     "${referralIndex + 1}",
                                      //                                     style: GoogleFonts.publicSans(
                                      //                                         fontSize: 14.sp,
                                      //                                         fontWeight: FontWeight.w800,
                                      //                                         color: AppColors.appBlackColor50),
                                      //                                   ),
                                      //                                   Text(
                                      //                                     "${selectedLanguageStorage.read("languageData")["Level"] ?? "Level"}",
                                      //                                     style: GoogleFonts.publicSans(
                                      //                                         fontSize: 12.sp,
                                      //                                         fontWeight: FontWeight.w700,
                                      //                                         color: AppColors.appBlackColor50),
                                      //                                   ),
                                      //                                 ],
                                      //                               )),
                                      //                             ),
                                      //                           ),
                                      //                           SizedBox(
                                      //                             width: 12.w,
                                      //                           ),
                                      //                           Expanded(
                                      //                             flex: 7,
                                      //                             child:
                                      //                                 Container(
                                      //                               height: 70,
                                      //                               child:
                                      //                                   Column(
                                      //                                 mainAxisAlignment:
                                      //                                     MainAxisAlignment
                                      //                                         .center,
                                      //                                 children: [
                                      //                                   Padding(
                                      //                                     padding: const EdgeInsets
                                      //                                         .only(
                                      //                                         right: 12,
                                      //                                         left: 4),
                                      //                                     child:
                                      //                                         Row(
                                      //                                       crossAxisAlignment:
                                      //                                           CrossAxisAlignment.start,
                                      //                                       mainAxisAlignment:
                                      //                                           MainAxisAlignment.spaceBetween,
                                      //                                       children: [
                                      //                                         Text(
                                      //                                           "${referralController.message!.referrals!["${referralIndex + 1}"]![index].email}",
                                      //                                           style: GoogleFonts.niramit(fontWeight: FontWeight.w500, fontSize: 16.sp, color: AppColors.getTextDarkLight()),
                                      //                                         ),
                                      //                                         Text(
                                      //                                           '${referralController.message!.currency}${referralController.message!.referrals!["${referralIndex + 1}"]![index].total_invest}',
                                      //                                           style: GoogleFonts.niramit(fontWeight: FontWeight.w500, fontSize: 16.sp, color: AppColors.appBlackColor50),
                                      //                                         ),
                                      //                                         Text(
                                      //                                           "${selectedLanguageStorage.read("languageData")["Joined At"] ?? "Joined At"}",
                                      //                                           style: GoogleFonts.niramit(fontWeight: FontWeight.w500, fontSize: 16.sp, color: AppColors.appBlackColor50),
                                      //                                         ),
                                      //                                       ],
                                      //                                     ),
                                      //                                   ),
                                      //                                   SizedBox(
                                      //                                     height:
                                      //                                         6.h,
                                      //                                   ),
                                      //                                   Padding(
                                      //                                     padding: const EdgeInsets
                                      //                                         .only(
                                      //                                         right: 12,
                                      //                                         left: 4),
                                      //                                     child:
                                      //                                         Row(
                                      //                                       crossAxisAlignment:
                                      //                                           CrossAxisAlignment.start,
                                      //                                       mainAxisAlignment:
                                      //                                           MainAxisAlignment.spaceBetween,
                                      //                                       children: [
                                      //                                         Text(
                                      //                                           "${referralController.message!.referrals!["${referralIndex + 1}"]![index].username}",
                                      //                                           style: GoogleFonts.niramit(fontWeight: FontWeight.w500, fontSize: 16.sp, color: AppColors.appBlackColor50),
                                      //                                         ),
                                      //                                         Text(
                                      //                                           "${formatApiDate(referralController.message!.referrals!["${referralIndex + 1}"]![index].createdAt.toString())}",
                                      //                                           style: GoogleFonts.niramit(fontWeight: FontWeight.w500, fontSize: 14.sp, color: AppColors.getTextDarkLight()),
                                      //                                         ),
                                      //                                       ],
                                      //                                     ),
                                      //                                   ),
                                      //                                 ],
                                      //                               ),
                                      //                             ),
                                      //                           )
                                      //
                                      //                         ],
                                      //                       ),
                                      //
                                      //                     ],
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             );
                                      //           },
                                      //         ),
                                      //       ),
                                      //     );
                                      //   },
                                      // ),

                              : const SizedBox(),

                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: AppColors.appPrimaryColor,
                        ),
                      )),
      );
    });
  }
}



class ImageNode extends StatelessWidget {
  final String imagePath;

  const ImageNode(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(imagePath),
    );
  }
}


