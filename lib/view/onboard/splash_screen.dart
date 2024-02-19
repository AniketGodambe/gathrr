import 'package:flutter/material.dart';
import 'package:gathrr/core/colors.dart';
import 'package:gathrr/core/consts.dart';
import 'package:gathrr/core/primary_button.dart';
import 'package:gathrr/view/events/event_list_screen.dart';
import 'package:gathrr/view/onboard/login_signup_screen.dart';
import 'package:gathrr/view/root_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    loginCheckFn();
    super.initState();
  }

  bool isLoding = true;

  void loginCheckFn() {
    Future.delayed(const Duration(milliseconds: 600), () {
      final GetStorage storage = GetStorage();
      if (storage.read('appState') == "login") {
        Get.offAll(() => const RootPage());
      } else {
        setState(() {
          isLoding = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoding
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  kheight40,
                  const CircularProgressIndicator(),
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
                      color: kblack,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
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
                      color: kblack,
                      fontSize: 24,
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
            ),
    );
  }
}
