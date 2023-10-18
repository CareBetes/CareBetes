// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:care_betes/app/app_controller.dart';
import 'package:care_betes/app/modules/auth/models/user_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:care_betes/app/modules/auth/repositories/auth_repository.dart';
part 'auth_controller.g.dart';

enum TypeBetes {
  prediabetes("Pré-diabetes"),
  typeOne("Diabetes tipo 1"),
  typeTwo("Diabetes tipo 2"),
  gestationalDiabetes("Diabetes Gestacional");

  final String name;
  const TypeBetes(this.name);
}

class AuthController = AuthControllerBase with _$AuthController;

abstract class AuthControllerBase with Store {
  AuthControllerBase(
    this.repository,
  );

  final appController = Modular.get<AppController>();

  @observable
  bool busy = false;

  UserDto? userDto;
  final IAuthRepository repository;

  final formKey = GlobalKey<FormState>();
  final formKeyLogin = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @observable
  TypeBetes typeBetes = TypeBetes.prediabetes;

  @action
  changedTypeBetes(TypeBetes? value) {
    typeBetes = value!;
  }

  @action
  Future<bool> register() async {
    if (formKey.currentState!.validate()) {
      busy = true;
      await Future.delayed(const Duration(seconds: 3));
      userDto = UserDto(
        name: nameController.text,
        betesType: typeBetes.name,
        age: int.parse(ageController.text),
        weight: double.parse(weightController.text),
        email: emailController.text,
        password: passwordController.text,
      );
      if (userDto == null) return false;
      final result = await repository.createUser(userDto!);
      busy = false;
      return result;
    }
    busy = false;
    return false;
  }

  @action
  Future<bool> login() async {
    if (formKeyLogin.currentState!.validate()) {
      busy = true;
      await Future.delayed(const Duration(seconds: 3));
      appController.user = await repository.findUser(
        email: emailLoginController.text,
        password: passwordLoginController.text,
      );
      if (appController.user != null) {
        await saveUser(appController.user!.id);
      }
      busy = false;
      return appController.user != null;
    }
    return false;
  }

  saveUser(int id) async {
    await repository.saveUser(id);
  }

  @action
  goBack() {
    nameController.text = '';
    typeBetes = TypeBetes.prediabetes;
    weightController.text = '';
    ageController.text = '';
    emailController.text = '';
    emailLoginController.text = '';
    passwordController.text = '';
    passwordLoginController.text = '';
    Modular.to.pushReplacementNamed('signin');
    return true;
  }
}
