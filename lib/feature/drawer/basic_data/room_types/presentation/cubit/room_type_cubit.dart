// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nilz_app/core/api/api_error/api_error.dart';
import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import 'package:nilz_app/feature/drawer/basic_data/room_types/presentation/cubit/room_type_state.dart';
import '../../domain/usecase/add_room_type_usecase.dart';
import '../../domain/usecase/delete_room_type_usecase.dart';
import '../../domain/usecase/edit_room_type_usecase.dart';
import '../../domain/usecase/room_type_usecase.dart';

class RoomTypeCubit extends Cubit<RoomTypeState> {
  final RoomTypeUseCase getRoomTypeUseCase;
  final DeleteRoomTypeUseCase deleteRoomTypeUseCase;
  final AddRoomTypeUseCase addRoomTypeUseCase;
  final EditRoomTypeUseCase editRoomTypeUseCase;

  RoomTypeCubit({
    required this.getRoomTypeUseCase,
    required this.deleteRoomTypeUseCase,
    required this.addRoomTypeUseCase,
    required this.editRoomTypeUseCase,
  }) : super(RoomTypeState.initial());

  Future<void> getRoomType({required BuildContext context}) async {
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await getRoomTypeUseCase();
    if (isClosed) return;

    result.fold(
      (failure) async {
        final errorEntity = await ApiErrorHandler.mapFailure(
          failure: failure,
          buildContext: context,
        );
        emit(
          state.copyWith(
            error: errorEntity.errorMessage,
            status: CubitStatus.error,
          ),
        );
      },
      (data) {
        emit(state.copyWith(status: CubitStatus.success, entity: data));
      },
    );
  }

  Future<void> deleteRoomType(BuildContext context, String id) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await deleteRoomTypeUseCase(id);
    if (isClosed) return;

    await result.fold(
      (failure) async {
        final errorEntity = await ApiErrorHandler.mapFailure(
          failure: failure,
          buildContext: context,
        );
        emit(
          state.copyWith(
            status: CubitStatus.error,
            error: errorEntity.errorMessage,
          ),
        );
      },
      (_) async {
        await getRoomType(context: context);
      },
    );
  }

  Future<void> addRoomType(
    BuildContext context, {
    required String nameAr,
    required String nameEn,
    String imageName = '',
    String base64 = '',
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await addRoomTypeUseCase(
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName,
      base64: base64,
    );
    if (isClosed) return;

    await result.fold(
      (failure) async {
        final errorEntity = await ApiErrorHandler.mapFailure(
          failure: failure,
          buildContext: context,
        );
        emit(
          state.copyWith(
            status: CubitStatus.error,
            error: errorEntity.errorMessage,
          ),
        );
      },
      (_) async {
        await getRoomType(context: context);
      },
    );
  }

  Future<void> editRoomType(
    BuildContext context, {
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject = false,
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await editRoomTypeUseCase(
      id: id,
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName,
      base64: base64,
      forceEmptyImageObject: forceEmptyImageObject,
    );

    if (isClosed) return;

    await result.fold(
      (failure) async {
        final error = await ApiErrorHandler.mapFailure(
          failure: failure,
          buildContext: context,
        );
        emit(
          state.copyWith(status: CubitStatus.error, error: error.errorMessage),
        );
      },
      (_) async {
        await getRoomType(context: context);
      },
    );
  }
}
