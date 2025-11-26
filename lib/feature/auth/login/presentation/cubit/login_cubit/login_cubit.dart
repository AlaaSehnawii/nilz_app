// ignore: depend_on_referenced_packages
// ignore_for_file: use_build_context_synchronously

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:nilz_app/core/api/api_error/api_error.dart';
import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import 'package:nilz_app/core/storage/shared/shared_pref.dart';
import 'package:nilz_app/feature/auth/login/domain/entity/request/login_request_entity.dart';
import 'package:nilz_app/feature/auth/login/domain/entity/response/login_response_entity.dart';
import 'package:nilz_app/feature/auth/login/domain/usecase/login_usecase.dart';
import 'package:nilz_app/feature/auth/login/domain/usecase/logout_usecase.dart';
import 'package:nilz_app/feature/auth/login/presentation/cubit/login_cubit/login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase useCase;
  final LogoutUseCase logoutUseCase;

  LoginCubit({required this.useCase, required this.logoutUseCase})
      : super(LoginState.initial());

  login({ required BuildContext context,required LoginRequestEntity entity}) async {
    
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await useCase(entity: entity);
    //!Check if Bloc Closed
    if (isClosed) return;
    result.fold(
      (failure) async {
        final ErrorEntity errorEntity =
            await ApiErrorHandler.mapFailure(failure: failure,buildContext: context);
        emit(state.copyWith(
            error: errorEntity.errorMessage, status: CubitStatus.error));
      },
      (data) {

        AppSharedPreferences.cashUserInfo(token: data.accessToken ??"", userId: data.user?.id??"");
        debugPrint('token: ${AppSharedPreferences.getToken()}');
        debugPrint('id: ${data.user?.id}');
        emit(state.copyWith(status: CubitStatus.success, entity: data.user));


      },
    );
  }

  // ============== logout ==============

  Future<void> logout(BuildContext context) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await logoutUseCase();
    if (isClosed) return;

    result.fold(
          (failure) async {
        final errorEntity =
        await ApiErrorHandler.mapFailure(failure: failure, buildContext: context);

        AppSharedPreferences.clear();

        emit(state.copyWith(
          status: CubitStatus.error,
          error: errorEntity.errorMessage,
          entity: LoginResponseEntity(),
        ));
      },
          (_) async {
        AppSharedPreferences.clear();

        emit(state.copyWith(
          status: CubitStatus.success,
          error: "",
          entity: LoginResponseEntity(),
        ));
      },
    );

    if (Scaffold.maybeOf(context)?.isDrawerOpen ?? false) {
      Navigator.of(context).pop();
    }

    if (context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
    }
  }
}
