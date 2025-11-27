import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/connector.dart';
import 'package:nilz_app/feature/drawer/finance/gift/domain/entity/gift_entity.dart';
import 'package:nilz_app/feature/drawer/finance/payment/domain/entity/payment_entity.dart';
import '../../../../../core/api/api_error/api_failures.dart' show ApiFailure;
import '../datasource/finance_remote.dart';
import 'finance_repository.dart';

class FinanceRepositoryImpl implements FinanceRepository {
  final FinanceRemote remote;
  FinanceRepositoryImpl({required this.remote});

//////////////// Gift////////////////
  @override
  Future<Either<ApiFailure, GiftApiResponseEntity>> getGift() {
    return Connector<GiftApiResponseEntity>().connect(
      remote: () async {
        final result = await remote.getGift();
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> deleteGift(String id) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.deleteGift(id);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> addGift({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.addGift(
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
        );
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> editGift({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject = false,
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final ok = await remote.editGift(
          id: id,
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
          forceEmptyImageObject: forceEmptyImageObject,
        );
        return Right(ok);
      },
    );
  }

//////////////// Payment ////////////////
  @override
  Future<Either<ApiFailure, PaymentApiResponseEntity>> getPayment() {
    return Connector<PaymentApiResponseEntity>().connect(
      remote: () async {
        final result = await remote.getPayment();
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> deletePayment(String id) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.deletePayment(id);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> addPayment({
    required String clientName,
    required String description,
    required String amount,
    required String paymentDueDate,
    required String status,
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.addPayment(
          clientName: clientName,
          description: description,
          amount: amount,
          paymentDueDate: paymentDueDate,
          status: status,
        );
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> editPayment({
    required String id,
    String? clientName,
    String? description,
    String? amount,
    String? paymentDueDate,
    String? status,
  }) {
    return Connector<bool>().connect(
      remote: () async {
        final ok = await remote.editPayment(
          id: id,
          clientName: clientName,
          description: description,
          amount: amount,
          paymentDueDate: paymentDueDate,
          status: status,
        );
        return Right(ok);
      },
    );
  }
}
