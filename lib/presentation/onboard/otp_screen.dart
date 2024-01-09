import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gathrr/bloc/auth/auth_bloc.dart';
import 'package:gathrr/core/colors.dart';
import 'package:gathrr/core/consts.dart';
import 'package:gathrr/core/custom_textstyle.dart';
import 'package:gathrr/core/primary_button.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final AuthBloc authBloc = AuthBloc();
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listenWhen: (previous, current) => current is AuthInitial,
      buildWhen: (previous, current) => current is! AuthInitial,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kwhite,
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                kheight40,
                Text(
                    'Check your message box we sent you the 4 digit verification code!',
                    textAlign: TextAlign.center,
                    style: subtitleStyle.copyWith(fontSize: 20)),
                kheight30,
                Container(
                  decoration: ShapeDecoration(
                    color: kwhite,
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0x3D004999)),
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
                    controller: otpController,
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: kwhite,
                    enableActiveFill: true,
                    onCompleted: (v) {
                      authBloc
                          .add(AuthVerifyOtpEvent(phone: widget.phone, otp: v));
                    },
                    onChanged: (value) {},
                    beforeTextPaste: (text) {
                      return true;
                    },
                    appContext: context,
                  ),
                ),
                kheight40,
                PrimaryButton(
                  isLoading: state.runtimeType == AuthLodingState,
                  onTap: () {
                    authBloc.add(AuthVerifyOtpEvent(
                        phone: widget.phone, otp: otpController.text));
                  },
                  title: "Verify",
                ),
                kheight40,
                state.runtimeType == SentState
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
                              print(widget.phone);
                              authBloc.add(AuthLoginEvent(
                                  phone: widget.phone, isNavigation: false));
                            },
                            child: Text(
                              "Tap to resend",
                              style:
                                  loginregistertextStyle.copyWith(fontSize: 20),
                            ),
                          )
                        ],
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
