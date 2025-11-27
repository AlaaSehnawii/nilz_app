import 'package:dartz/dartz.dart';
import '../../../../../../core/api/api_error/api_failures.dart';
import '../../../data/repository/finance_repository.dart';

class EditPaymentUseCase {
  final FinanceRepository repository;
  EditPaymentUseCase({required this.repository});

  Future<Either<ApiFailure, bool>> call({
    required String id,
    String? clientName,
    String? description,
    String? amount,
    String? paymentDueDate,
    String? status,
  }) {
    return repository.editPayment(
      id: id,
      clientName: clientName,
      description: description,
      amount: amount,
      paymentDueDate: paymentDueDate,
      status: status,
    );
  }
}
