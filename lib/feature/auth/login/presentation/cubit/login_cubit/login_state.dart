import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import 'package:nilz_app/feature/auth/login/domain/entity/response/login_response_entity.dart';
import 'package:nilz_app/feature/drawer/basic_data/bed_types/presentation/cubit/bed_type_state.dart';

class LoginState extends Equatable {
  final String error;
  final CubitStatus status;
  final LoginResponseEntity entity;

  LoginState(
      {required this.error, required this.status, required this.entity});

  factory LoginState.initial() {
    return LoginState(
      error: '',
      status: CubitStatus.initial,
      entity: LoginResponseEntity(),
    );
  }

  LoginState copyWith(
      {String? error,
      CubitStatus? status,
        LoginResponseEntity? entity}) {
    return LoginState(
        error: error ?? this.error,
        status: status ?? this.status,
        entity: entity ?? this.entity);
  }

  List<Object> get props => [error, status, entity];
}
