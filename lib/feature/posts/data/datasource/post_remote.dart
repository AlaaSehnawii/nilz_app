import 'package:flutter/material.dart';
import 'package:nilz_app/core/api/api_error/api_exception.dart';
import 'package:nilz_app/core/api/api_error/api_status_code.dart';
import 'package:nilz_app/core/api/api_links.dart';
import 'package:nilz_app/core/api/api_methods.dart';
import '../../domain/entity/response/post_entity.dart';

abstract class PostRemote {
  Future<PostsApiResponseEntity> post();

  Future<bool> createPost({
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
}

class PostRemoteImpl extends PostRemote {
  Future<Map<String, dynamic>> buildCreatePost({
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
  Future<PostsApiResponseEntity> post() async {
    final response = await ApiMethods().get(url: ApiGetUrl.getPost);
    debugPrint("Post");
    debugPrint("${response.statusCode}");
    debugPrint(response.body);
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return postsApiResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<bool> createPost({
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
    final body = await buildCreatePost(
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

    final res = await ApiMethods().post(url: ApiPostUrl.addPost, body: body);

    if (res.statusCode >= 200 && res.statusCode < 300) return true;
    throw ApiServerException(response: res);
  }
}
