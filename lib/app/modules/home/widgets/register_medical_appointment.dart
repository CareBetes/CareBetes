import 'package:care_betes/app/common/common_date_field.dart';
import 'package:care_betes/app/common/common_outlined_button.dart';
import 'package:care_betes/app/common/common_scaffold.dart';
import 'package:care_betes/app/common/common_text_form_field.dart';
import 'package:care_betes/app/core/extensions/size_extension.dart';
import 'package:care_betes/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../common/common_text_box.dart';

class RegisterMedicalAppointment extends StatelessWidget {
  RegisterMedicalAppointment({super.key});

  final controller = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      isFloatingActionButton: false,
      height: context.screenHeight,
      body: SingleChildScrollView(
        child: Observer(builder: (context) {
          return Container(
            color: const Color(0XFFE3EAF0),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            height: context.percentHeight(.9),
            child: Form(
              key: controller.keyMedicalAppointment,
              child: Column(
                children: <Widget>[
                  const CommonTextBox(
                    title: 'Cadastrar Nova Consulta',
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Observer(builder: (_) {
                    return Expanded(
                      child: SizedBox(
                        width: context.percentWidth(.8),
                        child: ListView(
                          children: [
                            CommonTextFormField(
                              controller:
                                  controller.titleMedicalAppointmentController,
                              hintText: 'Título',
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
                            CommonDateField(
                              isOnlyTimer: false,
                              hintText: 'Data e Hora',
                              dateController:
                                  controller.dateMedicalAppointmentController,
                              onChanged: controller.setDate,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CommonDateField(
                              isOnlyTimer: false,
                              hintText: 'Lembrar em',
                              dateController:
                                  controller.dateMedicalAppointmentAtController,
                              onChanged: controller.setDateAt,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CommonTextFormField(
                              controller: controller
                                  .rememberMedicalAppointmentController,
                              hintText: 'Lembrete',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor preencher';
                                }
                                return null;
                              },
                            ),
                            switch (controller.busyCreateMedical) {
                              true => const SizedBox(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0XFF7EA1C1),
                                    ),
                                  ),
                                ),
                              false => CommonOutlinedButton(
                                  onPressed: () async {
                                    if (!controller
                                        .keyMedicalAppointment.currentState!
                                        .validate()) {
                                      return;
                                    }

                                    await controller.createMedicalAppointment();
                                  },
                                  text: 'Cadastrar',
                                ),
                            },
                            CommonOutlinedButton(
                              onPressed: () => controller.back(),
                              text: 'Voltar',
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
