import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import 'package:nilz_app/feature/finance/gift/domain/entity/gift_entity.dart';
import '../../../data/repository/finance_repository.dart';

class GiftUseCase {
  final FinanceRepository repository;
  GiftUseCase({
    required this.repository,
  });
  Future<Either<ApiFailure, GiftApiResponseEntity>> call() {
    return repository.getGift();
  }
}

