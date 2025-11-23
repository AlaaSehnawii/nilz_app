import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/connector.dart';
import '../../../../../core/api/api_error/api_failures.dart' show ApiFailure;
import '../../domain/entity/response/pending_req_entity.dart';
import '../../domain/repository/pending_req_repository.dart';
import '../datasource/pending_req_remote.dart';



class PendingRequestRepositoryImpl implements PendingRequestRepository {
  final PendingRequestRemote remote;

  PendingRequestRepositoryImpl({
    required this.remote,
  });


  @override
  Future<Either<ApiFailure, PendingRequestResponseEntity>> getPendingRequest() {
    return Connector<PendingRequestResponseEntity>().connect(
      remote: () async {
        final result = await remote.pendingRequest();
        return Right(result);
      },
    );
  }

}
