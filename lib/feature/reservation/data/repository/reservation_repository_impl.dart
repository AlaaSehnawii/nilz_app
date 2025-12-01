import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/connector.dart';
import 'package:nilz_app/feature/reservation/domain/entity/response/unit_entity.dart';
import '../../../../../core/api/api_error/api_failures.dart' show ApiFailure;
import '../../domain/entity/response/reservation_entity.dart';
import '../../domain/repository/reservation_repository.dart';
import '../datasource/reservation_remote.dart';

class ReservationRepositoryImpl implements ReservationRepository {
  final ReservationRemote remote;

  ReservationRepositoryImpl({required this.remote});

  @override
  Future<Either<ApiFailure, ReservationListResponseEntity>> getReservation() {
    return Connector<ReservationListResponseEntity>().connect(
      remote: () async {
        final result = await remote.reservation();
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> createReservation({
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
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.createReservation(
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
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, UnitApiResponseEntity>> getUnitChildren({
    required String cityId,
    required String toStartTimeIso,
    required String toEndTimeIso,
    required List<Map<String, dynamic>> roomConfig,
  }) {
    return Connector<UnitApiResponseEntity>().connect(
      remote: () async {
        final result = await remote.getUnitChildren(
          cityId: cityId,
          toStartTimeIso: toStartTimeIso,
          toEndTimeIso: toEndTimeIso,
          roomConfig: roomConfig,
        );
        return Right(result);
      },
    );
  }
}
