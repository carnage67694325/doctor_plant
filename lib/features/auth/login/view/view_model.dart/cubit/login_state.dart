part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginFaiulre extends LoginState {
  final String erroMessage;

  LoginFaiulre({required this.erroMessage});
}

final class LoginLoading extends LoginState {}
