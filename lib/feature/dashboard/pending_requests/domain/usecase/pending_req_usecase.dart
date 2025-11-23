import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import '../entity/response/pending_req_entity.dart';
import '../repository/pending_req_repository.dart';

class PendingRequestUseCase {
  final PendingRequestRepository repository;
  PendingRequestUseCase({
    required this.repository,
  });
  Future<Either<ApiFailure, PendingRequestResponseEntity>> call() {
  return repository.getPendingRequest();
  }
}

