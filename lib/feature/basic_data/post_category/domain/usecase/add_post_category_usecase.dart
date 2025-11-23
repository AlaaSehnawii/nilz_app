import 'package:dartz/dartz.dart';
import 'package:nilz_app/feature/basic_data/data/repository/basic_data_repository.dart';
import '../../../../../core/api/api_error/api_failures.dart';

class AddPostCategoryUseCase {
  final BasicDataRepository repository;

  AddPostCategoryUseCase({required this.repository});

  Future<Either<ApiFailure, bool>> call({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
    required bool status,
  }) {
    return repository.addPostCategory(
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName,
      base64: base64,
      status: status,
    );
  }
}
