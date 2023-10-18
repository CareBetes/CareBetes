import 'package:care_betes/app/modules/splash/controllers/splash_controller.dart';
import 'package:care_betes/app/modules/splash/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends Module {
  @override
  void binds(i) {
    i.add(SplashController.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => SplashPage(),
    );
  }
}
