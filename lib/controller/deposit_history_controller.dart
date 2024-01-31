import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_pro/controller/auth_controller.dart';
import 'package:hyip_pro/data/model/base_model/api_response.dart';
import 'package:hyip_pro/data/model/response_model/deposit_history_search_model.dart';
import 'package:hyip_pro/data/repository/deposit_history_repo.dart';
import 'package:hyip_pro/view/screens/auth/login_screen.dart';
import 'package:hyip_pro/view/verify_required/mail_verification_screen.dart';
import 'package:hyip_pro/view/verify_required/two_factor_verification_screen.dart';

import '../view/verify_required/sms_verification_screen.dart';

class DepositHistoryController extends GetxController{

  final DepositHistoryRepo depositHistoryRepo;

  DepositHistoryController({required this.depositHistoryRepo});

  var isWidgetVisible = false.obs;
  final name = TextEditingController();

  var selectedOption = 'All Payment'.obs;

  onDropdownChanged(String value) {
    selectedOption.value = value;
  }

  var selectedDate = ''.obs;

  void setDate(String date) {
    selectedDate.value = date;
    update();
  }

  void toggleWidgetVisibility() {
    isWidgetVisible.value = !isWidgetVisible.value;
    update();
  }


  Rx<int> page = 1.obs;

  final scrollController = ScrollController();

  double _currentScrollOffset = 0;


  List<Data> depositHistorySearchItems = []; // List to store all fetched items

  void resetPage() {
    page.value = 1;
    _message = null;
    depositHistorySearchItems.clear();
    update();
  }

  void pageCounter() {
    page.value++;
    update();
  }



  String? _status;
  DepositHistorySearchData? _message;
  bool _isLoading = false;

  String? get status => _status;
  DepositHistorySearchData? get message => _message;
  bool get isLoading => _isLoading;


  DepositHistorySearchModel depositHistorySearchModel = DepositHistorySearchModel();

  Future<dynamic> getDepositHistorySearchData(
      dynamic name,
      dynamic createdAt,
      dynamic status,
      {dynamic page}) async {
    _isLoading = true;
    if(page==1){
      depositHistorySearchItems = [];
    }
    update();
    ApiResponse apiResponse = await depositHistoryRepo.searchRequestDepositHistory(name,createdAt,status,page: page);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isLoading = false;
      update();
      if (apiResponse.response!.data != null) {
        _message=null;
        update();
        if(apiResponse.response!.data["message"]=="Email Verification Required"){
          Get.offAllNamed(MailVerificationScreen.routeName);
        }
        else if(apiResponse.response!.data["message"]=="Mobile Verification Required"){
          Get.offAllNamed(SmsVerificationScreen.routeName);
        }
        else if(apiResponse.response!.data["message"]=="Two FA Verification Required"){
          Get.offAllNamed(TwoFactorVerificationScreen.routeName);
        }
        else if(apiResponse.response!.data["message"]=="Your account has been suspend"){
          Get.find<AuthController>().removeUserToken();
          await Get.offNamedUntil(LoginScreen.routeName, (route) => false);
        }
        else{
          depositHistorySearchModel = DepositHistorySearchModel.fromJson(apiResponse.response!.data!);
          _message = depositHistorySearchModel.message;

          if (_message != null) {
            depositHistorySearchItems.addAll(_message!.data!);
            update();
          }
          update();
        }

      }
    } else {
      _isLoading = false;
      update();
    }
  }


  @override
  void onInit() {
    super.onInit();

    resetPage();
    getDepositHistorySearchData("","","",page :page.value.toString());
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final data = message?.data;
    final isLoading = this.isLoading;

    if (!isLoading &&
        data!.length >= 10 &&
        scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      _currentScrollOffset = scrollController.position.pixels; // Save the current scroll offset
      pageCounter();
      final page = this.page;
      getDepositHistorySearchData("","","",page:page.value.toString());
      print("scrolling");
    }
  }


  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }



}