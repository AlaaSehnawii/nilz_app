import 'package:dartz/dartz.dart';
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
}
