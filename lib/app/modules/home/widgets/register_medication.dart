import 'package:care_betes/app/common/common_checkbox.dart';
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

class RegisterMedication extends StatefulWidget {
  const RegisterMedication({super.key});

  @override
  State<RegisterMedication> createState() => _RegisterMedicationState();
}

class _RegisterMedicationState extends State<RegisterMedication> {
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
              key: controller.keyMedical,
              child: Column(
                children: <Widget>[
                  const CommonTextBox(
                    title: 'Cadastrar Novo Medicamento',
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
                              controller: controller.titleMedicationController,
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
                              dateController:
                                  controller.timerMedicationController,
                              isOnlyTimer: true,
                              hintText: 'Hora',
                              onChanged: controller.setTimer,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CommonCheckbox(
                                  value: controller.sunday,
                                  dayOfWeek: 7,
                                  title: 'D',
                                  onChanged: controller.repeat,
                                ),
                                CommonCheckbox(
                                  value: controller.monday,
                                  dayOfWeek: 1,
                                  title: 'S',
                                  onChanged: controller.repeat,
                                ),
                                CommonCheckbox(
                                  value: controller.tuesday,
                                  dayOfWeek: 2,
                                  title: 'T',
                                  onChanged: controller.repeat,
                                ),
                                CommonCheckbox(
                                  value: controller.wednesday,
                                  dayOfWeek: 3,
                                  title: 'Q',
                                  onChanged: controller.repeat,
                                ),
                                CommonCheckbox(
                                  value: controller.thursday,
                                  dayOfWeek: 4,
                                  title: 'Q',
                                  onChanged: controller.repeat,
                                ),
                                CommonCheckbox(
                                  value: controller.friday,
                                  dayOfWeek: 5,
                                  title: 'S',
                                  onChanged: controller.repeat,
                                ),
                                CommonCheckbox(
                                  value: controller.saturday,
                                  dayOfWeek: 6,
                                  title: 'S',
                                  onChanged: controller.repeat,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CommonTextFormField(
                              controller: controller.rememberMedicalController,
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
                                    if (!controller.keyMedical.currentState!
                                        .validate()) {
                                      return;
                                    }

                                    await controller.createMedication();
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
