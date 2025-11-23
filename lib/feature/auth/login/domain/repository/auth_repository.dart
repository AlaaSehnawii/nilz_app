import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../entity/request/login_request_entity.dart';
import '../entity/response/login_response_entity.dart';

abstract class AuthRepository {
  Future<Either<ApiFailure, LoginApiResponseEntity>> login({
    required LoginRequestEntity entity,
  });

  Future<Either<ApiFailure, void>> logout();
}
