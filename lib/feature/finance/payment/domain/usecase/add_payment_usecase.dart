import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../../../data/repository/finance_repository.dart';

class AddPaymentUseCase {
  final FinanceRepository repository;

  AddPaymentUseCase({required this.repository});

  Future<Either<ApiFailure, bool>> call({
    required String clientName,
    required String description,
    required String amount,
    required String paymentDueDate,
    required String status,
  }) {
    return repository.addPayment(
      clientName: clientName,
      description: description,
      amount: amount,
      paymentDueDate: paymentDueDate,
      status: status,
    );
  }
}
