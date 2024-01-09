part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class AuthLodingState extends AuthState {}

class AutEmptyPhoneState extends AuthState {}

class AuthErrorState extends AuthState {}

class AuthSuccessState extends AuthState {
  final bool isSuccess;

  const AuthSuccessState({required this.isSuccess});
}

class LoginState extends AuthState {}

class SignUpState extends AuthState {}

class ResendState extends AuthState {}

class SentState extends AuthState {}
