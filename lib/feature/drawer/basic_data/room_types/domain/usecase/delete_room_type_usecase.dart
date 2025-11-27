import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import 'package:nilz_app/feature/drawer/basic_data/data/repository/basic_data_repository.dart';

class DeleteRoomTypeUseCase {
  final BasicDataRepository repository;

  DeleteRoomTypeUseCase({required this.repository});

  Future<Either<ApiFailure, bool>> call(String id) {
    return repository.deleteRoomType(id);
  }
}
