import 'package:dio/dio.dart';
import 'package:hyip_pro/utils/strings/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base_model/api_response.dart';

class VerifyRequiredRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  VerifyRequiredRepo({required this.dioClient, required this.sharedPreferences});

  twoFactorSubmitRepo(dynamic code) async {
    try {
      Response response = await dioClient.post(
        "${AppConstants.twoFactorVerifyUri}",
        queryParameters: {
          "code" : code,
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization":
          "Bearer ${ sharedPreferences.getString(AppConstants.token)}",
        }),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  mailVerifySubmitRepo(dynamic code) async {
    try {
      Response response = await dioClient.post(
        "${AppConstants.mailVerifyUri}",
        queryParameters: {
          "code" : code,
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization":
          "Bearer ${ sharedPreferences.getString(AppConstants.token)}",
        }),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  smsVerifySubmitRepo(dynamic code) async {
    try {
      Response response = await dioClient.post(
        "${AppConstants.smsVerifyUri}",
        queryParameters: {
          "code" : code,
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization":
          "Bearer ${ sharedPreferences.getString(AppConstants.token)}",
        }),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}