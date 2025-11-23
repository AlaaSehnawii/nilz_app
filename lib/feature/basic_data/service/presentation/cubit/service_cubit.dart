// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nilz_app/core/api/api_error/api_error.dart';
import 'package:nilz_app/feature/basic_data/service/presentation/cubit/service_state.dart';
import '../../../../../core/resource/cubit_status_manager.dart';
import '../../domain/usecase/add_service_usecase.dart';
import '../../domain/usecase/delete_service_usecase.dart';
import '../../domain/usecase/edit_service_usecase.dart';
import '../../domain/usecase/service_usecase.dart';

class ServiceCubit extends Cubit<ServiceState> {
  final ServiceUseCase getServiceUseCase;
  final DeleteServiceUseCase deleteServiceUseCase;
  final AddServiceUseCase addServiceUseCase;
  final EditServiceUseCase editServiceUseCase;

  ServiceCubit({
    required this.getServiceUseCase,
    required this.deleteServiceUseCase,
    required this.addServiceUseCase,
    required this.editServiceUseCase,
  }) : super(ServiceState.initial());

  Future<void> getService({required BuildContext context}) async {
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await getServiceUseCase();
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




  Future<void> deleteService(BuildContext context, String id) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await deleteServiceUseCase(id);
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
        await getService(context: context);
      },
    );
  }

  Future<void> addService(
    BuildContext context, {
    required String nameAr,
    required String nameEn,
    required String imageName,
    required String base64,
    required String city,
    required bool status,
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await addServiceUseCase(
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName,
      base64: base64,
      status: status,
      city: city,
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
        await getService(context: context);
      },
    );
  }

  Future<void> editService(
    BuildContext context, {
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    String? cityId,
    bool? status,
        bool? removeImage,
    bool forceEmptyImageObject = false,
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await editServiceUseCase(
      id: id,
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName,
      base64: base64,
      cityId: cityId,
      status: status,
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
        await getService(context: context);
      },
    );
  }
}
