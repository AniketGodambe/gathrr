import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gathrr/bloc/auth/auth_bloc.dart';
import 'package:gathrr/core/consts.dart';
import 'package:gathrr/core/custom_textstyle.dart';
import 'package:gathrr/core/primary_button.dart';
import 'package:gathrr/core/colors.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ContentWidget extends StatelessWidget {
  final AuthState state;
  const ContentWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kheight40,
          Center(
            child: Image.asset(
              "assets/obboard_gahtrr.png",
              height: 80,
            ),
          ),
          kheight40,
          kheight20,
          Text(
            state.runtimeType == LoginState ? "Join Gathrr" : 'Login to Gathrr',
            style: titleStyle.copyWith(fontSize: 30),
          ),
          kheight20,
          Text(
            state.runtimeType == LoginState
                ? 'Join Gathrr to attend events network with the people from your industry.'
                : 'Gathrr is the go-to app to attend events and network with people from your industry.',
            style: subtitleStyle,
          ),
        ],
      ),
    );
  }
}

class TermsAndCondtionsTextWidget extends StatelessWidget {
  final bool isChecked;
  const TermsAndCondtionsTextWidget({super.key, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          activeColor: Colors.green,
          onChanged: (newValue) {
            context.read<AuthBloc>().add(CheckboxChangedEvent(newValue!));
          },
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'By proceeding you agree to our ',
                  style: subtitleStyle.copyWith(fontSize: 16),
                ),
                const TextSpan(text: 'Terms', style: loginregistertextStyle),
                TextSpan(
                  text: ' & ',
                  style: subtitleStyle.copyWith(fontSize: 16),
                ),
                const TextSpan(
                    text: 'Conditions', style: loginregistertextStyle),
                TextSpan(
                  text: ' ',
                  style: subtitleStyle.copyWith(fontSize: 16),
                ),
                const TextSpan(
                    text: 'Privacy Policies', style: loginregistertextStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LoginButtonWidget extends StatelessWidget {
  final AuthState state;
  final AuthBloc authBloc;
  final String phone;
  const LoginButtonWidget(
      {super.key,
      required this.state,
      required this.authBloc,
      required this.phone});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      isLoading: state.runtimeType == AuthLodingState,
      onTap: () {
        authBloc.add(AuthLoginEvent(phone: phone, isNavigation: true));
      },
      title: "Login",
    );
  }
}

class LoginRegistedSwitchWidget extends StatelessWidget {
  final AuthState state;
  final AuthBloc authBloc;
  const LoginRegistedSwitchWidget(
      {super.key, required this.state, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          state.runtimeType == LoginState
              ? "Already have an account? "
              : "New to gathrr? ",
          style: subtitleStyle.copyWith(fontSize: 20),
        ),
        GestureDetector(
          onTap: () {
            if (state.runtimeType == LoginState) {
              authBloc.add(const ChangeObnoardModeEvent(
                mode: 'register',
              ));
            } else {
              authBloc.add(const ChangeObnoardModeEvent(mode: 'login'));
            }
          },
          child: Text(
            state.runtimeType == LoginState ? "login" : 'Register',
            style: loginregistertextStyle.copyWith(fontSize: 20),
          ),
        )
      ],
    );
  }
}

class InputOtpField extends StatelessWidget {
  final TextEditingController controller;
  final String phone;
  final AuthBloc authBloc;

  const InputOtpField(
      {super.key,
      required this.controller,
      required this.phone,
      required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: kwhite,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0x3D004999)),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      padding: const EdgeInsets.all(8),
      width: Get.width / 1.3,
      height: 80,
      child: PinCodeTextField(
        autoFocus: true,
        showCursor: true,
        length: 4,
        obscureText: false,
        animationType: AnimationType.fade,
        cursorColor: kblack,
        keyboardType: TextInputType.number,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderWidth: 0.1,
          borderRadius: BorderRadius.circular(10),
          fieldHeight: 60,
          fieldWidth: 45,
          fieldOuterPadding: const EdgeInsets.all(0),
          activeFillColor: bgColor,
          activeColor: bgColor,
          inactiveColor: bgColor,
          disabledColor: bgColor,
          inactiveFillColor: bgColor,
          selectedColor: bgColor,
          selectedFillColor: bgColor,
        ),
        controller: controller,
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: kwhite,
        enableActiveFill: true,
        onCompleted: (v) {
          authBloc.add(AuthVerifyOtpEvent(phone: phone, otp: v));
        },
        onChanged: (value) {},
        beforeTextPaste: (text) {
          return true;
        },
        appContext: context,
      ),
    );
  }
}

class ResentOtpWidget extends StatelessWidget {
  final AuthState state;
  final AuthBloc authBloc;
  final String phone;
  const ResentOtpWidget(
      {super.key,
      required this.state,
      required this.authBloc,
      required this.phone});

  @override
  Widget build(BuildContext context) {
    return state.runtimeType == SentState
        ? Text(
            'OTP sent successfully',
            style: subtitleStyle.copyWith(fontSize: 20),
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Didn’t receive it? ',
                style: subtitleStyle.copyWith(fontSize: 20),
              ),
              GestureDetector(
                onTap: () {
                  if (state.runtimeType == ResendState) {
                    authBloc.add(const ResentOtpEvent(
                      status: 'sent',
                    ));
                  } else {
                    authBloc.add(const ResentOtpEvent(
                      status: 'resend',
                    ));
                  }
                  authBloc
                      .add(AuthLoginEvent(phone: phone, isNavigation: false));
                },
                child: Text(
                  "Tap to resend",
                  style: loginregistertextStyle.copyWith(fontSize: 20),
                ),
              )
            ],
          );
  }
}
