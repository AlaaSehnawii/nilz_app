import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../entity/response/pending_req_entity.dart';




abstract class PendingRequestRepository {
  Future<Either<ApiFailure, PendingRequestResponseEntity>> getPendingRequest();
}
