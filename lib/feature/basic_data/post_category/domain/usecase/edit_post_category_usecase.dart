import 'package:dartz/dartz.dart';
import 'package:nilz_app/feature/basic_data/data/repository/basic_data_repository.dart';
import '../../../../../core/api/api_error/api_failures.dart';

class EditPostCategoryUseCase {
  final BasicDataRepository repository;
  EditPostCategoryUseCase({required this.repository});

  Future<Either<ApiFailure, bool>> call({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool? status,
    bool forceEmptyImageObject = false,
  }) {
    return repository.editPostCategory(
      id: id,
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName,
      base64: base64,
      status: status,
      forceEmptyImageObject: forceEmptyImageObject,
    );
  }
}
