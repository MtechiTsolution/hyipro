import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_pro/controller/auth_controller.dart';
import 'package:hyip_pro/data/model/base_model/api_response.dart';
import 'package:hyip_pro/view/screens/auth/login_screen.dart';
import 'package:hyip_pro/view/screens/history/invest_history_screen.dart';
import 'package:hyip_pro/view/verify_required/mail_verification_screen.dart';
import 'package:hyip_pro/view/verify_required/sms_verification_screen.dart';
import 'package:hyip_pro/view/verify_required/two_factor_verification_screen.dart';
import '../data/model/response_model/plan_model.dart';
import '../data/repository/plan_repo.dart';
import '../view/widgets/app_plan_purchase.dart';

class PlanController extends GetxController {
  final PlanRepo planRepo;

  PlanController({required this.planRepo});

  final amountCtrl = TextEditingController();

  dynamic apiCallStatus;

  String? _status;
  String? get status => _status;
  PlanData? _message;
  PlanData? get message => _message;

  bool _isLoading = false;
  bool _isBuyPlanLoading = false;
  bool get isBuyPlanLoading => _isBuyPlanLoading;
  bool get isLoading => _isLoading;

  PlanModel planModel = PlanModel();

  /// Get Plan Data
  Future<dynamic> getPlanData() async {
    _isLoading = true;
    update();
    ApiResponse apiResponse = await planRepo.getPlanData();

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _isLoading = false;
      update();
      if (apiResponse.response!.data != null) {
        _message = null;
        update();
        if (apiResponse.response!.data != null) {
          if (apiResponse.response!.data["message"] ==
              "Email Verification Required") {
            Get.offAllNamed(MailVerificationScreen.routeName);
          } else if (apiResponse.response!.data["message"] ==
              "Mobile Verification Required") {
            Get.offAllNamed(SmsVerificationScreen.routeName);
          } else if (apiResponse.response!.data["message"] ==
              "Two FA Verification Required") {
            Get.offAllNamed(TwoFactorVerificationScreen.routeName);
          } else if (apiResponse.response!.data["message"] ==
              "Your account has been suspend") {
            Get.find<AuthController>().removeUserToken();
            await Get.offNamedUntil(LoginScreen.routeName, (route) => false);
          } else {
            planModel = PlanModel.fromJson(apiResponse.response!.data!);
            _message = planModel.message;
            update();
          }
        }
      }
    } else {
      _isLoading = false;
      update();
    }
  }

  /// Buy Plan
  Future<dynamic> buyPlanWallet(
    dynamic balanceType,
    dynamic amount,
    dynamic planId,
  ) async {
    _isBuyPlanLoading = true;
    update();
    ApiResponse apiResponse =
        await planRepo.buyInvestmentPlan(balanceType, amount, planId);

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _isBuyPlanLoading = false;
      update();
      if (apiResponse.response!.data != null) {
        if (apiResponse.response!.data != null) {
          if (apiResponse.response!.data["message"] ==
              "Email Verification Required") {
            Get.offAllNamed(MailVerificationScreen.routeName);
          } else if (apiResponse.response!.data["message"] ==
              "Mobile Verification Required") {
            Get.offAllNamed(SmsVerificationScreen.routeName);
          } else if (apiResponse.response!.data["message"] ==
              "Two FA Verification Required") {
            Get.offAllNamed(TwoFactorVerificationScreen.routeName);
          } else if (apiResponse.response!.data["message"] ==
              "Your account has been suspend") {
            Get.find<AuthController>().removeUserToken();
            await Get.offNamedUntil(LoginScreen.routeName, (route) => false);
          } else {
            apiCallStatus = apiResponse.response!.data['status'];
            dynamic msg = apiResponse.response!.data['message'];

            if (apiCallStatus == "success") {
              Get.back();
            } else {}
            Get.toNamed(InvestHistoryScreen.routeName);
            Get.snackbar(
              'Message',
              '${msg}',
              backgroundColor:
                  apiCallStatus == "success" ? Colors.green : Colors.red,
              colorText: Colors.white,
              duration: const Duration(seconds: 2),
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.all(10),
              borderRadius: 8,
              shouldIconPulse: true,
              icon: Icon(
                  apiCallStatus == "success" ? Icons.check : Icons.cancel,
                  color: Colors.white),
              barBlur: 10,
            );

            update();
          }
        }
      }
    } else {
      _isBuyPlanLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getPlanData();
    super.onInit();
  }
}
