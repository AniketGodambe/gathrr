import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gathrr/bloc/auth/auth_bloc.dart';
import 'package:gathrr/core/colors.dart';
import 'package:gathrr/core/consts.dart';
import 'package:gathrr/core/custom_textstyle.dart';
import 'package:gathrr/core/primary_button.dart';
import 'package:gathrr/core/text_field.dart';

class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignUpScreen> createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  final TextEditingController phoneController = TextEditingController();
  final AuthBloc authBloc = AuthBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
            bloc: authBloc,
            listenWhen: (previous, current) => current is AuthInitial,
            buildWhen: (previous, current) => current is! AuthInitial,
            listener: (context, state) {},
            builder: (context, state) {
              return SingleChildScrollView(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Padding(
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
                            state.runtimeType == LoginState
                                ? "Join Gathrr"
                                : 'Login to Gathrr',
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
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const ShapeDecoration(
                        color: kwhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kheight10,
                          const Text(
                            'Phone number',
                            style: TextStyle(
                              color: kblack,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          kheight20,
                          CustomInputField(
                            textController: phoneController,
                            hintText: 'Please enter your phone number',
                            onChanged: (val) {},
                            title: '',
                            textInputType: TextInputType.number,
                            maxLength: 10,
                            readOnly: false,
                            validator: (val) {
                              if (state.runtimeType == AutEmptyPhoneState) {
                                return "Enter phone";
                              }
                              return null;
                            },
                          ),
                          kheight40,
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'By proceeding you agree to our ',
                                  style: subtitleStyle.copyWith(fontSize: 16),
                                ),
                                const TextSpan(
                                    text: 'Terms',
                                    style: loginregistertextStyle),
                                TextSpan(
                                  text: ' & ',
                                  style: subtitleStyle.copyWith(fontSize: 16),
                                ),
                                const TextSpan(
                                    text: 'Conditions',
                                    style: loginregistertextStyle),
                                TextSpan(
                                  text: ' ',
                                  style: subtitleStyle.copyWith(fontSize: 16),
                                ),
                                const TextSpan(
                                    text: 'Privacy Policies',
                                    style: loginregistertextStyle),
                              ],
                            ),
                          ),
                          kheight40,
                          PrimaryButton(
                            isLoading: state.runtimeType == AuthLodingState,
                            onTap: () {
                              authBloc.add(AuthLoginEvent(
                                  phone: phoneController.text,
                                  isNavigation: true));
                            },
                            title: "Login",
                          ),
                          kheight40,
                          Row(
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
                                    authBloc.add(const ChangeObnoardModeEvent(
                                        mode: 'login'));
                                  }
                                },
                                child: Text(
                                  state.runtimeType == LoginState
                                      ? "login"
                                      : 'Register',
                                  style: loginregistertextStyle.copyWith(
                                      fontSize: 20),
                                ),
                              )
                            ],
                          ),
                          kheight40,
                          kheight20,
                        ],
                      ),
                    )
                  ],
                ),
              ));
            }));
  }
}
