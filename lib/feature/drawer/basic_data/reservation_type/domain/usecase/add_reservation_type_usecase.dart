import 'package:dartz/dartz.dart';
import 'package:nilz_app/feature/drawer/basic_data/data/repository/basic_data_repository.dart';
import '../../../../../../core/api/api_error/api_failures.dart';

class AddReservationTypeUseCase {
  final BasicDataRepository repository;

  AddReservationTypeUseCase({required this.repository});

  Future<Either<ApiFailure, bool>> call({
    required String nameAr,
    required String nameEn,
  }) {
    return repository.addReservationType(
      nameAr: nameAr,
      nameEn: nameEn,
    );
  }
}
