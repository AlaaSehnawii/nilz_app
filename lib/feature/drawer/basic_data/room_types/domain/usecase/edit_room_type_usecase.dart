import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import 'package:nilz_app/feature/drawer/basic_data/data/repository/basic_data_repository.dart';

class EditRoomTypeUseCase {
  final BasicDataRepository repository;

  EditRoomTypeUseCase({required this.repository});

  Future<Either<ApiFailure, bool>> call({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject = false,
  }) {
    return repository.editRoomType(
      id: id,
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName,
      base64: base64,
      forceEmptyImageObject: forceEmptyImageObject,
    );
  }
}
