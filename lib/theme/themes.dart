import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hyip_pro/utils/colors/app_colors.dart';

class Themes {

  //Light Theme
  final lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    useMaterial3: true,
    cardColor: AppColors.appWhiteColor,
    primaryColor: AppColors.appPrimaryColor,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: AppColors.appBlackColor,
        fontSize: 16.sp
      )
    ),

  );

  //Dark Theme
  final darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.appContainerBgColor,
    scaffoldBackgroundColor: AppColors.appDefaultDarkMode,
    cardColor: AppColors.appContainerBgColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.appContainerBgColor,
        titleTextStyle: TextStyle(
            color: AppColors.appWhiteColor,
            fontSize: 16.sp
        )
    ),
  );


}