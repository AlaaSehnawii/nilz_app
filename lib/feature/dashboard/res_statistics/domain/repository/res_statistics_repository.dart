import 'package:dartz/dartz.dart';
import 'package:nilz_app/feature/dashboard/res_statistics/domain/entity/response/res_statistics_entity.dart';
import '../../../../../core/api/api_error/api_failures.dart';




abstract class ResStatisticsRepository {
  Future<Either<ApiFailure, ResStatisticsResponseEntity>> getResStatistics();
}
