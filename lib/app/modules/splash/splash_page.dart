import 'package:care_betes/app/modules/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final controller = Modular.get<SplashController>()..start();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFF7EA1C1),
        body: Center(
          child: Image.asset("assets/images/logo_bete.png", width: 250),
        ),
      ),
    );
  }
}
