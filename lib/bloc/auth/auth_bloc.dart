import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gathrr/core/error_dialog.dart';
import 'package:gathrr/repo/auth_repo.dart';
import 'package:get/get.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginEvent>(authLoginEvent);
    on<ChangeObnoardModeEvent>(changeObnoardModeEvent);
    on<ResentOtpEvent>(resentOtpEvent);
    on<AuthVerifyOtpEvent>(authVerifyOtpEvent);
  }

  FutureOr<void> authLoginEvent(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLodingState());
    if (event.isNavigation == false) {
      emit(SentState());
    }
    try {
      if (event.phone.isEmpty || event.phone.length < 10) {
        emit(AutEmptyPhoneState());
        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return const ErrorPopup(
              errorMsg: "Please enter your 10 digit\nmobile number",
              errorTitle: 'Required',
              btnLabel: "Okay",
            );
          },
        );
      } else {
        var response = await AuthRepo.sendOtp(
            phone: event.phone, isnavigation: event.isNavigation);
        if (response == true) {
          emit(AuthSuccessState(isSuccess: response));
        } else {
          emit(AuthErrorState());
        }
      }
    } catch (e) {
      emit(AuthErrorState());
      log(e.toString());
    }
  }

  FutureOr<void> authVerifyOtpEvent(
      AuthVerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLodingState());
    try {
      if (event.otp.isEmpty || event.otp.length < 4) {
        emit(AutEmptyPhoneState());
        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return const ErrorPopup(
              errorMsg: "Please enter 4 digit otp!",
              errorTitle: 'Required',
              btnLabel: "Okay",
            );
          },
        );
      } else {
        var response =
            await AuthRepo.verifyOtp(phone: event.phone, otp: event.otp);
        if (response == true) {
          emit(AuthSuccessState(isSuccess: response));
        } else {
          emit(AuthErrorState());
        }
      }
    } catch (e) {
      emit(AuthErrorState());
      log(e.toString());
    }
  }

  FutureOr<void> changeObnoardModeEvent(
      ChangeObnoardModeEvent event, Emitter<AuthState> emit) {
    if (event.mode == "login") {
      emit(LoginState());
    } else {
      emit(SignUpState());
    }
  }

  FutureOr<void> resentOtpEvent(ResentOtpEvent event, Emitter<AuthState> emit) {
    if (event.status == "sent") {
      emit(SentState());
    } else {
      emit(ResendState());
    }
  }
}
