import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import 'package:nilz_app/feature/drawer/basic_data/data/repository/basic_data_repository.dart';

class AddPlaceTypeUseCase {
  final BasicDataRepository repository;

  AddPlaceTypeUseCase({required this.repository});

  Future<Either<ApiFailure, bool>> call({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  }) {
    return repository.addPlaceType(
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName,
      base64: base64,
    );
  }
}
