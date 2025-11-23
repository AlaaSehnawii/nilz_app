import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import 'package:nilz_app/feature/dashboard/res_statistics/domain/entity/response/res_statistics_entity.dart';
import 'package:nilz_app/feature/dashboard/res_statistics/domain/repository/res_statistics_repository.dart';

class ResStatisticsUsecase {
  final ResStatisticsRepository repository;
  ResStatisticsUsecase({
    required this.repository,
  });
  Future<Either<ApiFailure, ResStatisticsResponseEntity>> call() {
  return repository.getResStatistics();
  }
}

