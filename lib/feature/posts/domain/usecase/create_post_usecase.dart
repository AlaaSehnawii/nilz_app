import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../repository/post_repository.dart';

class CreatePostUseCase {
  final PostRepository repository;

  CreatePostUseCase({required this.repository});

  Future<Either<ApiFailure, bool>> call({
    required String unit,
    required String fromDate,
    required String toDate,
    int? extraBedCount,
    required String guests,
    required int age,
    required int count,
    required int roomNum,
    String? couponCode,
    required String userId,
    required bool withBreakfast,
  }) {
    return repository.createPost(
      unit: unit,
      fromDate: fromDate,
      toDate: toDate,
      extraBedCount: extraBedCount,
      guests: guests,
      age: age,
      count: count,
      roomNum: roomNum,
      couponCode: couponCode,
      userId: userId,
      withBreakfast: withBreakfast,
    );
  }
}
