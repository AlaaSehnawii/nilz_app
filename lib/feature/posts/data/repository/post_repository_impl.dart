import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/connector.dart';
import 'package:nilz_app/feature/posts/domain/entity/response/post_entity.dart';
import '../../../../../core/api/api_error/api_failures.dart' show ApiFailure;
import '../../domain/repository/post_repository.dart';
import '../datasource/post_remote.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemote remote;

  PostRepositoryImpl({required this.remote});

  @override
  Future<Either<ApiFailure, PostsApiResponseEntity>> getPost() {
    return Connector<PostsApiResponseEntity>().connect(
      remote: () async {
        final result = await remote.post();
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> createPost({
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
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.createPost(
          unit: unit,
          fromDate: fromDate,
          toDate: toDate,
          guests: guests,
          age: age,
          count: count,
          roomNum: roomNum,
          userId: userId,
          withBreakfast: withBreakfast,
        );
        return Right(result);
      },
    );
  }
}
