import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../entity/request/login_request_entity.dart';
import '../entity/response/login_response_entity.dart';
import '../repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase({
    required this.repository,
  });
  Future<Either<ApiFailure, LoginApiResponseEntity>> call(
  {required LoginRequestEntity entity}) {
    return repository.login(entity: entity);
  }
}
