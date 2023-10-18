import 'package:care_betes/app/common/common_text_box.dart';
import 'package:care_betes/app/core/extensions/size_extension.dart';
import 'package:care_betes/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ListMedication extends StatefulWidget {
  const ListMedication({
    super.key,
  });

  @override
  State<ListMedication> createState() => _ListMedicationState();
}

class _ListMedicationState extends State<ListMedication> {
  final controller = Modular.get<HomeController>()..getListMedication();

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
              title: 'Lista de Medicamentos',
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
                    child: switch (controller.listMedication == null ||
                        controller.listMedication!.isEmpty) {
                  true => const Center(
                      child: Text('Vocë náo tem medicamentos cadastrados'),
                    ),
                  false => ListView.builder(
                      itemCount: controller.listMedication?.length,
                      itemBuilder: (context, index) {
                        final medical = controller.listMedication![index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
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
                            textColor: controller.validDate(medical)
                                ? Colors.black
                                : Colors.black12,
                            subtitle: Text(
                              '${medical.timer} - ${controller.daysOfWeekWord(medical).join(" ")} ',
                            ),
                            subtitleTextStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      controller.deleteMedication(medical.id),
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
