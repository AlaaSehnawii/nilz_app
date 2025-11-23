import 'package:flutter/cupertino.dart';
import 'package:nilz_app/core/api/api_error/api_exception.dart';
import 'package:nilz_app/core/api/api_error/api_status_code.dart';
import 'package:nilz_app/core/api/api_links.dart';
import 'package:nilz_app/core/api/api_methods.dart';
import 'package:nilz_app/feature/basic_data/service/domain/entity/service_entity.dart';
import '../../reservation_type/domain/entity/Reservation_type_entity.dart';
import '../../unit_types/domain/entity/unit_type_entity.dart';
import '../../bed_types/domain/entity/bed_type_entity.dart';
import '../../city/domain/entity/city_entity.dart';
import '../../place_types/domain/entity/place_type_entity.dart';
import '../../post_category/domain/entity/post_category_entity.dart';
import '../../room_types/domain/entity/room_type_entity.dart';

abstract class BasicDataRemote {
  /////////////////////// Unit Type //////////////////////
  Future<UnitTypesApiResponseEntity> getUnitType();

  Future<bool> deleteUnitType(String id);

  Future<bool> addUnitType({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  });

  Future<bool> editUnitType({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject,
  });

  ////////////// Service //////////////////////

  Future<ServicesApiResponseEntity> getService();

  Future<bool> deleteService(String id);

  Future<bool> addService({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
    required String city,
    required bool status,
  });

  Future<bool> editService({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    String? city,
    bool? status,
    bool forceEmptyImageObject,
  });

  /////////////////// Room Type /////////////////////
  Future<RoomTypesApiResponseEntity> getRoomType();

  Future<bool> deleteRoomType(String id);

  Future<bool> addRoomType({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  });

  Future<bool> editRoomType({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject,
  });

  //////////// Place Type /////////////////////
  Future<PlaceTypesApiResponseEntity> getPlaceType();

  Future<bool> deletePlaceType(String id);

  Future<bool> addPlaceType({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  });

  Future<bool> editPlaceType({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject,
  });

  Future<CitiesApiResponseEntity> getCity();

  Future<bool> deleteCity(String id);

  Future<bool> addCity({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  });

  Future<bool> editCity({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject,
  });

  /////////////////// Bed Type /////////////////////
  Future<BedTypesApiResponseEntity> getBedType();

  Future<bool> deleteBedType(String id);

  Future<bool> addBedType({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  });

  Future<bool> editBedType({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject,
  });

  /////////////// Post Category ////////////////
  Future<PostCategoryResponseEntity> getPostCategory();

  Future<bool> deletePostCategory(String id);

  Future<bool> addPostCategory({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
    required bool status,
  });

  Future<bool> editPostCategory({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool? status,
    bool forceEmptyImageObject,
  });

  ///////////////// Reservation Type ///////////////////////
  Future<ReservationTypesApiResponseEntity> getReservationType();

  Future<bool> deleteReservationType(String id);

  Future<bool> addReservationType({
    required String nameAr,
    required String nameEn,
  });

  Future<bool> editReservationType({
    required String id,
    String? nameAr,
    String? nameEn,
  });
}


/////////////////////////////////////////////////////////////////////////////////////////////////////


class BasicDataRemoteImpl extends BasicDataRemote {
  Future<Map<String, dynamic>> _buildPatchBody({
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    String? city,
    bool forceEmptyImageObject = false,
    bool? status,
    bool useImageField = false,
    String nameField = 'name',
  }) async {
    final body = <String, dynamic>{};

    if (nameAr != null || nameEn != null) {
      final name = <String, dynamic>{};
      if (nameAr != null) name['ar'] = nameAr.trim();
      if (nameEn != null) name['en'] = nameEn.trim();
      if (name.isNotEmpty) body[nameField] = name;
    }
    if (status != null) {
      body['status'] = status;
    }
    if (city != null) {
      body['city'] = city;
    }
    final imageKey = useImageField ? 'image' : 'icon';

    final hasImage =
        (imageName != null && imageName.isNotEmpty) &&
        (base64 != null && base64.isNotEmpty);

    if (hasImage) {
      body[imageKey] = {'name': imageName, 'base64': base64};
    } else if (forceEmptyImageObject) {
      body[imageKey] = {'name': '', 'base64': ''};
    }

    return body;
  }

  /////////////// Unit Type /////////////////////
  @override
  Future<UnitTypesApiResponseEntity> getUnitType() async {
    final response = await ApiMethods().get(url: ApiGetUrl.getUnitType);
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return unitTypesApiResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<bool> deleteUnitType(String id) async {
    final url = "${ApiDeleteUrl.deleteUnitType}$id";
    final response = await ApiMethods().delete(url: url);
    debugPrint("DELETE status: ${response.statusCode}");
    debugPrint("DELETE body: ${response.body}");
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return true;
    } else {
      throw ApiServerException(response: response);
    }
  }

  Future<Map<String, dynamic>> buildAddUnitTypeBody({
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
  Future<bool> addUnitType({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  }) async {
    final body = await buildAddUnitTypeBody(
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName.isEmpty ? null : imageName,
      imageBase64: base64.isEmpty ? null : base64,
    );

    final res = await ApiMethods().post(
      url: ApiPostUrl.addUnitType,
      body: body,
    );

    if (res.statusCode >= 200 && res.statusCode < 300) return true;
    throw ApiServerException(response: res);
  }

  @override
  Future<bool> editUnitType({
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
      useImageField: false,
      forceEmptyImageObject: forceEmptyImageObject,
    );

    if (body.isEmpty) return true;

    final response = await ApiMethods().patch(
      url: "${ApiPatchUrl.editUnitType}$id",
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

  ////////////// Service //////////////////////
  @override
  Future<ServicesApiResponseEntity> getService() async {
    final response = await ApiMethods().get(url: ApiGetUrl.getService);
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return servicesApiResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<bool> deleteService(String id) async {
    final url = "${ApiDeleteUrl.deleteService}$id";
    final response = await ApiMethods().delete(url: url);
    debugPrint("DELETE status: ${response.statusCode}");
    debugPrint("DELETE body: ${response.body}");
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return true;
    } else {
      throw ApiServerException(response: response);
    }
  }

  Future<Map<String, dynamic>> buildAddServiceBody({
    required String nameAr,
    required String nameEn,
    String? imageName,
    String? imageBase64,
    String? city,
    required bool status,
    bool forceEmptyImageObject = false,
  }) async {
    final body = <String, dynamic>{
      "title": {"ar": nameAr.trim(), "en": nameEn.trim()},
      "city": city,
      "status": status,
    };
    debugPrint("body: $body");
    final hasImage =
        (imageName != null && imageName.isNotEmpty) &&
        (imageBase64 != null && imageBase64.isNotEmpty);

    if (hasImage) {
      body["image"] = {"name": imageName, "base64": imageBase64};
    } else if (forceEmptyImageObject) {
      body["image"] = {"name": "", "base64": ""};
    }

    return body;
  }

  @override
  Future<bool> addService({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
    required String city,
    required bool status,
  }) async {
    final body = await buildAddServiceBody(
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName.isEmpty ? null : imageName,
      imageBase64: base64.isEmpty ? null : base64,
      city: city,
      status: status,
    );

    final res = await ApiMethods().post(url: ApiPostUrl.addService, body: body);

    if (res.statusCode >= 200 && res.statusCode < 300) return true;
    throw ApiServerException(response: res);
  }

  @override
  Future<bool> editService({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    String? city,
    bool? status,
    bool forceEmptyImageObject = false,
  }) async {
    final body = await _buildPatchBody(
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName,
      base64: base64,
      city: city,
      status: status,
      useImageField: true,
      forceEmptyImageObject: forceEmptyImageObject,
      nameField: 'title',
    );

    if (body.isEmpty) return true;

    final response = await ApiMethods().patch(
      url: "${ApiPatchUrl.editService}$id",
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

  ////////////// Room Type //////////////////////
  @override
  Future<RoomTypesApiResponseEntity> getRoomType() async {
    final response = await ApiMethods().get(url: ApiGetUrl.getRoomType);
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return roomTypesApiResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<bool> deleteRoomType(String id) async {
    final url = "${ApiDeleteUrl.deleteRoomType}$id";
    final response = await ApiMethods().delete(url: url);
    debugPrint("DELETE status: ${response.statusCode}");
    debugPrint("DELETE body: ${response.body}");
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return true;
    } else {
      throw ApiServerException(response: response);
    }
  }

  Future<Map<String, dynamic>> buildAddRoomTypeBody({
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

    return body;
  }

  @override
  Future<bool> addRoomType({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  }) async {
    final body = await buildAddRoomTypeBody(
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName.isEmpty ? null : imageName,
      imageBase64: base64.isEmpty ? null : base64,
    );

    final res = await ApiMethods().post(
      url: ApiPostUrl.addRoomType,
      body: body,
    );

    if (res.statusCode >= 200 && res.statusCode < 300) return true;
    throw ApiServerException(response: res);
  }

  @override
  Future<bool> editRoomType({
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
      url: "${ApiPatchUrl.editRoomType}$id",
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

  /////////////////// Place Type ///////////////////
  @override
  Future<PlaceTypesApiResponseEntity> getPlaceType() async {
    final response = await ApiMethods().get(url: ApiGetUrl.getPlaceType);
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return placeTypesApiResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<bool> deletePlaceType(String id) async {
    final url = "${ApiDeleteUrl.deletePlaceType}$id";
    final response = await ApiMethods().delete(url: url);
    debugPrint("DELETE status: ${response.statusCode}");
    debugPrint("DELETE body: ${response.body}");
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return true;
    } else {
      throw ApiServerException(response: response);
    }
  }

  Future<Map<String, dynamic>> buildAddPlaceTypeBody({
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
  Future<bool> addPlaceType({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  }) async {
    final body = await buildAddPlaceTypeBody(
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName.isEmpty ? null : imageName,
      imageBase64: base64.isEmpty ? null : base64,
    );

    final res = await ApiMethods().post(
      url: ApiPostUrl.addPlaceType,
      body: body,
    );

    if (res.statusCode >= 200 && res.statusCode < 300) return true;
    throw ApiServerException(response: res);
  }

  @override
  Future<bool> editPlaceType({
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
      url: "${ApiPatchUrl.editPlaceType}$id",
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

  //////////////////// City //////////////////////
  @override
  Future<CitiesApiResponseEntity> getCity() async {
    final response = await ApiMethods().get(url: ApiGetUrl.getCity);
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return citiesApiResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<bool> deleteCity(String id) async {
    final url = "${ApiDeleteUrl.deleteCity}$id";
    final response = await ApiMethods().delete(url: url);
    debugPrint("DELETE status: ${response.statusCode}");
    debugPrint("DELETE body: ${response.body}");
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return true;
    } else {
      throw ApiServerException(response: response);
    }
  }

  Future<Map<String, dynamic>> buildAddCityBody({
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
      body["image"] = {"name": imageName, "base64": imageBase64};
    } else if (forceEmptyImageObject) {
      body["image"] = {"name": "", "base64": ""};
    }
    debugPrint("body: $body");
    debugPrint("test");
    return body;
  }

  @override
  Future<bool> addCity({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  }) async {
    final body = await buildAddCityBody(
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName.isEmpty ? null : imageName,
      imageBase64: base64.isEmpty ? null : base64,
    );

    final res = await ApiMethods().post(url: ApiPostUrl.addCity, body: body);

    if (res.statusCode >= 200 && res.statusCode < 300) return true;
    throw ApiServerException(response: res);
  }

  @override
  Future<bool> editCity({
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
      useImageField: true,
      forceEmptyImageObject: forceEmptyImageObject,
    );

    if (body.isEmpty) return true;

    final response = await ApiMethods().patch(
      url: "${ApiPatchUrl.editCity}$id",
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

  //////////////// Bed Type ///////////////////
  @override
  Future<BedTypesApiResponseEntity> getBedType() async {
    final response = await ApiMethods().get(url: ApiGetUrl.getBedType);
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return bedTypesApiResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<bool> deleteBedType(String id) async {
    final url = "${ApiDeleteUrl.deleteBedType}$id";
    final response = await ApiMethods().delete(url: url);
    debugPrint("DELETE status: ${response.statusCode}");
    debugPrint("DELETE body: ${response.body}");
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return true;
    } else {
      throw ApiServerException(response: response);
    }
  }

  Future<Map<String, dynamic>> buildAddBedTypeBody({
    // request entity todo alaa
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

    return body;
  }

  @override
  Future<bool> addBedType({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  }) async {
    final body = await buildAddBedTypeBody(
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName.isEmpty ? null : imageName,
      imageBase64: base64.isEmpty ? null : base64,
    );

    final res = await ApiMethods().post(url: ApiPostUrl.addBedType, body: body);

    if (res.statusCode >= 200 && res.statusCode < 300) return true;
    throw ApiServerException(response: res);
  }

  @override
  Future<bool> editBedType({
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
      url: "${ApiPatchUrl.editBedType}$id",
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

  ///////////////////// Post Category //////////////////////////////
  @override
  Future<PostCategoryResponseEntity> getPostCategory() async {
    final response = await ApiMethods().get(url: ApiGetUrl.getPostCategory);
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return postCategoryResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<bool> deletePostCategory(String id) async {
    final url = "${ApiDeleteUrl.deletePostCategory}$id";
    final response = await ApiMethods().delete(url: url);
    debugPrint("DELETE status: ${response.statusCode}");
    debugPrint("DELETE body: ${response.body}");
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return true;
    } else {
      throw ApiServerException(response: response);
    }
  }

  Future<Map<String, dynamic>> buildAddPostCategoryBody({
    required String nameAr,
    required String nameEn,
    String? imageName,
    String? imageBase64,
    bool? status,
    bool forceEmptyImageObject = false,
  }) async {
    final body = <String, dynamic>{
      "name": {"ar": nameAr.trim(), "en": nameEn.trim()},
      "status": status,
    };

    final hasImage =
        (imageName != null && imageName.isNotEmpty) &&
        (imageBase64 != null && imageBase64.isNotEmpty);

    if (hasImage) {
      body["image"] = {"name": imageName, "base64": imageBase64};
    } else if (forceEmptyImageObject) {
      body["image"] = {"name": "", "base64": ""};
    }
    debugPrint("add body : $body");

    return body;
  }

  @override
  Future<bool> addPostCategory({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
    required bool status,
  }) async {
    final body = await buildAddPostCategoryBody(
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName.isEmpty ? null : imageName,
      imageBase64: base64.isEmpty ? null : base64,
      status: status,
    );

    final res = await ApiMethods().post(
      url: ApiPostUrl.addPostCategory,
      body: body,
    );

    if (res.statusCode >= 200 && res.statusCode < 300) return true;
    throw ApiServerException(response: res);
  }

  @override
  Future<bool> editPostCategory({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool? status,
    bool forceEmptyImageObject = false,
  }) async {
    final body = await _buildPatchBody(
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName,
      base64: base64,
      status: status,
      useImageField: true,
      forceEmptyImageObject: forceEmptyImageObject,
    );

    if (body.isEmpty) return true;

    final response = await ApiMethods().patch(
      url: "${ApiPatchUrl.editPostCategory}$id",
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

  //////////////////// Reservation Type ///////////////////////////
  @override
  Future<ReservationTypesApiResponseEntity> getReservationType() async {
    final response = await ApiMethods().get(url: ApiGetUrl.getReservationType);
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return reservationTypesApiResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<bool> deleteReservationType(String id) async {
    final url = "${ApiDeleteUrl.deleteReservationType}$id";
    final response = await ApiMethods().delete(url: url);
    debugPrint("DELETE status: ${response.statusCode}");
    debugPrint("DELETE body: ${response.body}");
    if (ApiStatusCode.success().contains(response.statusCode)) {
      return true;
    } else {
      throw ApiServerException(response: response);
    }
  }

  Future<Map<String, dynamic>> buildAddReservationTypeBody({
    required String nameAr,
    required String nameEn,
  }) async {
    final body = <String, dynamic>{
      "name": {"ar": nameAr.trim(), "en": nameEn.trim()},
    };

    return body;
  }

  @override
  Future<bool> addReservationType({
    required String nameAr,
    required String nameEn,
  }) async {
    final body = await buildAddReservationTypeBody(
      nameAr: nameAr,
      nameEn: nameEn,
    );

    final res = await ApiMethods().post(
      url: ApiPostUrl.addReservationType,
      body: body,
    );

    if (res.statusCode >= 200 && res.statusCode < 300) return true;
    throw ApiServerException(response: res);
  }

  @override
  Future<bool> editReservationType({
    required String id,
    String? nameAr,
    String? nameEn,
  }) async {
    final body = await _buildPatchBody(nameAr: nameAr, nameEn: nameEn);

    if (body.isEmpty) return true;

    final response = await ApiMethods().patch(
      url: "${ApiPatchUrl.editReservationType}$id",
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
