import 'package:dartz/dartz.dart';
import '../../../../../../core/api/api_error/api_failures.dart';
import '../../../data/repository/finance_repository.dart';

class EditGiftUseCase {
  final FinanceRepository repository;
  EditGiftUseCase({required this.repository});

  Future<Either<ApiFailure, bool>> call({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject = false,
  }) {
    return repository.editGift(
      id: id,
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName,
      base64: base64,
      forceEmptyImageObject: forceEmptyImageObject,
    );
  }
}
