import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gathrr/bloc/auth/auth_bloc.dart';
import 'package:gathrr/core/colors.dart';
import 'package:gathrr/core/consts.dart';
import 'package:gathrr/core/custom_textstyle.dart';
import 'package:gathrr/core/primary_button.dart';
import 'package:gathrr/view/onboard/widgets.dart';

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
                InputOtpField(
                    controller: otpController,
                    phone: widget.phone,
                    authBloc: authBloc),
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
                ResentOtpWidget(
                  state: state,
                  authBloc: authBloc,
                  phone: widget.phone,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
