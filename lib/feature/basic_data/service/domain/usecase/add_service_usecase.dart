import 'package:dartz/dartz.dart';
import 'package:nilz_app/feature/basic_data/data/repository/basic_data_repository.dart';
import '../../../../../core/api/api_error/api_failures.dart';

class AddServiceUseCase {
  final BasicDataRepository repository;

  AddServiceUseCase({required this.repository});

  Future<Either<ApiFailure, bool>> call({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
    required String city,
    required bool status,
  }) {
    return repository.addService(
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName,
      base64: base64,
      city: city,
      status: status,
    );
  }
}
