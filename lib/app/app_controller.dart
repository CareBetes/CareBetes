import 'package:care_betes/app/modules/auth/models/user_model.dart';
import 'package:care_betes/app/modules/auth/repositories/auth_repository.dart';
import 'package:mobx/mobx.dart';
part 'app_controller.g.dart';

class AppController = AppControllerBase with _$AppController;

abstract class AppControllerBase with Store {
  AppControllerBase(this.repository);

  @observable
  UserModel? user;

  final IAuthRepository repository;

  @action
  Future<UserModel?> getUserLogged() async {
    final user = await repository.getUserLogged();
    if (user != null) {
      return this.user = user;
    }
    return null;
  }
}
