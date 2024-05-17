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
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                Padding(
                  padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.3),
                  child: Text(
                    "Buy Product",
                    style: GoogleFonts.publicSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: AppColors.getTextDarkLight()),
                  ),
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
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Center(
                  child: Text(
                    "Buy one and get more ",
                    style: GoogleFonts.publicSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: AppColors.getTextDarkLight()),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.34),
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
                            EdgeInsets.symmetric(horizontal: 40.w),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 45.h,
                                    ),


                                    Container(
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

                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),


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