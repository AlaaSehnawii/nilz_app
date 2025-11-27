import 'package:flutter/cupertino.dart';
import 'package:nilz_app/core/api/api_error/api_exception.dart';
import 'package:nilz_app/core/api/api_error/api_status_code.dart';
import 'package:nilz_app/core/api/api_links.dart';
import 'package:nilz_app/core/api/api_methods.dart';
import '../../../../finance/Payment/domain/entity/Payment_entity.dart';
import '../../gift/domain/entity/gift_entity.dart';

abstract class FinanceRemote {
  ///////////////////////Gift //////////////////////
  Future<GiftApiResponseEntity> getGift();

  Future<bool> deleteGift(String id);

  Future<bool> addGift({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  });

  Future<bool> editGift({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject,
  });

  ///////////////////////Payment //////////////////////
  Future<PaymentApiResponseEntity> getPayment();

  Future<bool> deletePayment(String id);

  Future<bool> addPayment({
    required String clientName,
    required String description,
    required String amount,
    required String paymentDueDate,
    required String status,
  });

  Future<bool> editPayment({
    required String id,
    String? clientName,
    String? description,
    String? amount,
    String? paymentDueDate,
    String? status,
  });
}

class FinanceRemoteImpl extends FinanceRemote {
  Future<Map<String, dynamic>> _buildPatchBody({
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject = false,
  }) async {
    final body = <String, dynamic>{};

    if (nameAr != null || nameEn != null) {
      final name = <String, dynamic>{};
      if (nameAr != null) name['ar'] = nameAr.trim();
      if (nameEn != null) name['en'] = nameEn.trim();
      if (name.isNotEmpty) body['name'] = name;
    }

    final hasImage =
        (imageName != null && imageName.isNotEmpty) &&
        (base64 != null && base64.isNotEmpty);

    if (hasImage) {
      body['image'] = {'name': imageName, 'base64': base64};
    } else if (forceEmptyImageObject) {
      body['image'] = {'name': '', 'base64': ''};
    }

    return body;
  }

  /////////////// Gift /////////////////////
  @override
  Future<GiftApiResponseEntity> getGift() async {
    final response = await ApiMethods().get(url: ApiGetUrl.getGift);
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return giftApiResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<bool> deleteGift(String id) async {
    final url = "${ApiDeleteUrl.deleteGift}$id";
    final response = await ApiMethods().delete(url: url);
    debugPrint("DELETE status: ${response.statusCode}");
    debugPrint("DELETE body: ${response.body}");
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return true;
    } else {
      throw ApiServerException(response: response);
    }
  }

  Future<Map<String, dynamic>> buildAddGiftBody({
    required String nameAr,
    required String nameEn,
    String? imageName,
    String? imageBase64,
    bool forceEmptyImageObject = false,
  }) async {
    final body = <String, dynamic>{
      "name": {"ar": nameAr.trim(), "en": nameEn.trim()},
    };

    final hasImage =
        (imageName != null && imageName.isNotEmpty) &&
        (imageBase64 != null && imageBase64.isNotEmpty);

    if (hasImage) {
      body["icon"] = {"name": imageName, "base64": imageBase64};
    } else if (forceEmptyImageObject) {
      body["icon"] = {"name": "", "base64": ""};
    }
    debugPrint("body: $body");
    return body;
  }

  @override
  Future<bool> addGift({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  }) async {
    final body = await buildAddGiftBody(
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName.isEmpty ? null : imageName,
      imageBase64: base64.isEmpty ? null : base64,
    );

    final res = await ApiMethods().post(
      url: ApiPostUrl.addGift,
      body: body,
    );

    if (res.statusCode >= 200 && res.statusCode < 300) return true;
    throw ApiServerException(response: res);
  }

  @override
  Future<bool> editGift({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject = false,
  }) async {
    final body = await _buildPatchBody(
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName,
      base64: base64,
      forceEmptyImageObject: forceEmptyImageObject,
    );

    if (body.isEmpty) return true;

    final response = await ApiMethods().patch(
      url: "${ApiPatchUrl.editGift}$id",
      body: body,
    );

    debugPrint("PATCH status: ${response.statusCode}");
    debugPrint("PATCH body: ${response.body}");

    if (ApiStatusCode.success().contains(response.statusCode)) {
      return true;
    } else {
      throw ApiServerException(response: response);
    }
  }


  /////////////// Payment /////////////////////
  @override
  Future<PaymentApiResponseEntity> getPayment() async {
    final response = await ApiMethods().get(url: ApiGetUrl.getPayment);
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return paymentApiResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<bool> deletePayment(String id) async {
    final url = "${ApiDeleteUrl.deletePayment}$id";
    final response = await ApiMethods().delete(url: url);
    debugPrint("DELETE status: ${response.statusCode}");
    debugPrint("DELETE body: ${response.body}");
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return true;
    } else {
      throw ApiServerException(response: response);
    }
  }

  Future<Map<String, dynamic>> buildAddPaymentBody({
    required String clientName,
    required String description,
    required String amount,
    required String paymentDueDate,
    required String status,
  }) async {
    final body = <String, dynamic>{
      "clientName": clientName,
      "description": description,
      "amount": amount,
      "paymentDueDate": paymentDueDate,
      "status": {
        "name": {
          "ar": "",
          "en": "",
        }
      },
    };

    debugPrint("body: $body");
    return body;
  }

  @override
  Future<bool> addPayment({
    required String clientName,
    required String description,
    required String amount,
    required String paymentDueDate,
    required String status,
  }) async {
    final body = await buildAddPaymentBody(
      clientName: clientName,
      description: description,
      amount: amount,
      paymentDueDate: paymentDueDate,
      status: status,
    );

    final res = await ApiMethods().post(
      url: ApiPostUrl.addPayment,
      body: body,
    );

    if (res.statusCode >= 200 && res.statusCode < 300) return true;
    throw ApiServerException(response: res);
  }

  @override
  Future<bool> editPayment({
    required String id,
    String? clientName,
    String? description,
    String? amount,
    String? paymentDueDate,
    String? status,
  }) async {
    final body = await _buildPatchBody(
      nameAr: clientName,
      nameEn: description,
      imageName: status,
      base64: paymentDueDate,
    );

    if (body.isEmpty) return true;

    final response = await ApiMethods().patch(
      url: "${ApiPatchUrl.editPayment}$id",
      body: body,
    );

    debugPrint("PATCH status: ${response.statusCode}");
    debugPrint("PATCH body: ${response.body}");

    if (ApiStatusCode.success().contains(response.statusCode)) {
      return true;
    } else {
      throw ApiServerException(response: response);
    }
  }
}
