import 'package:flutter/material.dart';
import 'package:gathrr/core/colors.dart';
import 'package:gathrr/core/consts.dart';
import 'package:gathrr/core/custom_textstyle.dart';
import 'package:gathrr/core/primary_button.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                  color: Colors.white,
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
                  cursorColor: Colors.black,
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
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.white,
                  enableActiveFill: true,
                  onCompleted: (v) {},
                  onChanged: (value) {},
                  beforeTextPaste: (text) {
                    return true;
                  },
                  appContext: context,
                ),
              ),
              kheight40,
              PrimaryButton(
                onTap: () {
                  Get.to(() => const OtpScreen());
                },
                title: "Verify",
              ),
              kheight40,
              GestureDetector(
                onTap: () {},
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Didn’t receive it? ',
                          style: subtitleStyle.copyWith(fontSize: 20),
                        ),
                        TextSpan(
                            text: 'Tap to resend',
                            style:
                                loginregistertextStyle.copyWith(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
