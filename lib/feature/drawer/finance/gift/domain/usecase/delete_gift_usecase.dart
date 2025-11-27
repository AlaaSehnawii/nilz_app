import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import '../../../data/repository/finance_repository.dart';

class DeleteGiftUseCase{
  final FinanceRepository repository;

  DeleteGiftUseCase( {required this.repository});

  Future<Either<ApiFailure, bool>> call(String id) {
    return repository.deleteGift(id);
  }

}