import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyip_pro/controller/plan_controller.dart';
import 'package:hyip_pro/utils/colors/app_colors.dart';
import 'package:hyip_pro/view/screens/deposit/deposit_screen.dart';
import 'package:hyip_pro/view/widgets/app_custom_dropdown.dart';
import 'package:hyip_pro/view/widgets/app_drawer_widget.dart';

import '../../../controller/notification_controller.dart';

import 'package:carousel_slider/carousel_slider.dart';

class PlanScreen extends StatelessWidget {
  static const String routeName = "/planScreen";
  PlanScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List colors = [
    Color(0xffE1ECFA),
    Color(0xffF9E3FF),
    Color(0xffE1ECFA),
    Color(0xffE1ECFA),
  ];

  Color getRandomColor(int index) {
    if (index < colors.length) {
      return colors[index];
    } else {
      return Color((index * 10).hashCode);
    }
  }

  dynamic selectedOption;

  final selectedLanguageStorage = GetStorage();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Access the arguments passed to this route
    dynamic data = Get.arguments;
    return GetBuilder<PlanController>(builder: (planController) {
      return RefreshIndicator(
        onRefresh: () async {
          planController.getPlanData();
        },
        child: Scaffold(
          backgroundColor: AppColors.getBackgroundDarkLight(),
          // appBar: AppBar(
          //   centerTitle: true,
          //   automaticallyImplyLeading: false,
          //   backgroundColor: AppColors.getAppBarBgDarkLight(),
          //   titleSpacing: data != true ? -10 : 0,
          //   leading: data == "true"
          //       ? InkWell(
          //           onTap: () {
          //             Navigator.pop(context);
          //           },
          //           child: Padding(
          //             padding: const EdgeInsets.all(19.0),
          //             child: Image.asset(
          //               "assets/images/arrow_back_btn.png",
          //               height: 20.h,
          //               width: 20.w,
          //               color: AppColors.getTextDarkLight(),
          //             ),
          //           ))
          //       : const SizedBox.shrink(),
          //   title: Text(
          //     "${selectedLanguageStorage.read("languageData")["Buy Product plan"] ?? "Buy Product plan"}",
          //     style: GoogleFonts.publicSans(
          //         fontWeight: FontWeight.w600,
          //         fontSize: 20.sp,
          //         color: AppColors.getTextDarkLight()),
          //   ),
          // ),
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
                Text(
                  "Buy Product",
                  style: GoogleFonts.publicSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      color: AppColors.getTextDarkLight()),
                ),
                // InkWell(onTap: () {
                //   Get.toNamed(NotificationScreen.routeName);
                // }, child: GetBuilder<NotificationController>(
                //     builder: (notificationController) {
                //       return Stack(
                //         children: [
                //           Image.asset(
                //             "assets/images/notification_icon.png",
                //             height: 26.h,
                //             width: 26.w,
                //           ),
                //           notificationController.eventCount.value > 1
                //               ? Positioned(
                //               top: 0,
                //               right: 5,
                //               child: CircleAvatar(
                //                 backgroundColor: Colors.red,
                //                 radius: 4,
                //               ))
                //               : const SizedBox.shrink(),
                //         ],
                //       );
                //     }))
              ],
            ),
          ),
          key: _scaffoldKey,
          drawer: appDrawer(),

          body: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .15,
                child: ListView(
                  children: [
                    PackageSlideView(), // Display the package slide view
                    // Other widgets in your home page
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: [
                    planController.isLoading == false
                        ? planController.message != null
                        ? ListView.builder(
                        itemCount:
                        planController.message!.plans!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 24.w),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 45.h,
                                    ),

                                    // Container(
                                    //   height: 189.h,
                                    //   width: double.infinity,
                                    //   decoration: BoxDecoration(
                                    //       color: Get.isDarkMode
                                    //           ? AppColors.appContainerBgColor
                                    //           : index < 4
                                    //               ? colors[index]
                                    //               : getRandomColor(index - 4),
                                    //       borderRadius:
                                    //           BorderRadius.circular(16)),
                                    //   child: Padding(
                                    //     padding: EdgeInsets.only(left: 16.w),
                                    //     child: Column(
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       children: [
                                    //         SizedBox(
                                    //           height: 37.h,
                                    //         ),
                                    //         Row(
                                    //           children: [
                                    //             Text(
                                    //               "${planController.message!.plans![index].price}",
                                    //               style: GoogleFonts.niramit(
                                    //                   fontWeight:
                                    //                       FontWeight.w500,
                                    //                   fontSize: 20.sp,
                                    //                   color: AppColors
                                    //                       .getTextDarkLight()),
                                    //             ),
                                    //             SizedBox(
                                    //               width: 12.w,
                                    //             ),
                                    //             Container(
                                    //               height: 14,
                                    //               width: 2,
                                    //               color: AppColors
                                    //                   .appBlackColor50,
                                    //             ),
                                    //             SizedBox(
                                    //               width: 12.w,
                                    //             ),
                                    //             Text(
                                    //               "${planController.message!.plans![index].profit}${planController.message!.plans![index].profitType} ${selectedLanguageStorage.read("languageData")["Every Day"] ?? "Every Day"}",
                                    //               style: GoogleFonts.niramit(
                                    //                 fontWeight:
                                    //                     FontWeight.w400,
                                    //                 fontSize: 16.sp,
                                    //                 color: AppColors
                                    //                     .appBlackColor50,
                                    //               ),
                                    //             )
                                    //           ],
                                    //         ),
                                    //         SizedBox(
                                    //           height: 8.h,
                                    //         ),
                                    //         // Text(
                                    //         //   "${selectedLanguageStorage.read("languageData")["Profit for Lifetime"] ?? "Profit for Lifetime"}",
                                    //         //   style: GoogleFonts.niramit(
                                    //         //       fontWeight: FontWeight.w500,
                                    //         //       fontSize: 16.sp,
                                    //         //       color: AppColors.getTextDarkLight()),
                                    //         // ),
                                    //         // SizedBox(
                                    //         //   height: 8.h,
                                    //         // ),
                                    //         // Row(
                                    //         //   crossAxisAlignment:
                                    //         //       CrossAxisAlignment.center,
                                    //         //   children: [
                                    //         //     Text(
                                    //         //       "${selectedLanguageStorage.read("languageData")["Capital will back:"] ?? "Capital will back:"}",
                                    //         //       style: GoogleFonts.niramit(
                                    //         //           fontWeight:
                                    //         //               FontWeight.w400,
                                    //         //           fontSize: 16.sp,
                                    //         //           color: AppColors
                                    //         //               .appBlackColor50),
                                    //         //     ),
                                    //         //     SizedBox(
                                    //         //       width: 4.w,
                                    //         //     ),
                                    //         //     planController
                                    //         //                 .message!
                                    //         //                 .plans![index]
                                    //         //                 .capitalBack ==
                                    //         //             "Yes"
                                    //         //         ? Padding(
                                    //         //             padding:
                                    //         //                 EdgeInsets.only(
                                    //         //                     top: 5.h),
                                    //         //             child: Image.asset(
                                    //         //               "assets/images/capital.png",
                                    //         //               height: 14.h,
                                    //         //               width: 14.w,
                                    //         //             ),
                                    //         //           )
                                    //         //         : Padding(
                                    //         //             padding:
                                    //         //                 EdgeInsets.only(
                                    //         //                     top: 5.h),
                                    //         //             child: Image.asset(
                                    //         //               "assets/images/cross.png",
                                    //         //               height: 14.h,
                                    //         //               width: 14.w,
                                    //         //             ),
                                    //         //           )
                                    //         //   ],
                                    //         // ),
                                    //         // SizedBox(
                                    //         //   height: 8.h,
                                    //         // ),
                                    //         // Row(
                                    //         //   children: [
                                    //         //     Text(
                                    //         //       "${planController.message!.plans![index].capitalEarning}",
                                    //         //       style: GoogleFonts.niramit(
                                    //         //           fontWeight:
                                    //         //               FontWeight.w500,
                                    //         //           fontSize: 16.sp,
                                    //         //           color: AppColors
                                    //         //               .appBlackColor50),
                                    //         //     ),
                                    //         //   ],
                                    //         // ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    // Container(
                                    //   height: 250,
                                    //   width: double.infinity,
                                    //   decoration: BoxDecoration(
                                    //     color: Get.isDarkMode
                                    //         ? AppColors.appContainerBgColor
                                    //         : index < 4
                                    //         ? colors[index]
                                    //         : getRandomColor(index - 4),
                                    //     borderRadius: BorderRadius.circular(16),
                                    //   ),
                                    //   child: Column(
                                    //     crossAxisAlignment: CrossAxisAlignment.start,
                                    //     children: [
                                    //       Padding(
                                    //         padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                                    //         child: ClipRRect(
                                    //           borderRadius: BorderRadius.circular(8),
                                    //           child: Image.asset(
                                    //             "assets/images/product_1.png",
                                    //             fit: BoxFit.cover,
                                    //             height: 150,
                                    //             width: double.infinity,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       SizedBox(height: 12),
                                    //       Padding(
                                    //         padding: EdgeInsets.symmetric(horizontal: 16),
                                    //         child: Text(
                                    //           "Product ${index + 1}",
                                    //           style: TextStyle(
                                    //             fontWeight: FontWeight.bold,
                                    //             fontSize: 18,
                                    //             color: AppColors.getTextDarkLight(),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       SizedBox(height: 8),
                                    //       Padding(
                                    //         padding: EdgeInsets.symmetric(horizontal: 16),
                                    //         child: Row(
                                    //           children: [
                                    //             Text(
                                    //               "${planController.message!.plans![index].price}",
                                    //               style: TextStyle(
                                    //                 fontWeight: FontWeight.w500,
                                    //                 fontSize: 20,
                                    //                 color: AppColors.getTextDarkLight(),
                                    //               ),
                                    //             ),
                                    //             SizedBox(width: 8),
                                    //             Text(
                                    //               "${planController.message!.plans![index].profit}${planController.message!.plans![index].profitType} ${selectedLanguageStorage.read("languageData")["Every Day"] ?? "Every Day"}",
                                    //               style: TextStyle(
                                    //                 fontWeight: FontWeight.w400,
                                    //                 fontSize: 16,
                                    //                 color: AppColors.appBlackColor50,
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Expanded(
                                    //       child: Container(
                                    //         height: 300,
                                    //         decoration: BoxDecoration(
                                    //           color: Colors.grey[200], // Gray background color
                                    //           borderRadius: BorderRadius.circular(16),
                                    //           boxShadow: [
                                    //             BoxShadow(
                                    //               color: Colors.grey.withOpacity(0.5),
                                    //               spreadRadius: 3,
                                    //               blurRadius: 7,
                                    //               offset: Offset(0, 3), // changes position of shadow
                                    //             ),
                                    //           ],
                                    //         ),
                                    //         child: Column(
                                    //           crossAxisAlignment: CrossAxisAlignment.start,
                                    //           children: [
                                    //             ClipRRect(
                                    //               borderRadius: BorderRadius.only(
                                    //                 topLeft: Radius.circular(16),
                                    //                 topRight: Radius.circular(16),
                                    //               ),
                                    //               child: Image.asset(
                                    //                 "assets/images/product_1.png", // Replace with your image path
                                    //                 fit: BoxFit.contain,
                                    //                 height: 200,
                                    //                 width: double.infinity,
                                    //               ),
                                    //             ),
                                    //             Padding(
                                    //               padding: EdgeInsets.all(16),
                                    //               child: Column(
                                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                                    //                 children: [
                                    //                   Text(
                                    //                     "${planController.message!.plans![index].name}", // Replace with your product name
                                    //                     style: TextStyle(
                                    //                       fontSize: 20,
                                    //                       fontWeight: FontWeight.bold,
                                    //                     ),
                                    //                   ),
                                    //                   SizedBox(height: 8),
                                    //                   Text(
                                    //                     "\$99.99", // Replace with your product price
                                    //                     style: TextStyle(
                                    //                       fontSize: 16,
                                    //                       fontWeight: FontWeight.bold,
                                    //                       color: Colors.green, // Customize price color
                                    //                     ),
                                    //                   ),
                                    //                 ],
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     SizedBox(width: 16), // Add spacing between containers
                                    //     Expanded(
                                    //       child: Container(
                                    //         height: 300,
                                    //         decoration: BoxDecoration(
                                    //           color: Colors.grey[200], // Gray background color
                                    //           borderRadius: BorderRadius.circular(16),
                                    //           boxShadow: [
                                    //             BoxShadow(
                                    //               color: Colors.grey.withOpacity(0.5),
                                    //               spreadRadius: 3,
                                    //               blurRadius: 7,
                                    //               offset: Offset(0, 3), // changes position of shadow
                                    //             ),
                                    //           ],
                                    //         ),
                                    //         child: Column(
                                    //           crossAxisAlignment: CrossAxisAlignment.start,
                                    //           children: [
                                    //             ClipRRect(
                                    //               borderRadius: BorderRadius.only(
                                    //                 topLeft: Radius.circular(16),
                                    //                 topRight: Radius.circular(16),
                                    //               ),
                                    //               child: Image.asset(
                                    //                 "assets/images/product_1.png", // Replace with your image path
                                    //                 fit: BoxFit.contain,
                                    //                 height: 200,
                                    //                 width: double.infinity,
                                    //               ),
                                    //             ),
                                    //             Padding(
                                    //               padding: EdgeInsets.all(16),
                                    //               child: Column(
                                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                                    //                 children: [
                                    //                   Text(
                                    //                     "${planController.message!.plans![index].name}",// Replace with your product name
                                    //                     style: TextStyle(
                                    //                       fontSize: 20,
                                    //                       fontWeight: FontWeight.bold,
                                    //                     ),
                                    //                   ),
                                    //                   SizedBox(height: 8),
                                    //                   Text(
                                    //                     "\$99.99", // Replace with your product price
                                    //                     style: TextStyle(
                                    //                       fontSize: 16,
                                    //                       fontWeight: FontWeight.bold,
                                    //                       color: Colors.green, // Customize price color
                                    //                     ),
                                    //                   ),
                                    //                 ],
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height:
                                            MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.34,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[
                                              200], // Gray background color
                                              borderRadius:
                                              BorderRadius.circular(
                                                  16),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 3,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .center,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.only(
                                                    topLeft:
                                                    Radius.circular(
                                                        16),
                                                    topRight:
                                                    Radius.circular(
                                                        16),
                                                  ),
                                                  //change image
                                                  child: planController
                                                      .message!
                                                      .plans![
                                                  index]
                                                      .image !=
                                                      null &&
                                                      planController
                                                          .message!
                                                          .plans![
                                                      index]
                                                          .image!
                                                          .isNotEmpty
                                                      ? Image.network(
                                                    "https://luxylion.com/assets/uploads/product/${planController.message!.plans![index].image}", // Replace with your image path
                                                    fit: BoxFit
                                                        .contain,
                                                    height: 120,
                                                    width: double
                                                        .infinity,
                                                  )
                                                      : Image.asset(
                                                    "assets/images/product_1.png", // Replace with your image path
                                                    fit: BoxFit
                                                        .contain,
                                                    height: 120,
                                                    width: double
                                                        .infinity,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  EdgeInsets.all(
                                                      10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      Text(
                                                        "${planController.message!.plans![index].name}", // Replace with your product name
                                                        style:
                                                        TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: 5),
                                                      Text(
                                                        "${planController.message!.plans![index].price}", // Replace with your product price
                                                        style:
                                                        TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          color: Colors
                                                              .green, // Customize price color
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height:
                                                          20), // Add space between price and button
                                                      InkWell(
                                                        onTap: () {
                                                          showBottomSheet(
                                                            context:
                                                            context,
                                                            builder:
                                                                (context) {
                                                              planController
                                                                  .amountCtrl
                                                                  .text = '';
                                                              if (!planController
                                                                  .message!
                                                                  .plans![
                                                              index]
                                                                  .price!
                                                                  .contains(
                                                                  '-')) {
                                                                planController
                                                                    .amountCtrl
                                                                    .text = extractNumberFromString(
                                                                    planController.message!.plans![index].price!)
                                                                    .toString();
                                                              }
                                                              return SingleChildScrollView(
                                                                child:
                                                                Container(
                                                                  color: Get.isDarkMode
                                                                      ? AppColors.appContainerBgColor
                                                                      : AppColors.appWhiteColor,
                                                                  height:
                                                                  MediaQuery.of(context).size.height * 0.55,
                                                                  padding: const EdgeInsets
                                                                      .all(
                                                                      20),
                                                                  child:
                                                                  Form(
                                                                    key:
                                                                    _formKey,
                                                                    child:
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      mainAxisSize: MainAxisSize.min,
                                                                      children: [
                                                                        // Your content here
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              '${planController.message!.plans![index].name}',
                                                                              style: TextStyle(
                                                                                fontSize: 16.sp,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: const Icon(Icons.cancel),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: 10.h),
                                                                        Text(
                                                                          '${planController.message!.plans![index].price}',
                                                                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.appPrimaryColor),
                                                                        ),
                                                                        SizedBox(height: 10.h),
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                            color: AppColors.appFillColor,
                                                                            borderRadius: BorderRadius.circular(5),
                                                                          ),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(8.0),
                                                                            child: Text(
                                                                              '${planController.message!.plans![index].profit}${planController.message!.plans![index].profitType} Every day',
                                                                              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.appBlackColor),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(height: 30.h),
                                                                        Text(
                                                                          " ${selectedLanguageStorage.read("languageData")["Select Wallet"] ?? "Select Wallet"}",
                                                                          style: TextStyle(
                                                                            fontSize: 14.sp,
                                                                            fontWeight: FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        SizedBox(height: 10.h),
                                                                        Container(
                                                                          height: 45.h,
                                                                          width: double.infinity,
                                                                          decoration: BoxDecoration(
                                                                            color: Get.isDarkMode ? AppColors.appDefaultDarkMode : AppColors.appFillColor,
                                                                            borderRadius: BorderRadius.circular(5),
                                                                          ),
                                                                          child: StatefulBuilder(
                                                                            builder: (context, setState) {
                                                                              return AppCustomDropDown(
                                                                                dropdownDecoration: BoxDecoration(
                                                                                  color: Get.isDarkMode ? AppColors.appDefaultDarkMode : AppColors.appWhiteColor,
                                                                                ),
                                                                                height: 50.h,
                                                                                width: double.infinity,
                                                                                items: [
                                                                                  // planController.message!.balance.toString(),
                                                                                  // planController.message!.interestBalance.toString(),
                                                                                  "Pay Money",
                                                                                ],
                                                                                selectedValue: selectedOption,
                                                                                onChanged: (value) {
                                                                                  setState(() {
                                                                                    selectedOption = value;
                                                                                  });
                                                                                },
                                                                                hint: "${selectedLanguageStorage.read("languageData")["Select an option"] ?? "Select an option"}",
                                                                                fontSize: 14.sp,
                                                                                hintStyle: TextStyle(fontSize: 14.sp),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),

                                                                        SizedBox(height: 20.h),
                                                                        Text(
                                                                          "${selectedLanguageStorage.read("languageData")["Amount"] ?? "Amount"}",
                                                                          style: TextStyle(
                                                                            fontSize: 14.sp,
                                                                            fontWeight: FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        SizedBox(height: 10.h),
                                                                        TextFormField(
                                                                          validator: (value) {
                                                                            if (value!.isEmpty) {
                                                                              return 'Amount is required';
                                                                            }
                                                                            return null;
                                                                          },
                                                                          inputFormatters: [
                                                                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,5}')),
                                                                          ],
                                                                          keyboardType: TextInputType.number,
                                                                          readOnly: planController.message!.plans![index].price!.contains('-') ? false : true,
                                                                          controller: planController.amountCtrl,
                                                                          decoration: InputDecoration(
                                                                            contentPadding: const EdgeInsets.only(left: 12, top: 10, bottom: 12),
                                                                            border: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(8.0), // Set the border radius here
                                                                              borderSide: BorderSide.none, // Remove the default border
                                                                            ),
                                                                            fillColor: Get.isDarkMode ? AppColors.appDefaultDarkMode : AppColors.appFillColor,
                                                                            filled: true,
                                                                            hintText: "${selectedLanguageStorage.read("languageData")["Enter Amount"] ?? "Enter Amount"}",
                                                                            hintStyle: TextStyle(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(height: 30.h),
                                                                        GetBuilder<PlanController>(
                                                                          builder: (planController) {
                                                                            return Center(
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(32),
                                                                                child: MaterialButton(
                                                                                  color: AppColors.appBrandColor2,
                                                                                  height: 50.h,
                                                                                  minWidth: double.infinity,
                                                                                  onPressed: () {
                                                                                    if (_formKey.currentState!.validate()) {
                                                                                      if (planController.message!.plans![index].price!.contains('-') && double.parse(planController.amountCtrl.text) < double.parse(planController.message!.plans![index].min.toString())) {
                                                                                        final snackBar = SnackBar(
                                                                                          content: Text(
                                                                                            "${selectedLanguageStorage.read("languageData")["Minimum deposit amount"] ?? "Minimum deposit amount"} ${planController.message!.plans![index].min}",
                                                                                            style: TextStyle(color: Colors.white, fontSize: 14.sp),
                                                                                          ),
                                                                                          backgroundColor: Colors.red,
                                                                                          duration: const Duration(seconds: 2),
                                                                                          behavior: SnackBarBehavior.floating,
                                                                                          margin: const EdgeInsets.all(5),
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(8),
                                                                                          ),
                                                                                          elevation: 10,
                                                                                        );

                                                                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                      } else if (planController.message!.plans![index].price!.contains('-') && double.parse(planController.amountCtrl.text) > double.parse(planController.message!.plans![index].max.toString())) {
                                                                                        final snackBar = SnackBar(
                                                                                          content: Text(
                                                                                            "${selectedLanguageStorage.read("languageData")["Maximum deposit amount"] ?? "Maximum deposit amount"} ${planController.message!.plans![index].max}",
                                                                                            style: TextStyle(color: Colors.white, fontSize: 14.sp),
                                                                                          ),
                                                                                          backgroundColor: Colors.red,
                                                                                          duration: const Duration(seconds: 2),
                                                                                          behavior: SnackBarBehavior.floating,
                                                                                          margin: const EdgeInsets.all(5),
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(8),
                                                                                          ),
                                                                                          elevation: 10,
                                                                                        );

                                                                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                      } else {
                                                                                        if (selectedOption == "${planController.message!.balance}") {
                                                                                          planController
                                                                                              .buyPlanWallet(
                                                                                            "balance",
                                                                                            planController.amountCtrl.text.toString(),
                                                                                            "${planController.message!.plans![index].id}",
                                                                                          )
                                                                                              .then((value) {
                                                                                            if (planController.apiCallStatus == "success") {
                                                                                              planController.amountCtrl.text = '';
                                                                                            }
                                                                                          });
                                                                                        } else if (selectedOption == "${planController.message!.interestBalance}") {
                                                                                          planController
                                                                                              .buyPlanWallet(
                                                                                            "interest_balance",
                                                                                            planController.amountCtrl.text.toString(),
                                                                                            "${planController.message!.plans![index].id}",
                                                                                          )
                                                                                              .then((value) {
                                                                                            if (planController.apiCallStatus == "success") {
                                                                                              planController.amountCtrl.text = '';
                                                                                            }
                                                                                          });
                                                                                        } else if (selectedOption == "Pay Money") {
                                                                                          Navigator.push(
                                                                                              context,
                                                                                              MaterialPageRoute(
                                                                                                  builder: (context) => DepositScreen(
                                                                                                    amount: planController.amountCtrl.text,
                                                                                                    planID: planController.message!.plans![index].id,
                                                                                                    isfixed: (!planController.message!.plans![index].price!.contains('-')),
                                                                                                  )));
                                                                                        } else {
                                                                                          print("Please select an option");
                                                                                          final snackBar = SnackBar(
                                                                                            content: Text(
                                                                                              "${selectedLanguageStorage.read("languageData")["Please select an option"] ?? "Please select an option"}",
                                                                                              style: TextStyle(color: Colors.white, fontSize: 14.sp),
                                                                                            ),
                                                                                            backgroundColor: Colors.red,
                                                                                            duration: const Duration(seconds: 2),
                                                                                            behavior: SnackBarBehavior.floating,
                                                                                            margin: const EdgeInsets.all(5),
                                                                                            shape: RoundedRectangleBorder(
                                                                                              borderRadius: BorderRadius.circular(8),
                                                                                            ),
                                                                                            elevation: 10,
                                                                                          );

                                                                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                        }
                                                                                      }
                                                                                    }
                                                                                  },
                                                                                  child: planController.isBuyPlanLoading == false
                                                                                      ? Text(
                                                                                    "${selectedLanguageStorage.read("languageData")["Buy Now"] ?? "Buy Now"}",
                                                                                    style: TextStyle(
                                                                                      color: Colors.black,
                                                                                      fontSize: 18.sp,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  )
                                                                                      : const CircularProgressIndicator(
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child:
                                                        Container(
                                                          height: 42,
                                                          width: 140,
                                                          decoration:
                                                          BoxDecoration(
                                                            color: AppColors
                                                                .appBrandColor2,
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                32),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "${selectedLanguageStorage.read("languageData")["Buyy Now"] ?? "Buy Now"}",
                                                              style:
                                                              TextStyle(
                                                                fontSize:
                                                                16,
                                                                fontWeight:
                                                                FontWeight.w500,
                                                                color: AppColors
                                                                    .appBlackColor,
                                                                height:
                                                                1,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                            10), // Add spacing between containers
                                        // Add another container here if needed
                                        Expanded(
                                          child: Container(
                                            height:
                                            MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.34,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[
                                              200], // Gray background color
                                              borderRadius:
                                              BorderRadius.circular(
                                                  16),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 3,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .center,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.only(
                                                    topLeft:
                                                    Radius.circular(
                                                        16),
                                                    topRight:
                                                    Radius.circular(
                                                        16),
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/product_1.png", // Replace with your image path
                                                    fit: BoxFit.contain,
                                                    height: 120,
                                                    width:
                                                    double.infinity,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  EdgeInsets.all(
                                                      10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      Text(
                                                        "${planController.message!.plans![index].name}", // Replace with your product name
                                                        style:
                                                        TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: 5),
                                                      Text(
                                                        "${planController.message!.plans![index].price}", // Replace with your product price
                                                        style:
                                                        TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          color: Colors
                                                              .green, // Customize price color
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height:
                                                          20), // Add space between price and button
                                                      InkWell(
                                                        onTap: () {
                                                          showBottomSheet(
                                                            context:
                                                            context,
                                                            builder:
                                                                (context) {
                                                              planController
                                                                  .amountCtrl
                                                                  .text = '';
                                                              if (!planController
                                                                  .message!
                                                                  .plans![
                                                              index]
                                                                  .price!
                                                                  .contains(
                                                                  '-')) {
                                                                planController
                                                                    .amountCtrl
                                                                    .text = extractNumberFromString(
                                                                    planController.message!.plans![index].price!)
                                                                    .toString();
                                                              }
                                                              return SingleChildScrollView(
                                                                child:
                                                                Container(
                                                                  color: Get.isDarkMode
                                                                      ? AppColors.appContainerBgColor
                                                                      : AppColors.appWhiteColor,
                                                                  height:
                                                                  MediaQuery.of(context).size.height * 0.55,
                                                                  padding: const EdgeInsets
                                                                      .all(
                                                                      20),
                                                                  child:
                                                                  Form(
                                                                    key:
                                                                    _formKey,
                                                                    child:
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      mainAxisSize: MainAxisSize.min,
                                                                      children: [
                                                                        // Your content here
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              '${planController.message!.plans![index].name}',
                                                                              style: TextStyle(
                                                                                fontSize: 16.sp,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: const Icon(Icons.cancel),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: 10.h),
                                                                        Text(
                                                                          '${planController.message!.plans![index].price}',
                                                                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.appPrimaryColor),
                                                                        ),
                                                                        SizedBox(height: 10.h),
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                            color: AppColors.appFillColor,
                                                                            borderRadius: BorderRadius.circular(5),
                                                                          ),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(8.0),
                                                                            child: Text(
                                                                              '${planController.message!.plans![index].profit}${planController.message!.plans![index].profitType} Every day',
                                                                              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.appBlackColor),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(height: 30.h),
                                                                        Text(
                                                                          " ${selectedLanguageStorage.read("languageData")["Select Wallet"] ?? "Select Wallet"}",
                                                                          style: TextStyle(
                                                                            fontSize: 14.sp,
                                                                            fontWeight: FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        SizedBox(height: 10.h),
                                                                        Container(
                                                                          height: 45.h,
                                                                          width: double.infinity,
                                                                          decoration: BoxDecoration(
                                                                            color: Get.isDarkMode ? AppColors.appDefaultDarkMode : AppColors.appFillColor,
                                                                            borderRadius: BorderRadius.circular(5),
                                                                          ),
                                                                          child: StatefulBuilder(
                                                                            builder: (context, setState) {
                                                                              return AppCustomDropDown(
                                                                                dropdownDecoration: BoxDecoration(
                                                                                  color: Get.isDarkMode ? AppColors.appDefaultDarkMode : AppColors.appWhiteColor,
                                                                                ),
                                                                                height: 50.h,
                                                                                width: double.infinity,
                                                                                items: [
                                                                                  // planController.message!.balance.toString(),
                                                                                  // planController.message!.interestBalance.toString(),
                                                                                  "Pay Money",
                                                                                ],
                                                                                selectedValue: selectedOption,
                                                                                onChanged: (value) {
                                                                                  setState(() {
                                                                                    selectedOption = value;
                                                                                  });
                                                                                },
                                                                                hint: "${selectedLanguageStorage.read("languageData")["Select an option"] ?? "Select an option"}",
                                                                                fontSize: 14.sp,
                                                                                hintStyle: TextStyle(fontSize: 14.sp),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),

                                                                        SizedBox(height: 20.h),
                                                                        Text(
                                                                          "${selectedLanguageStorage.read("languageData")["Amount"] ?? "Amount"}",
                                                                          style: TextStyle(
                                                                            fontSize: 14.sp,
                                                                            fontWeight: FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        SizedBox(height: 10.h),
                                                                        TextFormField(
                                                                          validator: (value) {
                                                                            if (value!.isEmpty) {
                                                                              return 'Amount is required';
                                                                            }
                                                                            return null;
                                                                          },
                                                                          inputFormatters: [
                                                                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,5}')),
                                                                          ],
                                                                          keyboardType: TextInputType.number,
                                                                          readOnly: planController.message!.plans![index].price!.contains('-') ? false : true,
                                                                          controller: planController.amountCtrl,
                                                                          decoration: InputDecoration(
                                                                            contentPadding: const EdgeInsets.only(left: 12, top: 10, bottom: 12),
                                                                            border: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(8.0), // Set the border radius here
                                                                              borderSide: BorderSide.none, // Remove the default border
                                                                            ),
                                                                            fillColor: Get.isDarkMode ? AppColors.appDefaultDarkMode : AppColors.appFillColor,
                                                                            filled: true,
                                                                            hintText: "${selectedLanguageStorage.read("languageData")["Enter Amount"] ?? "Enter Amount"}",
                                                                            hintStyle: TextStyle(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(height: 30.h),
                                                                        GetBuilder<PlanController>(
                                                                          builder: (planController) {
                                                                            return Center(
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(32),
                                                                                child: MaterialButton(
                                                                                  color: AppColors.appBrandColor2,
                                                                                  height: 50.h,
                                                                                  minWidth: double.infinity,
                                                                                  onPressed: () {
                                                                                    if (_formKey.currentState!.validate()) {
                                                                                      if (planController.message!.plans![index].price!.contains('-') && double.parse(planController.amountCtrl.text) < double.parse(planController.message!.plans![index].min.toString())) {
                                                                                        final snackBar = SnackBar(
                                                                                          content: Text(
                                                                                            "${selectedLanguageStorage.read("languageData")["Minimum deposit amount"] ?? "Minimum deposit amount"} ${planController.message!.plans![index].min}",
                                                                                            style: TextStyle(color: Colors.white, fontSize: 14.sp),
                                                                                          ),
                                                                                          backgroundColor: Colors.red,
                                                                                          duration: const Duration(seconds: 2),
                                                                                          behavior: SnackBarBehavior.floating,
                                                                                          margin: const EdgeInsets.all(5),
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(8),
                                                                                          ),
                                                                                          elevation: 10,
                                                                                        );

                                                                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                      } else if (planController.message!.plans![index].price!.contains('-') && double.parse(planController.amountCtrl.text) > double.parse(planController.message!.plans![index].max.toString())) {
                                                                                        final snackBar = SnackBar(
                                                                                          content: Text(
                                                                                            "${selectedLanguageStorage.read("languageData")["Maximum deposit amount"] ?? "Maximum deposit amount"} ${planController.message!.plans![index].max}",
                                                                                            style: TextStyle(color: Colors.white, fontSize: 14.sp),
                                                                                          ),
                                                                                          backgroundColor: Colors.red,
                                                                                          duration: const Duration(seconds: 2),
                                                                                          behavior: SnackBarBehavior.floating,
                                                                                          margin: const EdgeInsets.all(5),
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(8),
                                                                                          ),
                                                                                          elevation: 10,
                                                                                        );

                                                                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                      } else {
                                                                                        if (selectedOption == "${planController.message!.balance}") {
                                                                                          planController
                                                                                              .buyPlanWallet(
                                                                                            "balance",
                                                                                            planController.amountCtrl.text.toString(),
                                                                                            "${planController.message!.plans![index].id}",
                                                                                          )
                                                                                              .then((value) {
                                                                                            if (planController.apiCallStatus == "success") {
                                                                                              planController.amountCtrl.text = '';
                                                                                            }
                                                                                          });
                                                                                        } else if (selectedOption == "${planController.message!.interestBalance}") {
                                                                                          planController
                                                                                              .buyPlanWallet(
                                                                                            "interest_balance",
                                                                                            planController.amountCtrl.text.toString(),
                                                                                            "${planController.message!.plans![index].id}",
                                                                                          )
                                                                                              .then((value) {
                                                                                            if (planController.apiCallStatus == "success") {
                                                                                              planController.amountCtrl.text = '';
                                                                                            }
                                                                                          });
                                                                                        } else if (selectedOption == "Pay Money") {
                                                                                          Navigator.push(
                                                                                              context,
                                                                                              MaterialPageRoute(
                                                                                                  builder: (context) => DepositScreen(
                                                                                                    amount: planController.amountCtrl.text,
                                                                                                    planID: planController.message!.plans![index].id,
                                                                                                    isfixed: (!planController.message!.plans![index].price!.contains('-')),
                                                                                                  )));
                                                                                        } else {
                                                                                          print("Please select an option");
                                                                                          final snackBar = SnackBar(
                                                                                            content: Text(
                                                                                              "${selectedLanguageStorage.read("languageData")["Please select an option"] ?? "Please select an option"}",
                                                                                              style: TextStyle(color: Colors.white, fontSize: 14.sp),
                                                                                            ),
                                                                                            backgroundColor: Colors.red,
                                                                                            duration: const Duration(seconds: 2),
                                                                                            behavior: SnackBarBehavior.floating,
                                                                                            margin: const EdgeInsets.all(5),
                                                                                            shape: RoundedRectangleBorder(
                                                                                              borderRadius: BorderRadius.circular(8),
                                                                                            ),
                                                                                            elevation: 10,
                                                                                          );

                                                                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                        }
                                                                                      }
                                                                                    }
                                                                                  },
                                                                                  child: planController.isBuyPlanLoading == false
                                                                                      ? Text(
                                                                                    "${selectedLanguageStorage.read("languageData")["Buy Now"] ?? "Buy Now2"}",
                                                                                    style: TextStyle(
                                                                                      color: Colors.black,
                                                                                      fontSize: 18.sp,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  )
                                                                                      : const CircularProgressIndicator(
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child:
                                                        Container(
                                                          height: 42,
                                                          width: 140,
                                                          decoration:
                                                          BoxDecoration(
                                                            color: AppColors
                                                                .appBrandColor2,
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                32),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "${selectedLanguageStorage.read("languageData")["Buyy Now"] ?? "Buy Now2"}",
                                                              style:
                                                              TextStyle(
                                                                fontSize:
                                                                16,
                                                                fontWeight:
                                                                FontWeight.w500,
                                                                color: AppColors
                                                                    .appBlackColor,
                                                                height:
                                                                1,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                      ],
                                    )
                                  ],
                                ),

                                // Positioned(
                                //   top: 20,
                                //   left: 100,
                                //   right: 100,
                                //   child: Container(
                                //     height: 42,
                                //     width: 162,
                                //     decoration: BoxDecoration(
                                //         color: AppColors.appFillColor,
                                //         borderRadius:
                                //             BorderRadius.circular(32)),
                                //     child: Center(
                                //       child: Text(
                                //         "${planController.message!.plans![index].name}",
                                //         style: GoogleFonts.niramit(
                                //             fontSize: 16.sp,
                                //             fontWeight: FontWeight.w500,
                                //             color: AppColors.appBlackColor),
                                //       ),
                                //     ),
                                //   ),
                                // ),

                                //old button
                                //                                  Positioned(
                                //                                    bottom: 20,
                                //                                    right: 10,
                                //                                    child: InkWell(
                                //                                      onTap: () {
                                //                                        showBottomSheet(
                                //                                          context: context,
                                //                                          builder: (context) {
                                //                                            planController.amountCtrl.text = '';
                                //                                            if (!planController
                                //                                                .message!.plans![index].price!
                                //                                                .contains('-')) {
                                //                                              planController.amountCtrl.text =
                                //                                                  extractNumberFromString(
                                //                                                          planController
                                //                                                              .message!
                                //                                                              .plans![index]
                                //                                                              .price!)
                                //                                                      .toString();
                                //                                            }
                                //                                            return SingleChildScrollView(
                                //                                              child: Container(
                                //                                                color: Get.isDarkMode
                                //                                                    ? AppColors
                                //                                                        .appContainerBgColor
                                //                                                    : AppColors.appWhiteColor,
                                //                                                height: MediaQuery.of(context)
                                //                                                        .size
                                //                                                        .height *
                                //                                                    0.55,
                                //                                                padding:
                                //                                                    const EdgeInsets.all(20),
                                //                                                child: Form(
                                //                                                  key: _formKey,
                                //                                                  child: Column(
                                //                                                    crossAxisAlignment:
                                //                                                        CrossAxisAlignment
                                //                                                            .start,
                                //                                                    mainAxisSize:
                                //                                                        MainAxisSize.min,
                                //                                                    children: [
                                //                                                      // Your content here
                                //                                                      Row(
                                //                                                        mainAxisAlignment:
                                //                                                            MainAxisAlignment
                                //                                                                .spaceBetween,
                                //                                                        children: [
                                //                                                          Text(
                                //                                                            '${planController.message!.plans![index].name}',
                                //                                                            style: TextStyle(
                                //                                                              fontSize: 16.sp,
                                //                                                              fontWeight:
                                //                                                                  FontWeight
                                //                                                                      .bold,
                                //                                                            ),
                                //                                                          ),
                                //                                                          GestureDetector(
                                //                                                            onTap: () {
                                //                                                              Navigator.pop(
                                //                                                                  context);
                                //                                                            },
                                //                                                            child: const Icon(
                                //                                                                Icons.cancel),
                                //                                                          )
                                //                                                        ],
                                //                                                      ),
                                //                                                      SizedBox(height: 10.h),
                                //                                                      Text(
                                //                                                        '${planController.message!.plans![index].price}',
                                //                                                        style: TextStyle(
                                //                                                            fontSize: 18.sp,
                                //                                                            fontWeight:
                                //                                                                FontWeight.bold,
                                //                                                            color: AppColors
                                //                                                                .appPrimaryColor),
                                //                                                      ),
                                //                                                      SizedBox(height: 10.h),
                                //                                                      Container(
                                //                                                        decoration:
                                //                                                            BoxDecoration(
                                //                                                          color: AppColors
                                //                                                              .appFillColor,
                                //                                                          borderRadius:
                                //                                                              BorderRadius
                                //                                                                  .circular(5),
                                //                                                        ),
                                //                                                        child: Padding(
                                //                                                          padding:
                                //                                                              const EdgeInsets
                                //                                                                  .all(8.0),
                                //                                                          child: Text(
                                //                                                            '${planController.message!.plans![index].profit}${planController.message!.plans![index].profitType} Every day',
                                //                                                            style: TextStyle(
                                //                                                                fontSize: 12.sp,
                                //                                                                fontWeight:
                                //                                                                    FontWeight
                                //                                                                        .w500,
                                //                                                                color: AppColors
                                //                                                                    .appBlackColor),
                                //                                                          ),
                                //                                                        ),
                                //                                                      ),
                                //                                                      SizedBox(height: 30.h),
                                //                                                      Text(
                                //                                                        " ${selectedLanguageStorage.read("languageData")["Select Wallet"] ?? "Select Wallet"}",
                                //                                                        style: TextStyle(
                                //                                                          fontSize: 14.sp,
                                //                                                          fontWeight:
                                //                                                              FontWeight.bold,
                                //                                                        ),
                                //                                                      ),
                                //                                                      SizedBox(height: 10.h),
                                //                                                      Container(
                                //                                                        height: 45.h,
                                //                                                        width: double.infinity,
                                //                                                        decoration:
                                //                                                            BoxDecoration(
                                //                                                          color: Get.isDarkMode
                                //                                                              ? AppColors
                                //                                                                  .appDefaultDarkMode
                                //                                                              : AppColors
                                //                                                                  .appFillColor,
                                //                                                          borderRadius:
                                //                                                              BorderRadius
                                //                                                                  .circular(5),
                                //                                                        ),
                                //                                                        child: StatefulBuilder(
                                //                                                          builder: (context,
                                //                                                              setState) {
                                //                                                            return AppCustomDropDown(
                                //                                                              dropdownDecoration:
                                //                                                                  BoxDecoration(
                                //                                                                color: Get
                                //                                                                        .isDarkMode
                                //                                                                    ? AppColors
                                //                                                                        .appDefaultDarkMode
                                //                                                                    : AppColors
                                //                                                                        .appWhiteColor,
                                //                                                              ),
                                //                                                              height: 50.h,
                                //                                                              width: double
                                //                                                                  .infinity,
                                //                                                              items: [
                                //                                                                // planController.message!.balance.toString(),
                                //                                                                // planController.message!.interestBalance.toString(),
                                //                                                                "Pay Money",
                                //                                                              ],
                                //                                                              selectedValue:
                                //                                                                  selectedOption,
                                //                                                              onChanged:
                                //                                                                  (value) {
                                //                                                                setState(() {
                                //                                                                  selectedOption =
                                //                                                                      value;
                                //                                                                });
                                //                                                              },
                                //                                                              hint:
                                //                                                                  "${selectedLanguageStorage.read("languageData")["Select an option"] ?? "Select an option"}",
                                //                                                              fontSize: 14.sp,
                                //                                                              hintStyle:
                                //                                                                  TextStyle(
                                //                                                                      fontSize:
                                //                                                                          14.sp),
                                //                                                            );
                                //                                                          },
                                //                                                        ),
                                //                                                      ),
                                //
                                //                                                      SizedBox(height: 20.h),
                                //                                                      Text(
                                //                                                        "${selectedLanguageStorage.read("languageData")["Amount"] ?? "Amount"}",
                                //                                                        style: TextStyle(
                                //                                                          fontSize: 14.sp,
                                //                                                          fontWeight:
                                //                                                              FontWeight.bold,
                                //                                                        ),
                                //                                                      ),
                                //                                                      SizedBox(height: 10.h),
                                //                                                      TextFormField(
                                //                                                        validator: (value) {
                                //                                                          if (value!.isEmpty) {
                                //                                                            return 'Amount is required';
                                //                                                          }
                                //                                                          return null;
                                //                                                        },
                                //                                                        inputFormatters: [
                                //                                                          FilteringTextInputFormatter
                                //                                                              .allow(RegExp(
                                //                                                                  r'^\d+\.?\d{0,5}')),
                                //                                                        ],
                                //                                                        keyboardType:
                                //                                                            TextInputType
                                //                                                                .number,
                                //                                                        readOnly: planController
                                //                                                                .message!
                                //                                                                .plans![index]
                                //                                                                .price!
                                //                                                                .contains('-')
                                //                                                            ? false
                                //                                                            : true,
                                //                                                        controller:
                                //                                                            planController
                                //                                                                .amountCtrl,
                                //                                                        decoration:
                                //                                                            InputDecoration(
                                //                                                          contentPadding:
                                //                                                              const EdgeInsets
                                //                                                                  .only(
                                //                                                                  left: 12,
                                //                                                                  top: 10,
                                //                                                                  bottom: 12),
                                //                                                          border:
                                //                                                              OutlineInputBorder(
                                //                                                            borderRadius:
                                //                                                                BorderRadius
                                //                                                                    .circular(
                                //                                                                        8.0), // Set the border radius here
                                //                                                            borderSide: BorderSide
                                //                                                                .none, // Remove the default border
                                //                                                          ),
                                //                                                          fillColor: Get
                                //                                                                  .isDarkMode
                                //                                                              ? AppColors
                                //                                                                  .appDefaultDarkMode
                                //                                                              : AppColors
                                //                                                                  .appFillColor,
                                //                                                          filled: true,
                                //                                                          hintText:
                                //                                                              "${selectedLanguageStorage.read("languageData")["Enter Amount"] ?? "Enter Amount"}",
                                //                                                          hintStyle: TextStyle(
                                //                                                            fontSize: 14.sp,
                                //                                                            fontWeight:
                                //                                                                FontWeight.w400,
                                //                                                          ),
                                //                                                        ),
                                //                                                      ),
                                //                                                      SizedBox(height: 30.h),
                                //                                                      GetBuilder<
                                //                                                          PlanController>(
                                //                                                        builder:
                                //                                                            (planController) {
                                //                                                          return Center(
                                //                                                            child: ClipRRect(
                                //                                                              borderRadius:
                                //                                                                  BorderRadius
                                //                                                                      .circular(
                                //                                                                          32),
                                //                                                              child:
                                //                                                                  MaterialButton(
                                //                                                                    color: AppColors.appBrandColor2,
                                //                                                                height: 50.h,
                                //                                                                minWidth: double
                                //                                                                    .infinity,
                                //                                                                onPressed: () {
                                //                                                                  if (_formKey
                                //                                                                      .currentState!
                                //                                                                      .validate()) {
                                //                                                                    if (planController
                                //                                                                            .message!
                                //                                                                            .plans![
                                //                                                                                index]
                                //                                                                            .price!
                                //                                                                            .contains(
                                //                                                                                '-') &&
                                //                                                                        double.parse(planController.amountCtrl.text) <
                                //                                                                            double.parse(planController.message!.plans![index].min
                                //                                                                                .toString())) {
                                //                                                                      final snackBar =
                                //                                                                          SnackBar(
                                //                                                                        content:
                                //                                                                            Text(
                                //                                                                          "${selectedLanguageStorage.read("languageData")["Minimum deposit amount"] ?? "Minimum deposit amount"} ${planController.message!.plans![index].min}",
                                //                                                                          style: TextStyle(
                                //                                                                              color: Colors.white,
                                //                                                                              fontSize: 14.sp),
                                //                                                                        ),
                                //                                                                        backgroundColor:
                                //                                                                            Colors.red,
                                //                                                                        duration:
                                //                                                                            const Duration(seconds: 2),
                                //                                                                        behavior:
                                //                                                                            SnackBarBehavior.floating,
                                //                                                                        margin: const EdgeInsets
                                //                                                                            .all(
                                //                                                                            5),
                                //                                                                        shape:
                                //                                                                            RoundedRectangleBorder(
                                //                                                                          borderRadius:
                                //                                                                              BorderRadius.circular(8),
                                //                                                                        ),
                                //                                                                        elevation:
                                //                                                                            10,
                                //                                                                      );
                                //
                                //                                                                      ScaffoldMessenger.of(
                                //                                                                              context)
                                //                                                                          .showSnackBar(
                                //                                                                              snackBar);
                                //                                                                    } else if (planController
                                //                                                                            .message!
                                //                                                                            .plans![
                                //                                                                                index]
                                //                                                                            .price!
                                //                                                                            .contains(
                                //                                                                                '-') &&
                                //                                                                        double.parse(planController.amountCtrl.text) >
                                //                                                                            double.parse(planController.message!.plans![index].max.toString())) {
                                //                                                                      final snackBar =
                                //                                                                          SnackBar(
                                //                                                                        content:
                                //                                                                            Text(
                                //                                                                          "${selectedLanguageStorage.read("languageData")["Maximum deposit amount"] ?? "Maximum deposit amount"} ${planController.message!.plans![index].max}",
                                //                                                                          style: TextStyle(
                                //                                                                              color: Colors.white,
                                //                                                                              fontSize: 14.sp),
                                //                                                                        ),
                                //                                                                        backgroundColor:
                                //                                                                            Colors.red,
                                //                                                                        duration:
                                //                                                                            const Duration(seconds: 2),
                                //                                                                        behavior:
                                //                                                                            SnackBarBehavior.floating,
                                //                                                                        margin: const EdgeInsets
                                //                                                                            .all(
                                //                                                                            5),
                                //                                                                        shape:
                                //                                                                            RoundedRectangleBorder(
                                //                                                                          borderRadius:
                                //                                                                              BorderRadius.circular(8),
                                //                                                                        ),
                                //                                                                        elevation:
                                //                                                                            10,
                                //                                                                      );
                                //
                                //                                                                      ScaffoldMessenger.of(
                                //                                                                              context)
                                //                                                                          .showSnackBar(
                                //                                                                              snackBar);
                                //                                                                    } else {
                                //                                                                      if (selectedOption ==
                                //                                                                          "${planController.message!.balance}") {
                                //                                                                        planController
                                //                                                                            .buyPlanWallet(
                                //                                                                          "balance",
                                //                                                                          planController
                                //                                                                              .amountCtrl
                                //                                                                              .text
                                //                                                                              .toString(),
                                //                                                                          "${planController.message!.plans![index].id}",
                                //                                                                        )
                                //                                                                            .then((value) {
                                //                                                                          if (planController.apiCallStatus ==
                                //                                                                              "success") {
                                //                                                                            planController.amountCtrl.text =
                                //                                                                                '';
                                //                                                                          }
                                //                                                                        });
                                //                                                                      } else if (selectedOption ==
                                //                                                                          "${planController.message!.interestBalance}") {
                                //                                                                        planController
                                //                                                                            .buyPlanWallet(
                                //                                                                          "interest_balance",
                                //                                                                          planController
                                //                                                                              .amountCtrl
                                //                                                                              .text
                                //                                                                              .toString(),
                                //                                                                          "${planController.message!.plans![index].id}",
                                //                                                                        )
                                //                                                                            .then((value) {
                                //                                                                          if (planController.apiCallStatus ==
                                //                                                                              "success") {
                                //                                                                            planController.amountCtrl.text =
                                //                                                                                '';
                                //                                                                          }
                                //                                                                        });
                                //                                                                      } else if (selectedOption ==
                                //                                                                          "Pay Money") {
                                //                                                                        Navigator.push(
                                //                                                                            context,
                                //                                                                            MaterialPageRoute(
                                //                                                                                builder: (context) => DepositScreen(
                                //                                                                                      amount: planController.amountCtrl.text,
                                //                                                                                      planID: planController.message!.plans![index].id,
                                //                                                                                      isfixed: (!planController.message!.plans![index].price!.contains('-')),
                                //                                                                                    )));
                                //                                                                      } else {
                                //                                                                        print(
                                //                                                                            "Please select an option");
                                //                                                                        final snackBar =
                                //                                                                            SnackBar(
                                //                                                                          content:
                                //                                                                              Text(
                                //                                                                            "${selectedLanguageStorage.read("languageData")["Please select an option"] ?? "Please select an option"}",
                                //                                                                            style:
                                //                                                                                TextStyle(color: Colors.white, fontSize: 14.sp),
                                //                                                                          ),
                                //                                                                          backgroundColor:
                                //                                                                              Colors.red,
                                //                                                                          duration:
                                //                                                                              const Duration(seconds: 2),
                                //                                                                          behavior:
                                //                                                                              SnackBarBehavior.floating,
                                //                                                                          margin: const EdgeInsets
                                //                                                                              .all(
                                //                                                                              5),
                                //                                                                          shape:
                                //                                                                              RoundedRectangleBorder(
                                //                                                                            borderRadius:
                                //                                                                                BorderRadius.circular(8),
                                //                                                                          ),
                                //                                                                          elevation:
                                //                                                                              10,
                                //                                                                        );
                                //
                                //                                                                        ScaffoldMessenger.of(context)
                                //                                                                            .showSnackBar(snackBar);
                                //                                                                      }
                                //                                                                    }
                                //                                                                  }
                                //                                                                },
                                //                                                                child: planController
                                //                                                                            .isBuyPlanLoading ==
                                //                                                                        false
                                //                                                                    ? Text(
                                //                                                                        "${selectedLanguageStorage.read("languageData")["Buy Now"] ?? "Buy Now"}",
                                //                                                                        style:
                                //                                                                            TextStyle(
                                //                                                                          color:
                                //                                                                              Colors.black,
                                //                                                                          fontSize:
                                //                                                                              18.sp,
                                //                                                                          fontWeight:
                                //                                                                              FontWeight.bold,
                                //                                                                        ),
                                //                                                                      )
                                //                                                                    : const CircularProgressIndicator(
                                //                                                                        color: Colors
                                //                                                                            .white,
                                //                                                                      ),
                                //                                                              ),
                                //                                                            ),
                                //                                                          );
                                //                                                        },
                                //                                                      ),
                                //                                                    ],
                                //                                                  ),
                                //                                                ),
                                //                                              ),
                                //                                            );
                                //                                          },
                                //                                        );
                                //                                      },
                                //                                      child: Container(
                                //                                        height: 42.h,
                                //                                        width: 140.w,
                                //                                        decoration: BoxDecoration(
                                //                                            color: AppColors.appBrandColor2,
                                //                                            borderRadius:
                                //                                                BorderRadius.circular(32)),
                                //                                        child: Center(
                                //                                          child: Text(
                                //                                            "${selectedLanguageStorage.read("languageData")["Bu Now"] ?? "Bu Now"}",
                                //                                            style: GoogleFonts.niramit(
                                //                                                fontSize: 16.sp,
                                //                                                fontWeight: FontWeight.w500,
                                //                                                color: AppColors.appBlackColor,
                                //                                                height: 1),
                                //                                          ),
                                //                                        ),
                                //                                      ),
                                //                                    ),
                                //                                  ),
                              ],
                            ),
                          );
                        })
                        : SizedBox(
                      height: 600,
                      child: Center(
                        child: Text("No plans available!"),
                      ),
                    )
                        : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  num? extractNumberFromString(String input) {
    print(input);
    RegExp regExp = RegExp(r'\d+(\.\d+)?');
    Match? match = regExp.firstMatch(input);
    if (match != null) {
      return num.parse(match.group(0)!);
    }
    return null;
  }
}

class PackageSlideView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 120.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: [
        // Replace the Container widgets with your package widgets
        Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.blue,
          ),
          child: Center(
            child: Image.asset(
              'assets/images/board3.png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.green,
          ),
          child: Center(
            child: Image.asset(
              'assets/images/board2.png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Add more items as needed
      ],
    );
  }
}