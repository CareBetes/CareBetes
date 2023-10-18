import 'package:care_betes/app/common/common_scaffold.dart';
import 'package:care_betes/app/common/common_text_box.dart';
import 'package:care_betes/app/core/extensions/size_extension.dart';
import 'package:care_betes/app/modules/home/controllers/home_controller.dart';
import 'package:care_betes/app/modules/home/widgets/list_medical_appointment.dart';
import 'package:care_betes/app/modules/home/widgets/list_medication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeController>()..init();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return CommonScaffold(
          appbar: AppBar(
            elevation: 0,
            backgroundColor: const Color(0XFF7EA1C1),
            leading: IconButton(
              onPressed: () {
                showAdaptiveDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog.adaptive(
                      title: const Text(
                        'Deseja sair?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        OutlinedButton(
                          onPressed: () async {
                            await controller.logout();
                          },
                          child: const Text('sim'),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Modular.to.pop();
                          },
                          child: const Text('não'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ),
          scroll: const AlwaysScrollableScrollPhysics(),
          isFloatingActionButton: true,
          height: context.screenHeight,
          padding:
              const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 20),
          body: switch (controller.busy) {
            true => const SizedBox(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0XFF7EA1C1),
                  ),
                ),
              ),
            false => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bem vindo ${controller.userModel!.firstName()}',
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      switch (controller.busyGetMedical) {
                        true => const SizedBox(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color(0XFF7EA1C1),
                              ),
                            ),
                          ),
                        false => CommonTextBox(
                            title: 'Próximo medicamento:',
                            subTitle: controller.medicationModel == null
                                ? 'Sem medicamento registrado'
                                : controller.medicationModel!.timer,
                          ),
                      },
                      const SizedBox(
                        height: 30,
                      ),
                      switch (controller.busyGetMedical) {
                        true => const SizedBox(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color(0XFF7EA1C1),
                              ),
                            ),
                          ),
                        false => CommonTextBox(
                            title: 'Próxima consulta:',
                            subTitle: controller.medicationAppointmentModel ==
                                    null
                                ? 'Sem consulta registrado'
                                : '${controller.getDateFormat(controller.medicationAppointmentModel!.date)} - ${controller.medicationAppointmentModel!.timer}',
                          ),
                      },
                      const SizedBox(
                        height: 70,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CommonTextBox(
                            width: 0,
                            fontSize: 13,
                            title: 'Medicamentos',
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return const ListMedication();
                                },
                              );
                            },
                          ),
                          CommonTextBox(
                            width: 0,
                            fontSize: 13,
                            title: 'Dicas',
                            onTap: () {
                              Modular.to.pushNamed('tips');
                            },
                          ),
                          CommonTextBox(
                            width: 0,
                            fontSize: 13,
                            title: 'Consultas',
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return const ListMedicalAppointment();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Column(
                    children: [
                      Text(
                        'Atenção ao rótulo dos alimentos!',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'O açúcar pode estar presente em alguns\nprodutos com outros nomes, como sacarose,\nfrutose, maltodextrina, xarope de milho,\nxarope de malte e açúcar invertido.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 150,
                      ),
                    ],
                  ),
                ],
              ),
          });
    });
  }
}
