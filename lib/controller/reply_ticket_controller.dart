import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_pro/controller/auth_controller.dart';
import 'package:hyip_pro/controller/ticket_list_controller.dart';
import 'package:hyip_pro/data/model/base_model/api_response.dart';
import 'package:hyip_pro/data/repository/reply_ticket_repo.dart';
import 'package:hyip_pro/view/screens/auth/login_screen.dart';
import 'package:hyip_pro/view/screens/support/support_ticket_screen.dart';
import 'package:hyip_pro/view/verify_required/mail_verification_screen.dart';
import 'package:hyip_pro/view/verify_required/sms_verification_screen.dart';
import 'package:hyip_pro/view/verify_required/two_factor_verification_screen.dart';

class ReplyTicketController extends GetxController{

  var message = TextEditingController();

  final ReplyTicketRepo replyTicketRepo;

  ReplyTicketController({required this.replyTicketRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<dynamic> ticketReplyRequest(
      BuildContext context,
      dynamic id,
      dynamic message,
      dynamic replyTicket,
      {dynamic result}) async {
    _isLoading = true;
    update();
    ApiResponse apiResponse = await replyTicketRepo.replyTicketRequest(id, message, replyTicket, result: result);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isLoading = false;
      update();
      if (apiResponse.response!.data != null) {
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
          dynamic status = apiResponse.response!.data['status'];
          dynamic msg = apiResponse.response!.data['message'];
          if(msg == "Ticket has been closed"){
            Get.snackbar(
              'Message',
              '${msg}',
              backgroundColor: status == "success" ? Colors.green : Colors.red,
              colorText: Colors.white,
              duration: Duration(seconds: 2),
              snackPosition: SnackPosition.BOTTOM,
              margin: EdgeInsets.all(10),
              borderRadius: 8,
              shouldIconPulse: true,
              icon: Icon(status == "success" ? Icons.check : Icons.cancel, color: Colors.white),
              barBlur: 10,
            );
            Get.find<TicketListController>().getTicketListData(1).then((value) {
              Navigator.pop(context);
              //Navigator.pushReplacementNamed(context, SupportTicketScreen.routeName);
            });
          }
          update();
        }
      }
    } else {
      _isLoading = false;
      update();
    }
  }


}