import 'package:flutter/material.dart';
import 'package:gathrr/core/consts.dart';
import 'package:gathrr/core/primary_button.dart';
import 'package:gathrr/presentation/onboard/login_signup_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body:

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          kheight40,
          Center(
            child: Image.asset(
              "assets/obboard_gahtrr.png",
              height: 80,
            ),
          ),
          const Text(
            'Gathrr: Where Events\nCome to Life, Effortlessly!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          Center(
            child: Image.asset(
              "assets/onbaord_networking.png",
            ),
          ),
          kheight20,
          PrimaryButton(
              onTap: () {
                Get.to(() => const LoginSignUpScreen());
              },
              title: "Get Started"),
        ],
      ),
    );
  }
}
