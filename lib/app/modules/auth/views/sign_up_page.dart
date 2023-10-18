import 'package:care_betes/app/common/common_drop_down.dart';
import 'package:care_betes/app/common/common_scaffold.dart';
import 'package:care_betes/app/common/common_text_form_field.dart';
import 'package:care_betes/app/core/extensions/size_extension.dart';
import 'package:care_betes/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final controller = Modular.get<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return WillPopScope(
        onWillPop: () {
          return controller.goBack();
        },
        child: CommonScaffold(
          isFloatingActionButton: false,
          scaffoldKey: controller.scaffoldKey,
          height: context.screenHeight,
          scroll: const AlwaysScrollableScrollPhysics(),
          appbar: AppBar(
            elevation: 0,
            leading: BackButton(
              onPressed: () => controller.goBack(),
            ),
            backgroundColor: const Color(0XFF7EA1C1),
          ),
          body: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo_bete.png',
                  width: 150,
                ),
                const SizedBox(
                  height: 30,
                ),
                CommonTextFormField(
                  controller: controller.nameController,
                  hintText: 'Nome',
                  textInputType: TextInputType.name,
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
                  height: 10,
                ),
                CommonDropDown<TypeBetes>(
                  value: controller.typeBetes,
                  listDropDown: listBetes(),
                  onChanged: (value) => controller.changedTypeBetes(value),
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonTextFormField(
                  controller: controller.ageController,
                  hintText: 'Idade',
                  textInputType: TextInputType.number,
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
                  height: 10,
                ),
                CommonTextFormField(
                  controller: controller.weightController,
                  hintText: 'Peso',
                  textInputType: TextInputType.number,
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
                  height: 10,
                ),
                CommonTextFormField(
                  controller: controller.emailController,
                  hintText: 'E-mail',
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
                  height: 10,
                ),
                CommonTextFormField(
                  controller: controller.passwordController,
                  hintText: 'Senha',
                  obscureText: true,
                  textInputType: TextInputType.visiblePassword,
                  onTapOutside: (p0) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onFieldSubmitted: (p0) {
                    _register(context);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor preencher';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                switch (controller.busy) {
                  true => const SizedBox(
                      child: CircularProgressIndicator(
                        color: Color(0XFF7EA1C1),
                      ),
                    ),
                  false => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: context.percentWidth(0.3),
                          child: OutlinedButton(
                            onPressed: () async {
                              _register(context);
                            },
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
                        SizedBox(
                          width: context.percentWidth(0.3),
                          child: OutlinedButton(
                            onPressed: () => controller.goBack(),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            child: const Text(
                              'Voltar',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                },
              ],
            ),
          ),
        ),
      );
    });
  }

  _register(BuildContext context) async {
    if (!controller.formKey.currentState!.validate()) {
      return;
    }
    final register = await controller.register();
    if (register && context.mounted) {
      AlertDialog alert = const AlertDialog(
        title: Text("Sucesso!!!"),
        content: Text("Cadastrado com Sucesso!"),
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
      await Future.delayed(const Duration(seconds: 3));
      Modular.to.pop();
      controller.goBack();
    } else if (context.mounted) {
      AlertDialog alert = const AlertDialog(
        title: Text("Erro!!!"),
        content: Text("Erro ao Criar Cadastro"),
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
      await Future.delayed(const Duration(seconds: 3));
      Modular.to.pop();
    }
  }
}

List<DropdownMenuItem<TypeBetes>> listBetes() {
  return [
    DropdownMenuItem<TypeBetes>(
      value: TypeBetes.prediabetes,
      child: Text(TypeBetes.prediabetes.name),
    ),
    DropdownMenuItem<TypeBetes>(
      value: TypeBetes.typeOne,
      child: Text(TypeBetes.typeOne.name),
    ),
    DropdownMenuItem<TypeBetes>(
      value: TypeBetes.typeTwo,
      child: Text(TypeBetes.typeTwo.name),
    ),
    DropdownMenuItem<TypeBetes>(
      value: TypeBetes.gestationalDiabetes,
      child: Text(TypeBetes.gestationalDiabetes.name),
    ),
  ];
}
