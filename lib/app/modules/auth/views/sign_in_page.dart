import 'package:care_betes/app/common/common_scaffold.dart';
import 'package:care_betes/app/common/common_text_form_field.dart';
import 'package:care_betes/app/core/extensions/size_extension.dart';
import 'package:care_betes/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final controller = Modular.get<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return CommonScaffold(
        isFloatingActionButton: false,
        scroll: const AlwaysScrollableScrollPhysics(),
        height: context.screenHeight,
        body: Form(
          key: controller.formKeyLogin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              Image.asset(
                'assets/images/logo_bete.png',
                width: 150,
              ),
              const SizedBox(
                height: 40,
              ),
              CommonTextFormField(
                controller: controller.emailLoginController,
                hintText: 'E-mail ',
                icon: const Icon(Icons.email),
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onTapOutside: (p0) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor preencher';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              CommonTextFormField(
                controller: controller.passwordLoginController,
                hintText: 'Senha ',
                obscureText: true,
                textInputType: TextInputType.visiblePassword,
                icon: const Icon(Icons.lock),
                onTapOutside: (p0) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onFieldSubmitted: (p0) {
                  _login(context);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor preencher';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              switch (controller.busy) {
                true => const SizedBox(
                    child: CircularProgressIndicator(
                      color: Color(0XFF7EA1C1),
                    ),
                  ),
                false => SizedBox(
                    width: context.percentWidth(0.3),
                    child: OutlinedButton(
                      onPressed: () async {
                        _login(context);
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
              },
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Não tem uma conta?',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: context.percentWidth(0.3),
                child: OutlinedButton(
                  onPressed: () => Modular.to.pushReplacementNamed('signup'),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  _login(BuildContext context) async {
    if (!controller.formKeyLogin.currentState!.validate()) {
      return;
    }
    final login = await controller.login();
    if (login && context.mounted) {
      AlertDialog alert = const AlertDialog(
        title: Text("Sucesso!!!"),
        content: Text("Autenticado com Sucesso!"),
        actions: [],
      );
      showAdaptiveDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: true,
        builder: (context) {
          return alert;
        },
      );
      await Future.delayed(const Duration(seconds: 2));
      Modular.to.pop();
      Modular.to.pushReplacementNamed('/home');
    } else if (context.mounted) {
      AlertDialog alert = const AlertDialog(
        title: Text("Erro!!!"),
        content: Text("Erro ao Autenticar"),
        actions: [],
      );
      showAdaptiveDialog(
        context: context,
        useRootNavigator: true,
        barrierDismissible: false,
        builder: (context) {
          return alert;
        },
      );
      await Future.delayed(const Duration(seconds: 3));
      Modular.to.pop();
    }
  }
}
