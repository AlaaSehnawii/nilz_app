import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import 'package:nilz_app/feature/finance/Payment/domain/entity/Payment_entity.dart';
import '../../../data/repository/finance_repository.dart';

class PaymentUseCase {
  final FinanceRepository repository;
  PaymentUseCase({
    required this.repository,
  });
  Future<Either<ApiFailure, PaymentApiResponseEntity>> call() {
    return repository.getPayment();
  }
}

