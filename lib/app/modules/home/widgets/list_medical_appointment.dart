import 'package:care_betes/app/core/extensions/size_extension.dart';
import 'package:care_betes/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../common/common_text_box.dart';

class ListMedicalAppointment extends StatefulWidget {
  const ListMedicalAppointment({
    super.key,
  });

  @override
  State<ListMedicalAppointment> createState() => _ListMedicalAppointmentState();
}

class _ListMedicalAppointmentState extends State<ListMedicalAppointment> {
  final controller = Modular.get<HomeController>()..getListMedicalAppointment();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        height: context.percentHeight(.9),
        child: Column(
          children: <Widget>[
            const CommonTextBox(
              title: 'Lista de Consultas',
            ),
            const SizedBox(
              height: 20,
            ),
            switch (controller.busyGetMedical) {
              true => const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              false => Expanded(
                    child: switch (
                        controller.listMedicationAppointment == null ||
                            controller.listMedicationAppointment!.isEmpty) {
                  true => const Center(
                      child: Text('Vocë náo tem consultas cadastradas'),
                    ),
                  false => ListView.builder(
                      itemCount: controller.listMedicationAppointment?.length,
                      itemBuilder: (context, index) {
                        final medical =
                            controller.listMedicationAppointment![index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            isThreeLine: true,
                            tileColor: const Color(0XFFE3EAF0),
                            shape: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Text(
                              medical.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            textColor: Colors.black,
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${controller.getDateFormat(medical.date)} - ${medical.timer}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${medical.remember}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            subtitleTextStyle: const TextStyle(
                              fontSize: 15,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => controller
                                      .deleteMedicalAppointment(medical.id),
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                }),
            }
          ],
        ),
      );
    });
  }
}
