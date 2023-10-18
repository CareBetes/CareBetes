import 'package:care_betes/app/modules/auth/controllers/auth_controller.dart';
import 'package:care_betes/app/modules/auth/views/sign_in_page.dart';
import 'package:care_betes/app/modules/auth/views/sign_up_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'repositories/auth_repository.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(AuthController.new);
    i.add<IAuthRepository>(AuthRepository.new);
  }

  @override
  void routes(r) {
    r.child('/signin',
        child: (context) => SignInPage(),
        transition: TransitionType.rightToLeft);
    r.child('/signup',
        child: (context) => SignUpPage(),
        transition: TransitionType.rightToLeft);
  }
}
