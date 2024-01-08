import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gathrr/presentation/onboard/otp_screen.dart';
import 'package:get/get.dart';
import 'package:gathrr/bloc/onboard_bloc.dart';
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
  final OnBoardBlock onBoardBlock = OnBoardBlock();

  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [],
      child: Scaffold(
        body: SingleChildScrollView(
          child: StreamBuilder(
            stream: onBoardBlock.titleStream,
            initialData: false,
            builder: (context, snapshot) {
              final bool joinGathrr = snapshot.data!;
              return SizedBox(
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
                            joinGathrr ? 'Join Gathrr' : 'Login to Gathrr',
                            style: titleStyle.copyWith(fontSize: 30),
                          ),
                          kheight20,
                          Text(
                            joinGathrr
                                ? 'Join Gathrr to attend events and network with people from your industry.\n'
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
                        color: Colors.white,
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
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          kheight20,
                          CustomInputField(
                            initialValue: "",
                            hintText: 'Please enter your phone number',
                            onChanged: (val) {},
                            title: '',
                            textInputType: TextInputType.number,
                            maxLength: 10,
                            readOnly: false,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter state";
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
                            onTap: () {
                              onBoardBlock.sendOtp(mobile: '');

                              // onBoardBlock.onboardController

                              Get.to(() => const OtpScreen());
                            },
                            title: "Login",
                          ),
                          kheight40,
                          GestureDetector(
                            onTap: () {
                              onBoardBlock.updateTitle(!joinGathrr);
                            },
                            child: Center(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '${joinGathrr ? "Already have an account?" : "New to gathrr?"} ',
                                      style:
                                          subtitleStyle.copyWith(fontSize: 20),
                                    ),
                                    TextSpan(
                                        text:
                                            ' ${joinGathrr ? 'Login' : 'Register'}',
                                        style: loginregistertextStyle.copyWith(
                                            fontSize: 20)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          kheight40,
                          kheight20,
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
