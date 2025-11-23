import 'package:dartz/dartz.dart';
import 'package:nilz_app/feature/basic_data/service/domain/entity/service_entity.dart';
import '../../../../core/api/api_error/api_failures.dart';
import '../../reservation_type/domain/entity/Reservation_type_entity.dart';
import '../../unit_types/domain/entity/unit_type_entity.dart';
import '../../bed_types/domain/entity/bed_type_entity.dart';
import '../../city/domain/entity/city_entity.dart';
import '../../place_types/domain/entity/place_type_entity.dart';
import '../../post_category/domain/entity/post_category_entity.dart';
import '../../room_types/domain/entity/room_type_entity.dart';

abstract class BasicDataRepository {
  ////////////// Room Type //////////////////////////////
  Future<Either<ApiFailure, RoomTypesApiResponseEntity>> getRoomType();

  Future<Either<ApiFailure, bool>> deleteRoomType(String id);

  Future<Either<ApiFailure, bool>> addRoomType({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  });

  Future<Either<ApiFailure, bool>> editRoomType({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject,
  });

  ///////////////////// Unit Type  /////////////////////////////
  Future<Either<ApiFailure, UnitTypesApiResponseEntity>> getUnitType();

  Future<Either<ApiFailure, bool>> deleteUnitType(String id);

  Future<Either<ApiFailure, bool>> addUnitType({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  });

  Future<Either<ApiFailure, bool>> editUnitType({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject,
  });

  ///////////////////// Service Type  /////////////////////////////
  Future<Either<ApiFailure, ServicesApiResponseEntity>> getService();

  Future<Either<ApiFailure, bool>> deleteService(String id);

  Future<Either<ApiFailure, bool>> addService({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
    required String city,
    required bool status,
  });

  Future<Either<ApiFailure, bool>> editService({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    String? city,
    bool? status,
    bool forceEmptyImageObject,
  });

  /////////////////////// Place Type ////////////////////////
  Future<Either<ApiFailure, PlaceTypesApiResponseEntity>> getPlaceType();

  Future<Either<ApiFailure, bool>> deletePlaceType(String id);

  Future<Either<ApiFailure, bool>> addPlaceType({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  });

  Future<Either<ApiFailure, bool>> editPlaceType({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject,
  });

  ///////////////////// City ///////////////////////
  Future<Either<ApiFailure, CitiesApiResponseEntity>> getCity();

  Future<Either<ApiFailure, bool>> deleteCity(String id);

  Future<Either<ApiFailure, bool>> addCity({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  });

  Future<Either<ApiFailure, bool>> editCity({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject,
  });

  ///////////////// Bed Type //////////////////////
  Future<Either<ApiFailure, BedTypesApiResponseEntity>> getBedType();

  Future<Either<ApiFailure, bool>> deleteBedType(String id);

  Future<Either<ApiFailure, bool>> addBedType({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  });

  Future<Either<ApiFailure, bool>> editBedType({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject,
  });

  //////////////// Post Category //////////////////
  Future<Either<ApiFailure, PostCategoryResponseEntity>> getPostCategory();

  Future<Either<ApiFailure, bool>> deletePostCategory(String id);

  Future<Either<ApiFailure, bool>> addPostCategory({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
    required bool status,
  });

  Future<Either<ApiFailure, bool>> editPostCategory({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool? status,
    bool forceEmptyImageObject,
  });

  ////////////////// Reservation Type ///////////////////
  Future<Either<ApiFailure, ReservationTypesApiResponseEntity>>
  getReservationType();

  Future<Either<ApiFailure, bool>> deleteReservationType(String id);

  Future<Either<ApiFailure, bool>> addReservationType({
    required String nameAr,
    required String nameEn,
  });

  Future<Either<ApiFailure, bool>> editReservationType({
    required String id,
    String? nameAr,
    String? nameEn,
  });
}
