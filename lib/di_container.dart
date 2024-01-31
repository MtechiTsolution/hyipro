
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hyip_pro/controller/app_config_controller.dart';
import 'package:hyip_pro/controller/app_steps_controller.dart';
import 'package:hyip_pro/controller/auth_controller.dart';
import 'package:hyip_pro/controller/badges_controller.dart';
import 'package:hyip_pro/controller/bottom_navbar_controller.dart';
import 'package:hyip_pro/controller/chnage_password_controller.dart';
import 'package:hyip_pro/controller/create_ticket_controller.dart';
import 'package:hyip_pro/controller/dashboard_controller.dart';
import 'package:hyip_pro/controller/deposit_controller.dart';
import 'package:hyip_pro/controller/deposit_history_controller.dart';
import 'package:hyip_pro/controller/invest_history_controller.dart';
import 'package:hyip_pro/controller/language_controller.dart';
import 'package:hyip_pro/controller/my_account_controller.dart';
import 'package:hyip_pro/controller/network_controller.dart';
import 'package:hyip_pro/controller/payment_done_controller.dart';
import 'package:hyip_pro/controller/payout_controller.dart';
import 'package:hyip_pro/controller/payout_history_controller.dart';
import 'package:hyip_pro/controller/plan_controller.dart';
import 'package:hyip_pro/controller/pusher_config_controller.dart';
import 'package:hyip_pro/controller/referral_bonus_controller.dart';
import 'package:hyip_pro/controller/referral_controller.dart';
import 'package:hyip_pro/controller/reply_ticket_controller.dart';
import 'package:hyip_pro/controller/resend_code_controller.dart';
import 'package:hyip_pro/controller/securion_authorizepay_controller.dart';
import 'package:hyip_pro/controller/splash_controller.dart';
import 'package:hyip_pro/controller/ticket_file_download_controller.dart';
import 'package:hyip_pro/controller/ticket_list_controller.dart';
import 'package:hyip_pro/controller/transaction_history_controller.dart';
import 'package:hyip_pro/controller/transfer_controller.dart';
import 'package:hyip_pro/controller/two_factor_controller.dart';
import 'package:hyip_pro/controller/verification_controller.dart';
import 'package:hyip_pro/controller/verify_required_controller.dart';
import 'package:hyip_pro/controller/view_ticket_controller.dart';
import 'package:hyip_pro/data/repository/app_steps_repo.dart';
import 'package:hyip_pro/data/repository/auth_repo.dart';
import 'package:hyip_pro/data/repository/badges_repo.dart';
import 'package:hyip_pro/data/repository/change_password_repo.dart';
import 'package:hyip_pro/data/repository/create_ticket_repo.dart';
import 'package:hyip_pro/data/repository/dashboard_repo.dart';
import 'package:hyip_pro/data/repository/deposit_history_repo.dart';
import 'package:hyip_pro/data/repository/deposit_repo.dart';
import 'package:hyip_pro/data/repository/invest_history_repo.dart';
import 'package:hyip_pro/data/repository/language_repo.dart';
import 'package:hyip_pro/data/repository/my_account_repo.dart';
import 'package:hyip_pro/controller/notification_controller.dart';
import 'package:hyip_pro/data/repository/payment_done_repo.dart';
import 'package:hyip_pro/data/repository/payout_history_repo.dart';
import 'package:hyip_pro/data/repository/payout_repo.dart';
import 'package:hyip_pro/data/repository/plan_repo.dart';
import 'package:hyip_pro/data/repository/pusher_config_repo.dart';
import 'package:hyip_pro/data/repository/referral_bonus_repo.dart';
import 'package:hyip_pro/data/repository/referral_repo.dart';
import 'package:hyip_pro/data/repository/reply_ticket_repo.dart';
import 'package:hyip_pro/data/repository/resend_code_repo.dart';
import 'package:hyip_pro/data/repository/securion_authorizepay_repo.dart';
import 'package:hyip_pro/data/repository/ticket_file_download_repo.dart';
import 'package:hyip_pro/data/repository/ticket_list_repo.dart';
import 'package:hyip_pro/data/repository/transaction_history_repo.dart';
import 'package:hyip_pro/data/repository/transfer_repo.dart';
import 'package:hyip_pro/data/repository/two_factor_repo.dart';
import 'package:hyip_pro/data/repository/verification_repo.dart';
import 'package:hyip_pro/data/repository/verify_required_repo.dart';
import 'package:hyip_pro/data/repository/view_ticket_repo.dart';
import 'package:hyip_pro/theme/theme_service.dart';
import 'package:hyip_pro/utils/strings/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/locale_controller.dart';
import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'data/repository/app_config_repo.dart';


final sl = GetIt.instance;

Future<void> init() async {
  /// Core
  sl.registerLazySingleton(() => DioClient(AppConstants.baseUri, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  ///Repository
  sl.registerLazySingleton(() => AuthRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => TransferRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => DashBoardRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => BadgesRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => ReferralRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => ReferralBonusRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => InvestHistoryRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => TransactionHistoryRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => DepositHistoryRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => PayoutHistoryRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => ViewTicketRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => TicketListRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => ReplyTicketRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => CreateTicketRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => ChangePasswordRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => TwoFaSecurityRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => PlanRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => MyAccountRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => VerificationRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => PayoutRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => PusherConfigRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => DepositRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => PaymentDoneRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => SecurionPayAuthorizenetRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => LanguageRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => VerifyRequiredRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => AppConfigRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => AppStepsRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => TicketFileDownloadRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => ResendCodeRepo(dioClient: sl(), sharedPreferences: sl()));


  /// Controller
  Get.lazyPut(() => SplashController(), fenix: true);
  Get.lazyPut(() => AuthController(authRepo: sl(), dioClient: sl()), fenix: true);
  Get.lazyPut(() => BottomNavController(), fenix: true);
  Get.put<NetworkController>(NetworkController(),permanent:true);


  Get.lazyPut(() => TransferScreenController(transferRepo: sl()), fenix: true);
  Get.lazyPut(() => DashBoardController(dashBoardRepo: sl()), fenix: true);
  Get.lazyPut(() => BadgesController(badgesRepo: sl()), fenix: true);
  Get.lazyPut(() => ReferralController(referralRepo: sl()), fenix: true);
  Get.lazyPut(() => ReferralBonusController(referralBonusSearchRepo: sl()), fenix: true);
  Get.lazyPut(() => InvestHistoryController(investHistoryRepo: sl()), fenix: true);
  Get.lazyPut(() => TransactionHistoryController(transactionHistoryRepo: sl()), fenix: true);
  Get.lazyPut(() => DepositHistoryController(depositHistoryRepo: sl()), fenix: true);
  Get.lazyPut(() => PayoutHistoryController(payoutHistoryRepo: sl()), fenix: true);
  Get.lazyPut(() => ViewTicketController(viewTicketRepo: sl()), fenix: true);
  Get.lazyPut(() => TicketListController(ticketListRepo: sl()), fenix: true);
  Get.lazyPut(() => ReplyTicketController(replyTicketRepo: sl()), fenix: true);
  Get.lazyPut(() => CreateTicketController(createTicketRepo: sl()), fenix: true);
  Get.lazyPut(() => ChangePasswordController(changePasswordRepo: sl()), fenix: true);
  Get.lazyPut(() => TwoFaSecurityController(twoFaSecurityRepo: sl()), fenix: true);
  Get.lazyPut(() => TicketFileDownloadController(ticketFileDownloadRepo: sl()), fenix: true);
  Get.lazyPut(() => PlanController(planRepo: sl()), fenix: true);
  Get.lazyPut(() => MyAccountController(myAccountRepo: sl()), fenix: true);
  Get.lazyPut(() => VerificationController(verificationRepo: sl()), fenix: true);
  Get.lazyPut(() => PayoutController(payoutRepo: sl()), fenix: true);
  Get.lazyPut(() => PusherConfigController(pusherConfigRepo: sl()), fenix: true);
  Get.lazyPut(() => DepositController(depositScreenRepo: sl()), fenix: true);
  Get.lazyPut(() => PaymentDoneController(paymentDoneRepo: sl()), fenix: true);
  Get.lazyPut(() => SecurionPayAuthorizenetController(securionPayAuthorizenetRepo: sl()), fenix: true);
  Get.lazyPut(() => LanguageController(languageRepo: sl()), fenix: true);
  Get.lazyPut(() => VerifyRequiredController(verifyRequiredRepo: sl()), fenix: true);
  Get.lazyPut(() => AppConfigController(appConfigRepo: sl()), fenix: true);
  Get.lazyPut(() => AppStepsController(appStepsRepo: sl()), fenix: true);
  Get.lazyPut(() => ResendCodeController(resendCodeRepo: sl()), fenix: true);
  Get.lazyPut(() => NotificationController(), fenix: true);
  Get.lazyPut(() => LocaleController(), fenix: true);
  Get.lazyPut(() => ThemeService(), fenix: true);


  /// External pocket lock
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}