import 'package:care_betes/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'splash_controller.g.dart';

class SplashController = SplashControllerBase with _$SplashController;

abstract class SplashControllerBase with Store {
  final appController = Modular.get<AppController>();

  start() async {
    await Future.delayed(const Duration(seconds: 3));
    await appController.getUserLogged();
    if (appController.user != null) {
      return Modular.to.pushReplacementNamed('/home/');
    }
    return Modular.to.pushReplacementNamed('/auth/signin');
  }
}
