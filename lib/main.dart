import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gathrr/core/colors.dart';
import 'package:gathrr/core/security.dart';
import 'package:gathrr/presentation/events/event_list_screen.dart';
import 'package:get/get.dart';

void main() {
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
        home: const EventListPage(),
        theme: ThemeData(
            useMaterial3: false,
            fontFamily: "Lato",
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
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
