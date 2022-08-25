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
// Use this when building for Windows
  static const FUSION_AUTH_DOMAIN = 'http://localhost:9011';

//Use this when building for Android
  static const FUSION_AUTH_DOMAIN = 'http://your-ip-address:9011';

  static const apiKey = 'your-API-key';

  static const applicationId = 'your-application-id';

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

//Securely Save important data such as token received from the server
      secureStorage.write(key: 'token', value: result.data['token']);
      secureStorage.write(
          key: 'tokenExpirationInstant',
          value: result.data['tokenExpirationInstant'].toString());
      secureStorage.write(
          key: 'username', value: result.data['user']['username']);

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
