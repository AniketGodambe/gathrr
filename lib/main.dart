import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gathrr/core/colors.dart';
import 'package:gathrr/core/security.dart';
import 'package:gathrr/presentation/onboard/splash_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  GetStorage.init().then((value) {});
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: const SplashScreen(),
        theme: ThemeData(
            useMaterial3: false,
            fontFamily: "Lato",
            appBarTheme: const AppBarTheme(
              backgroundColor: kwhite,
              iconTheme: IconThemeData(color: Color(0xff8C8C8C), size: 30),
              elevation: 0,
              centerTitle: false,
              titleTextStyle: TextStyle(
                fontFamily: "Lato",
                fontSize: 20,
                color: kblack,
                fontWeight: FontWeight.w600,
              ),
            ),
            scaffoldBackgroundColor: bgColor,
            colorScheme: ColorScheme.fromSeed(
              seedColor: primaButtonColor,
            )),
      ),
    );
  }
}
