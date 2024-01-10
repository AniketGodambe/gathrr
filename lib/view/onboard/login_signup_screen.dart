import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gathrr/bloc/auth/auth_bloc.dart';
import 'package:gathrr/core/colors.dart';
import 'package:gathrr/core/consts.dart';
import 'package:gathrr/core/primary_button.dart';
import 'package:gathrr/core/text_field.dart';
import 'package:gathrr/view/onboard/widgets.dart';

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
              bool isChecked = false;

              if (state is CheckboxState) {
                isChecked = state.isChecked;
              } else {
                isChecked = false;
              }
              return SingleChildScrollView(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    ContentWidget(state: state),
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
                          phoneInputField(state),
                          kheight40,
                          TermsAndCondtionsTextWidget(isChecked: isChecked),
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
                          LoginRegistedSwitchWidget(
                              state: state, authBloc: authBloc),
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

  CustomInputField phoneInputField(AuthState state) {
    return CustomInputField(
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
    );
  }
}
