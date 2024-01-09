part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final String phone;
  final bool isNavigation;

  const AuthLoginEvent({required this.phone, required this.isNavigation});
}

class AuthVerifyOtpEvent extends AuthEvent {
  final String phone;
  final String otp;

  const AuthVerifyOtpEvent({required this.phone, required this.otp});
}

class ChangeObnoardModeEvent extends AuthEvent {
  final String mode;

  const ChangeObnoardModeEvent({required this.mode});
}

class ResentOtpEvent extends AuthEvent {
  final String status;

  const ResentOtpEvent({required this.status});
}
