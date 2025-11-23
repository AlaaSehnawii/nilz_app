import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../../../../../core/api/connector.dart';
import '../../domain/entity/request/login_request_entity.dart';
import '../../domain/entity/response/login_response_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/remote/auth_remote.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemote remote;

  AuthRepositoryImpl({required this.remote});

  @override
  Future<Either<ApiFailure, LoginApiResponseEntity>> login({
    required LoginRequestEntity entity,
  }) {
    return Connector<LoginApiResponseEntity>().connect(
      remote: () async {
        final result = await remote.login(entity: entity);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, void>> logout() {
    return Connector<void>().connect(
      remote: () async {
        await remote.logout();
        return const Right(null);
      },
    );
  }
}
