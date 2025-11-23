import 'package:dartz/dartz.dart';
import 'package:nilz_app/feature/basic_data/data/repository/basic_data_repository.dart';
import '../../../../../core/api/api_error/api_failures.dart';

class EditReservationTypeUseCase {
  final BasicDataRepository repository;
  EditReservationTypeUseCase({required this.repository});

  Future<Either<ApiFailure, bool>> call({
    required String id,
    String? nameAr,
    String? nameEn,
  }) {
    return repository.editReservationType(
      id: id,
      nameAr: nameAr,
      nameEn: nameEn,
    );
  }
}
