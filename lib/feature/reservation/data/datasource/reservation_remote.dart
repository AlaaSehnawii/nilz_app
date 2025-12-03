import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nilz_app/core/api/api_error/api_exception.dart';
import 'package:nilz_app/core/api/api_error/api_status_code.dart';
import 'package:nilz_app/core/api/api_links.dart';
import 'package:nilz_app/core/api/api_methods.dart';
import 'package:nilz_app/feature/reservation/domain/entity/response/unit_entity.dart';
import '../../domain/entity/response/reservation_entity.dart';

abstract class ReservationRemote {
  Future<ReservationListResponseEntity> reservation();

  Future<bool> createReservation({
    required String unit,
    required String fromDate,
    required String toDate,
    int? extraBedCount,
    required String guests,
    required int age,
    required int count,
    required int roomNum,
    String? couponCode,
    required String userId,
    required bool withBreakfast,
  });

  ///////////////// Unit /////////////////

  Future<UnitEntity> getUnitDetails({
    required String unitId,
    required String toStartTimeIso,
    required String toEndTimeIso,
  });

  Future<UnitApiResponseEntity> getUnitChildren({
    required String cityId,
    required String toStartTimeIso,
    required String toEndTimeIso,
    required List<Map<String, dynamic>> roomConfig,
  });
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ReservationRemoteImpl extends ReservationRemote {
  Future<Map<String, dynamic>> buildCreateReservation({
    required String unit,
    required String fromDate,
    required String toDate,
    int? extraBedCount,
    required String guests,
    required int age,
    required int count,
    required int roomNum,
    String? couponCode,
    required String userId,
    required bool withBreakfast,
  }) async {
    final body = <String, dynamic>{
      "unit": unit,
      "fromDate": fromDate,
      "toDate": toDate,
      "extraBedCount": extraBedCount,
      "guests": {"age": age, "count": count, "roomNum": roomNum},
      "couponCode": couponCode,
      "userId": userId,
      "withBreakfast": withBreakfast,
    };
    return body;
  }

  @override
  Future<ReservationListResponseEntity> reservation() async {
    final response = await ApiMethods().get(url: ApiGetUrl.getReservation);
    debugPrint("Reservation");
    debugPrint("${response.statusCode}");
    debugPrint(response.body);
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return reservationListResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<bool> createReservation({
    required String unit,
    required String fromDate,
    required String toDate,
    int? extraBedCount,
    required String guests,
    required int age,
    required int count,
    required int roomNum,
    String? couponCode,
    required String userId,
    required bool withBreakfast,
  }) async {
    final body = await buildCreateReservation(
      unit: unit,
      fromDate: fromDate,
      toDate: toDate,
      guests: guests,
      age: age,
      count: count,
      roomNum: roomNum,
      userId: userId,
      withBreakfast: withBreakfast,
    );

    final res = await ApiMethods().post(
      url: ApiPostUrl.createReservation,
      body: body,
    );

    if (res.statusCode >= 200 && res.statusCode < 300) return true;
    throw ApiServerException(response: res);
  }

  ///////////////// Unit /////////////////

  @override
  Future<UnitEntity> getUnitDetails({
    required String unitId,
    required String toStartTimeIso,
    required String toEndTimeIso,
  }) async {
    final response = await ApiMethods().get(
      url: '${ApiGetUrl.getUnit}/$unitId',
      query: <String, dynamic>{
        'toStartTime': toStartTimeIso,
        'toEndTime': toEndTimeIso,
      },
    );

    debugPrint('getUnitDetails');
    debugPrint('${response.statusCode}');
    debugPrint(response.body);

    if (ApiStatusCode.success().contains(response.statusCode)) {
      final jsonMap = json.decode(response.body) as Map<String, dynamic>;
      return UnitEntity.fromJson(jsonMap['data']);
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<UnitApiResponseEntity> getUnitChildren({
    required String cityId,
    required String toStartTimeIso,
    required String toEndTimeIso,
    required List<Map<String, dynamic>> roomConfig,
  }) async {
    final body = <String, dynamic>{
      "toEndTime": toEndTimeIso,
      "toStartTime": toStartTimeIso,
      "city": cityId,
      "roomConfig": roomConfig,
    };

    final response = await ApiMethods().post(
      url: ApiPostUrl.getUnitChildren,
      query: <String, dynamic>{
        "skip": 0,
        "limit": 10000000000,
        "withCount": true,
      },
      body: body,
    );

    debugPrint("getUnitChildren");
    debugPrint("${response.statusCode}");
    debugPrint(response.body);

    if (ApiStatusCode.success().contains(response.statusCode)) {
      return unitApiResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }
}
