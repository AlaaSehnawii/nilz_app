import 'package:dartz/dartz.dart';
import 'package:nilz_app/feature/reservation/domain/entity/response/unit_entity.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../entity/response/reservation_entity.dart';




abstract class ReservationRepository {
  Future<Either<ApiFailure, ReservationListResponseEntity>> getReservation();

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
});

//////////// Unit /////////////////
  Future<Either<ApiFailure, UnitApiResponseEntity>> getUnitChildren({
    required String cityId,
    required String toStartTimeIso,
    required String toEndTimeIso,
    required List<Map<String, dynamic>> roomConfig,
  });
}
