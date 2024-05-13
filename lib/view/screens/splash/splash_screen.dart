import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyip_pro/controller/splash_controller.dart';
import 'package:hyip_pro/utils/colors/app_colors.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "/splashScreen";
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (splashController) {
        return Scaffold(
            body: Stack(
              children: [
              //  Image.asset("assets/images/app_icon_primary.png",width: double.infinity,fit: BoxFit.fitWidth,),
                Center(
                  child: Image.asset("assets/images/luxylion226.png",
                  ),
                ),

                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 119.h,
                    child: Center(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Luxy",
                        style: GoogleFonts.teko(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.appFillColor
                        ),
                        ),

                        Text("lion",
                          style: GoogleFonts.teko(
                              fontSize: 50.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.appBlackColor
                          ),
                        ),

                      ],
                    ))
                )

              ],
            ),
        );
      }
    );
  }
}
