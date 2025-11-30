import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../../../../../core/api/api_error/api_exception.dart';
import '../../../../../../core/api/api_error/api_status_code.dart';
import '../../../../../../core/api/api_links.dart';
import '../../../../../../core/api/api_methods.dart';
import '../../../../../../core/storage/shared/shared_pref.dart';
import '../../../domain/entity/request/login_request_entity.dart';
import '../../../domain/entity/response/login_response_entity.dart';

abstract class AuthRemote {
  Future<LoginApiResponseEntity> login({required LoginRequestEntity entity});

  Future<void> logout();
}

class AuthRemoteImpl extends AuthRemote {
  @override
  Future<LoginApiResponseEntity> login({
    required LoginRequestEntity entity,
  }) async {
    final response = await ApiMethods().post(
      url: ApiPostUrl.login,
      body: entity.toJson(),
    );
    debugPrint("login");
    debugPrint('📤 Email: ${entity.email}');
    debugPrint('📤 Password: ${entity.password}');
    debugPrint('📤 Full Body: ${jsonEncode(entity.toJson())}');
    debugPrint('${response.statusCode}');
    debugPrint('${response.body} bb');
    debugPrint('object');
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return loginApiResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<void> logout() async {
    AppSharedPreferences.getToken();

    final response = await ApiMethods().post(
      url: ApiPostUrl.logout,
      body: {},
    );

    if (!ApiStatusCode.success().contains(response.statusCode)) {
      throw ApiServerException(response: response);
    }
  }
}
