import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import '../repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  Future<Either<ApiFailure, void>> call() => repository.logout();
}
