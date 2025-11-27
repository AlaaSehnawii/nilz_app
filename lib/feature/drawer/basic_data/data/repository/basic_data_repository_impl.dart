import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/connector.dart';
import 'package:nilz_app/feature/drawer/basic_data/data/repository/basic_data_repository.dart';
import 'package:nilz_app/feature/drawer/basic_data/reservation_type/domain/entity/reservation_type_entity.dart';
import 'package:nilz_app/feature/drawer/basic_data/service/domain/entity/service_entity.dart';
import '../../../../../core/api/api_error/api_failures.dart' show ApiFailure;
import '../../unit_types/domain/entity/unit_type_entity.dart';
import '../../bed_types/domain/entity/bed_type_entity.dart';
import '../../city/domain/entity/city_entity.dart';
import '../../place_types/domain/entity/place_type_entity.dart';
import '../../post_category/domain/entity/post_category_entity.dart';
import '../../room_types/domain/entity/room_type_entity.dart';
import '../datasource/basic_data_remote.dart';

class BasicDataRepositoryImpl implements BasicDataRepository {
  final BasicDataRemote remote;

  BasicDataRepositoryImpl({required this.remote});
//////////////// Unit Type ////////////////
  @override
  Future<Either<ApiFailure, UnitTypesApiResponseEntity>> getUnitType() {
    return Connector<UnitTypesApiResponseEntity>().connect(
      remote: () async {
        final result = await remote.getUnitType();
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> deleteUnitType(String id) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.deleteUnitType(id);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> addUnitType({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.addUnitType(
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
        );
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> editUnitType({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject = false,
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final ok = await remote.editUnitType(
          id: id,
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
          forceEmptyImageObject: forceEmptyImageObject,
        );
        return Right(ok);
      },
    );
  }
  //////////////// Service ////////////////

  @override
  Future<Either<ApiFailure, ServicesApiResponseEntity>> getService() {
    return Connector<ServicesApiResponseEntity>().connect(
      remote: () async {
        final result = await remote.getService();
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> deleteService(String id) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.deleteService(id);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> addService({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
    required String city,
    required bool status,
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.addService(
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
          city: city,
          status: status,
        );
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> editService({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    String? city,
    bool? status,
    bool forceEmptyImageObject = false,
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final ok = await remote.editService(
          id: id,
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
          city: city,
          status: status,
          forceEmptyImageObject: forceEmptyImageObject,
        );
        return Right(ok);
      },
    );
  }
///////////////// Room Type ///////////////////////
  @override
  Future<Either<ApiFailure, RoomTypesApiResponseEntity>> getRoomType() {
    return Connector<RoomTypesApiResponseEntity>().connect(
      remote: () async {
        final result = await remote.getRoomType();
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> deleteRoomType(String id) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.deleteRoomType(id);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> addRoomType({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.addRoomType(
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
        );
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> editRoomType({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject = false,
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final ok = await remote.editRoomType(
          id: id,
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
          forceEmptyImageObject: forceEmptyImageObject,
        );
        return Right(ok);
      },
    );
  }

  @override
  Future<Either<ApiFailure, PlaceTypesApiResponseEntity>> getPlaceType() {
    return Connector<PlaceTypesApiResponseEntity>().connect(
      remote: () async {
        final result = await remote.getPlaceType();
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> deletePlaceType(String id) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.deletePlaceType(id);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> addPlaceType({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.addPlaceType(
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
        );
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> editPlaceType({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject = false,
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final ok = await remote.editPlaceType(
          id: id,
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
          forceEmptyImageObject: forceEmptyImageObject,
        );
        return Right(ok);
      },
    );
  }
//////////// City /////////////////
  @override
  Future<Either<ApiFailure, CitiesApiResponseEntity>> getCity() {
    return Connector<CitiesApiResponseEntity>().connect(
      remote: () async {
        final result = await remote.getCity();
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> deleteCity(String id) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.deleteCity(id);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> addCity({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.addCity(
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
        );
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> editCity({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject = false,
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final ok = await remote.editCity(
          id: id,
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
          forceEmptyImageObject: forceEmptyImageObject,
        );
        return Right(ok);
      },
    );
  }

  @override
  Future<Either<ApiFailure, BedTypesApiResponseEntity>> getBedType() {
    return Connector<BedTypesApiResponseEntity>().connect(
      remote: () async {
        final result = await remote.getBedType();
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> deleteBedType(String id) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.deleteBedType(id);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> addBedType({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.addBedType(
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
        );
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> editBedType({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject = false,
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final ok = await remote.editBedType(
          id: id,
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
          forceEmptyImageObject: forceEmptyImageObject,
        );
        return Right(ok);
      },
    );
  }
//////////////////// Post Category ////////////////////
  @override
  Future<Either<ApiFailure, PostCategoryResponseEntity>> getPostCategory() {
    return Connector<PostCategoryResponseEntity>().connect(
      remote: () async {
        final result = await remote.getPostCategory();
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> deletePostCategory(String id) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.deletePostCategory(id);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> addPostCategory({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
    required bool status,
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.addPostCategory(
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
          status: status,
        );
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> editPostCategory({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool? status,
    bool forceEmptyImageObject = false,
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final ok = await remote.editPostCategory(
          id: id,
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
          status: status,
          forceEmptyImageObject: forceEmptyImageObject,
        );
        return Right(ok);
      },
    );
  }
////////////// Reservation ///////////////////////
  @override
  Future<Either<ApiFailure, ReservationTypesApiResponseEntity>>
  getReservationType() {
    return Connector<ReservationTypesApiResponseEntity>().connect(
      remote: () async {
        final result = await remote.getReservationType();
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> deleteReservationType(String id) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.deleteReservationType(id);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> addReservationType({
    required String nameAr,
    required String nameEn,
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.addReservationType(
          nameAr: nameAr,
          nameEn: nameEn,
        );
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> editReservationType({
    required String id,
    String? nameAr,
    String? nameEn,
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final ok = await remote.editReservationType(
          id: id,
          nameAr: nameAr,
          nameEn: nameEn,
        );
        return Right(ok);
      },
    );
  }
}
