import 'package:dartz/dartz.dart';
import 'package:nilz_app/feature/drawer/finance/gift/domain/entity/gift_entity.dart';
import 'package:nilz_app/feature/drawer/finance/payment/domain/entity/payment_entity.dart';
import '../../../../../core/api/api_error/api_failures.dart';

abstract class FinanceRepository {
  ////////////// Gift //////////////////////////////
  Future<Either<ApiFailure, GiftApiResponseEntity>> getGift();

  Future<Either<ApiFailure, bool>> deleteGift(String id);

  Future<Either<ApiFailure, bool>> addGift({
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
  });

  Future<Either<ApiFailure, bool>> editGift({
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject,
  });

  ///////////////// Payment //////////////////

  Future<Either<ApiFailure, PaymentApiResponseEntity>> getPayment();

  Future<Either<ApiFailure, bool>> deletePayment(String id);

  Future<Either<ApiFailure, bool>> addPayment({
    required String clientName,
    required String description,
    required String amount,
    required String paymentDueDate,
    required String status,
  });

  Future<Either<ApiFailure, bool>> editPayment({
    required String id,
    String? clientName,
    String? description,
    String? amount,
    String? paymentDueDate,
    String? status,
  });

}
