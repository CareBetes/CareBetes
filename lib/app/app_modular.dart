import 'package:care_betes/app/app_controller.dart';
import 'package:care_betes/app/modules/auth/auth_module.dart';
import 'package:care_betes/app/modules/home/home_module.dart';
import 'package:care_betes/app/modules/notification/controllers/notification_controller.dart';
import 'package:care_betes/app/modules/splash/splash_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/auth/repositories/auth_repository.dart';

class AppModular extends Module {
  @override
  void binds(i) {
    i.addSingleton(AppController.new);
    i.addSingleton<IAuthRepository>(AuthRepository.new);
    i.addSingleton(NotificationController.new);
  }

  @override
  void exportedBinds(i) {}

  @override
  void routes(r) {
    r.module('/', module: SplashModule());
    r.module('/home', module: HomeModule());
    r.module('/auth', module: AuthModule());
  }
}
