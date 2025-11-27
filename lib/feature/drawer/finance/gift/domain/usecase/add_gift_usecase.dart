import 'package:dartz/dartz.dart';
import '../../../../../../core/api/api_error/api_failures.dart';
import '../../../data/repository/finance_repository.dart';

class AddGiftUseCase {
  final FinanceRepository repository;

  AddGiftUseCase({required this.repository});

  Future<Either<ApiFailure, bool>> call({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  }) {
    return repository.addGift(
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName,
      base64: base64,
    );
  }
}
