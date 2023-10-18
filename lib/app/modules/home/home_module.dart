import 'package:care_betes/app/modules/home/controllers/home_controller.dart';
import 'package:care_betes/app/modules/home/home_page.dart';
import 'package:care_betes/app/modules/home/repositories/medical_appointment_repository.dart';
import 'package:care_betes/app/modules/home/repositories/medication_repository.dart';
import 'package:care_betes/app/modules/home/view/tips.dart';
import 'package:care_betes/app/modules/home/widgets/register_medical_appointment.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'widgets/register_medication.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(HomeController.new);
    i.addSingleton<IMedicationRepository>(MedicationRepository.new);
    i.addSingleton<IMedicalAppointmentRepository>(
        MedicalAppointmentRepository.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
    r.child('/register_medication',
        child: (context) => const RegisterMedication());
    r.child('/register_medical_appointment',
        child: (context) => RegisterMedicalAppointment());
    r.child('/tips', child: (context) => const Tips());
  }
}
