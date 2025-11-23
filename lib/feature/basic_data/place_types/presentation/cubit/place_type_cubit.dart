// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nilz_app/core/api/api_error/api_error.dart';
import '../../../../../core/resource/cubit_status_manager.dart';
import '../../domain/usecase/add_place_type_usecase.dart';
import '../../domain/usecase/place_type_usecase.dart';
import '../../domain/usecase/delete_place_type_usecase.dart';
import '../../domain/usecase/edit_place_type_usecase.dart';
import 'place_type_state.dart';

class PlaceTypeCubit extends Cubit<PlaceTypeState> {
  final PlaceTypeUseCase getPlaceTypeUseCase;
  final DeletePlaceTypeUseCase deletePlaceTypeUseCase;
  final AddPlaceTypeUseCase addPlaceTypeUseCase;
  final EditPlaceTypeUseCase editPlaceTypeUseCase;

  PlaceTypeCubit({
    required this.getPlaceTypeUseCase,
    required this.deletePlaceTypeUseCase,
    required this.addPlaceTypeUseCase,
    required this.editPlaceTypeUseCase,
  }) : super(PlaceTypeState.initial());

  Future<void> getPlaceType({required BuildContext context}) async {
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await getPlaceTypeUseCase();
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

  Future<void> deletePlaceType(BuildContext context, String id) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await deletePlaceTypeUseCase(id);
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
        await getPlaceType(context: context);
      },
    );
  }

  Future<void> addPlaceType(
    BuildContext context, {
    required String nameAr,
    required String nameEn,
    String imageName = '',
    String base64 = '',
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await addPlaceTypeUseCase(
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
        await getPlaceType(context: context);
      },
    );
  }

  Future<void> editPlaceType(
    BuildContext context, {
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject = false,
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await editPlaceTypeUseCase(
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
        await getPlaceType(context: context);
      },
    );
  }
}
