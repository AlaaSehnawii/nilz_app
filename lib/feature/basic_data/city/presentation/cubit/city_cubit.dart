// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nilz_app/core/api/api_error/api_error.dart';
import '../../../../../core/resource/cubit_status_manager.dart';
import '../../domain/usecase/add_city_usecase.dart';
import '../../domain/usecase/city_usecase.dart';
import '../../domain/usecase/delete_city_usecase.dart';
import '../../domain/usecase/edit_city_usecase.dart';
import 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  final CityUseCase getCityUseCase;
  final DeleteCityUseCase deleteCityUseCase;
  final AddCityUseCase addCityUseCase;
  final EditCityUseCase editCityUseCase;

  CityCubit({
    required this.getCityUseCase,
    required this.deleteCityUseCase,
    required this.addCityUseCase,
    required this.editCityUseCase,
  }) : super(CityState.initial());

  Future<void> getCity({required BuildContext context}) async {
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await getCityUseCase();
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

  Future<void> deleteCity(BuildContext context, String id) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await deleteCityUseCase(id);
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
        await getCity(context: context);
      },
    );
  }

  Future<void> addCity(
    BuildContext context, {
    required String nameAr,
    required String nameEn,
    String imageName = '',
    String base64 = '',
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await addCityUseCase(
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
        await getCity(context: context);
      },
    );
  }

  Future<void> editCity(
    BuildContext context, {
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    String? cityId,
    bool forceEmptyImageObject = false,
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await editCityUseCase(
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
        await getCity(context: context);
      },
    );
  }
}
