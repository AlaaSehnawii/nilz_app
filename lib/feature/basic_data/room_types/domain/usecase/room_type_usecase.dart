import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import 'package:nilz_app/feature/basic_data/data/repository/basic_data_repository.dart';
import '../entity/room_type_entity.dart';

class RoomTypeUseCase {
  final BasicDataRepository repository;

  RoomTypeUseCase({required this.repository});

  Future<Either<ApiFailure, RoomTypesApiResponseEntity>> call() {
    return repository.getRoomType();
  }
}
