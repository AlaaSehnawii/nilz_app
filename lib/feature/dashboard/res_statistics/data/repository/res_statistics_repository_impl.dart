import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/connector.dart';
import 'package:nilz_app/feature/dashboard/res_statistics/data/datasource/res_statistics_remote.dart';
import 'package:nilz_app/feature/dashboard/res_statistics/domain/entity/response/res_statistics_entity.dart';
import 'package:nilz_app/feature/dashboard/res_statistics/domain/repository/res_statistics_repository.dart';
import '../../../../../core/api/api_error/api_failures.dart' show ApiFailure;



class ResStatisticsRepositoryImpl implements ResStatisticsRepository {
  final ResStatisticsRemote remote;

  ResStatisticsRepositoryImpl({
    required this.remote,
  });


  @override
  Future<Either<ApiFailure, ResStatisticsResponseEntity>> getResStatistics() {
    return Connector<ResStatisticsResponseEntity>().connect(
      remote: () async {
        final result = await remote.resStatistics();
        return Right(result);
      },
    );
  }

}
