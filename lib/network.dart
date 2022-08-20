import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage secureStorage = FlutterSecureStorage();

class ApiResponse {
  bool success;
  String? errorMessage;
  ApiResponse({required this.success, this.errorMessage});
}

class NetworkApi {
//  static const FUSION_AUTH_DOMAIN = 'http://localhost:9011';
static const FUSION_AUTH_DOMAIN = 'http://192.168.2.104:9011';
  static const apiKey =
      'sRpEDRlevtyAt-ZNBZzy8nojvxwheAiX5MqioOtoMQINcIT4btdVmULE';
  static const applicationId = '88f07435-b415-4041-b114-8f0a5cb88a05';
  static final dio = Dio();

  static Future<ApiResponse> login(String username, String password) async {
    try {
      var result = await dio.post(
        '$FUSION_AUTH_DOMAIN/api/login',
        data: jsonEncode({
          "applicationId": applicationId,
          'loginId': username,
          'password': password,
        }),
        options: Options(headers: <String, String>{'Authorization': apiKey}),
      );
      print(result.data);
      secureStorage.write(key: 'token', value: result.data['token']);
      secureStorage.write(
          key: 'tokenExpirationInstant',
          value: result.data['tokenExpirationInstant'].toString());
      secureStorage.write(
          key: 'username', value: result.data['user']['username']);
      return ApiResponse(success: true);
    } on DioError catch (e) {
      print(e);
      return ApiResponse(success: false, errorMessage: "An Error occured");
    } catch (e) {
      print(e);
      return ApiResponse(success: false, errorMessage: 'An Error Occurred');
    }
  }

  static Future<ApiResponse> register(String username, String password) async {
    try {
      var result = await dio.post(
        '$FUSION_AUTH_DOMAIN/api/user/registration/',
        data: jsonEncode({
          "registration": {
            "applicationId": applicationId,
            "roles": [
              "gamer",
            ],
          },
          "user": {
            'username': username,
            'password': password,
          },
        }),
        options: Options(headers: <String, String>{'Authorization': apiKey}),
      );
      return ApiResponse(success: true);
    } on DioError catch (e) {
      print(e);
      print(e.response);
      return ApiResponse(success: false, errorMessage: "An Error occured");
    } catch (e) {
      print(e);
      return ApiResponse(success: false, errorMessage: 'An Error Occurred');
    }
  }
}
