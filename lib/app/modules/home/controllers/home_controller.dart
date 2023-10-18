import 'dart:async';
import 'dart:math';
import 'package:care_betes/app/app_controller.dart';
import 'package:care_betes/app/core/config_init/config_init.dart';
import 'package:care_betes/app/modules/auth/models/user_model.dart';
import 'package:care_betes/app/modules/home/models/medical_appointment_dto.dart';
import 'package:care_betes/app/modules/home/models/medical_appointment_model.dart';
import 'package:care_betes/app/modules/home/models/medication_dto.dart';
import 'package:care_betes/app/modules/home/models/medication_model.dart';
import 'package:care_betes/app/modules/home/repositories/medical_appointment_repository.dart';
import 'package:care_betes/app/modules/home/repositories/medication_repository.dart';
import 'package:care_betes/app/modules/notification/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../notification/controllers/notification_controller.dart';
part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  HomeControllerBase(
    this.medicationRepository,
    this.medicalAppointmentRepository,
  );

  final notificationController = Modular.get<NotificationController>();

  @observable
  bool monday = false;

  @observable
  bool tuesday = false;

  @observable
  bool wednesday = false;

  @observable
  bool thursday = false;

  @observable
  bool friday = false;

  @observable
  bool saturday = false;

  @observable
  bool sunday = false;

  @observable
  TextEditingController titleMedicationController = TextEditingController();

  @observable
  TextEditingController timerMedicationController = TextEditingController();

  @observable
  TextEditingController repeatAtMedicalController = TextEditingController();

  @observable
  TextEditingController rememberMedicalController = TextEditingController();

  @observable
  TextEditingController titleMedicalAppointmentController =
      TextEditingController();

  @observable
  TextEditingController dateMedicalAppointmentController =
      TextEditingController();

  @observable
  TextEditingController dateMedicalAppointmentAtController =
      TextEditingController();

  @observable
  TextEditingController rememberAtMedicalAppointmentController =
      TextEditingController();

  @observable
  TextEditingController rememberMedicalAppointmentController =
      TextEditingController();

  final _appController = Modular.get<AppController>();
  final IMedicationRepository medicationRepository;
  final IMedicalAppointmentRepository medicalAppointmentRepository;

  @observable
  UserModel? userModel;

  @observable
  List<MedicationModel>? listMedication;

  @observable
  List<MedicalAppointmentModel>? listMedicationAppointment;

  @observable
  MedicationDto? medicationDto;

  @observable
  String? dateMedicalAppointment;

  @observable
  String? timerMedicalAppointment;

  @observable
  String? dateMedicalAppointmentAt;

  @observable
  String? timerMedicalAppointmentAt;

  @observable
  MedicalAppointmentDto? medicationAppointmentDto;

  @observable
  MedicationModel? medicationModel;

  @observable
  MedicalAppointmentModel? medicationAppointmentModel;

  @observable
  bool busy = false;

  @observable
  bool busyCreateMedical = false;

  @observable
  bool busyGetMedical = false;

  @observable
  List<int> listWeek = [];

  @observable
  var keyMedical = GlobalKey<FormState>();

  @observable
  var keyMedicalAppointment = GlobalKey<FormState>();

  @action
  init() async {
    busy = true;
    await getUser();
    await getListMedication();
    await getListMedicalAppointment();
    await verifyNotification();
    await permiss();
    busy = false;
  }

  @action
  getUser() {
    return userModel = _appController.user;
  }

  @action
  Future permiss() async {
    await Permission.notification.request();
  }

  @action
  setDate(String? value) {
    if (value != null && value.isNotEmpty) {
      dateMedicalAppointmentController.text =
          '${getDateTimeAppointment(value).date} ${getDateTimeAppointment(value).timer}';
      dateMedicalAppointmentAtController.text =
          dateMedicalAppointmentController.text;
      getDateTimeAppointmentAt(value);
    }
  }

  @action
  setDateAt(String? value) {
    if (value != null && value.isNotEmpty) {
      dateMedicalAppointmentAtController.text =
          '${getDateTimeAppointmentAt(value).date} ${getDateTimeAppointmentAt(value).timer}';
    }
  }

  @action
  setTimer(String? value) {
    if (value != null && value.isNotEmpty) {
      timerMedicationController.text = value;
    }
  }

  @action
  Future createMedication() async {
    if (keyMedical.currentState!.validate()) {
      busyCreateMedical = true;
      await Future.delayed(const Duration(seconds: 3));
      medicationDto = MedicationDto(
        userId: userModel!.id,
        title: titleMedicationController.text,
        timer: timerMedicationController.text,
        repeatAt: listWeek,
        remember: rememberMedicalController.text.isEmpty
            ? null
            : rememberMedicalController.text,
      );
      if (medicationDto == null) return busyCreateMedical = false;
      final result =
          await medicationRepository.createMedication(medicationDto!);
      if (result) {
        await getListMedication();
        await sheduleMedication(NotificationModel(
          id: Random(1000).nextInt(1000),
          body: medicationDto!.remember ?? '',
          payload: '/',
          title: medicationDto!.title,
          days: medicationDto!.repeatAt,
          schedule: timerMedicationController.text,
        ));
      }
      busyCreateMedical = false;
      if (result) {
        back();
      }
    }
    busyCreateMedical = false;
  }

  @action
  Future getListMedication() async {
    busyGetMedical = true;
    final dateNow = DateTime.now();
    List<MedicationModel> listMedicationResult = [];
    listMedication = await medicationRepository.listMedication(userModel!.id);
    medicationModel = null;

    if (listMedication != null && listMedication!.isNotEmpty) {
      listMedication!.sort((a, b) => a.timer.compareTo(b.timer));
      for (var medication in listMedication!) {
        if (medication.repeatAt.contains(dateNow.weekday)) {
          var date = DateTime.parse(
              '${dateNow.year}-${dateNow.month}-${dateNow.day} ${medication.timer}');
          if (dateNow.isBefore(date)) {
            listMedicationResult.add(medication);
            medicationModel = listMedicationResult[0];
          }
        }
      }
      for (var medication in listMedication!) {
        if (!medication.repeatAt.contains(dateNow.weekday)) {
          listMedicationResult.add(medication);
          medicationModel ??= listMedicationResult[0];
        }
      }
      if (listMedicationResult.isNotEmpty) {
        listMedicationResult.sort((a, b) => a.timer.compareTo(b.timer));
      }
    }
    busyGetMedical = false;
  }

  @action
  ({String date, String timer}) getDateTimeAppointment(String value) {
    var values = value.split(' ');
    dateMedicalAppointment = values[0];
    timerMedicalAppointment = values[1];
    final date = DateTime.parse(values[0]);
    var format = DateFormat('dd/MM/yyyy').format(date);
    return (date: format, timer: values[1]);
  }

  @action
  ({String date, String timer}) getDateTimeAppointmentAt(String value) {
    var values = value.split(' ');
    dateMedicalAppointmentAt = values[0];
    timerMedicalAppointmentAt = values[1];
    final date = DateTime.parse(values[0]);
    var format = DateFormat('dd/MM/yyyy').format(date);
    return (date: format, timer: values[1]);
  }

  @action
  repeat(Map<String, dynamic> map) {
    switch (map['dayOfWeek']) {
      case 1:
        map['value']
            ? listWeek.add(1)
            : listWeek.removeWhere((day) => day == 1);
        return monday = map['value'];
      case 2:
        map['value']
            ? listWeek.add(2)
            : listWeek.removeWhere((day) => day == 2);
        return tuesday = map['value'];
      case 3:
        map['value']
            ? listWeek.add(3)
            : listWeek.removeWhere((day) => day == 3);
        return wednesday = map['value'];
      case 4:
        map['value']
            ? listWeek.add(4)
            : listWeek.removeWhere((day) => day == 4);
        return thursday = map['value'];
      case 5:
        map['value']
            ? listWeek.add(5)
            : listWeek.removeWhere((day) => day == 5);
        return friday = map['value'];
      case 6:
        map['value']
            ? listWeek.add(6)
            : listWeek.removeWhere((day) => day == 6);
        return saturday = map['value'];
      case 7:
        map['value']
            ? listWeek.add(7)
            : listWeek.removeWhere((day) => day == 7);
        return sunday = map['value'];
    }
  }

  @action
  Future deleteMedication(int idMedication) async {
    busyGetMedical = true;
    final result = await medicationRepository.deleteMedication(
      idMedication: idMedication,
      userId: userModel!.id,
    );
    if (result) {
      if (idMedication == medicationModel!.id) {
        medicationModel = null;
      }
      await getListMedication();
      if (listMedication != null && listMedication!.isNotEmpty) {
        medicationModel = listMedication![0];
      }
    }
    busyGetMedical = false;
  }
  ////appointment

  @action
  Future createMedicalAppointment() async {
    if (keyMedicalAppointment.currentState!.validate()) {
      busyCreateMedical = true;
      await Future.delayed(const Duration(seconds: 3));
      medicationAppointmentDto = MedicalAppointmentDto(
        userId: userModel!.id,
        title: titleMedicalAppointmentController.text,
        date: dateMedicalAppointment!,
        timer: timerMedicalAppointment!,
        rememberAtDate: dateMedicalAppointmentAt,
        rememberAtTimer: timerMedicalAppointmentAt,
        remember: rememberMedicalAppointmentController.text.isEmpty
            ? null
            : rememberMedicalAppointmentController.text,
      );
      if (medicationAppointmentDto == null) return busyCreateMedical = false;
      final result = await medicalAppointmentRepository
          .createMedicalAppointment(medicationAppointmentDto!);
      if (result) {
        await getListMedicalAppointment();
        await sheduleMedicalAppointment(
          NotificationModel(
              id: Random(1000).nextInt(1000),
              body: medicationAppointmentDto!.remember ?? '',
              payload: '/',
              title: medicationAppointmentDto!.title,
              schedule:
                  '${dateMedicalAppointmentAt!} ${timerMedicalAppointmentAt!}'),
        );
      }
      busyCreateMedical = false;
      if (result) {
        back();
      }
    }
    busyCreateMedical = false;
  }

  @action
  getListMedicalAppointment() async {
    busyGetMedical = true;
    final dateNow = DateTime.now();
    listMedicationAppointment = null;
    List<MedicalAppointmentModel> listMedicalResult = [];
    listMedicationAppointment = await medicalAppointmentRepository
        .listMedicalAppointment(userModel!.id);
    if (listMedicationAppointment != null &&
        listMedicationAppointment!.isNotEmpty) {
      listMedicationAppointment!.sort(
        (a, b) => a.dateFull!.compareTo(b.dateFull!),
      );

      for (var medical in listMedicationAppointment!) {
        var date = DateTime.parse(medical.dateFull!);
        if (dateNow.isBefore(date)) {
          listMedicalResult.add(medical);
        }
      }

      if (listMedicalResult.isNotEmpty) {
        listMedicalResult.sort(
          (a, b) => a.dateFull!.compareTo(b.dateFull!),
        );
        medicationAppointmentModel = listMedicalResult[0];
      }
    }
    busyGetMedical = false;
  }

  @action
  Future deleteMedicalAppointment(int idMedication) async {
    busyGetMedical = true;
    final result = await medicalAppointmentRepository.deleteMedicalAppointment(
      idMedicationAppointment: idMedication,
      userId: userModel!.id,
    );
    if (result) {
      if (idMedication == medicationAppointmentModel!.id) {
        medicationAppointmentModel = null;
      }
      await getListMedicalAppointment();
      if (listMedicationAppointment != null &&
          listMedicationAppointment!.isNotEmpty) {
        medicationAppointmentModel = listMedicationAppointment![0];
      }
    }
    busyGetMedical = false;
  }

  @action
  back() {
    titleMedicationController.text = '';
    titleMedicalAppointmentController.text = '';
    timerMedicationController.text = '';
    dateMedicalAppointmentAtController.text = '';
    dateMedicalAppointmentController.text = '';
    rememberAtMedicalAppointmentController.text = '';
    repeatAtMedicalController.text = '';
    rememberMedicalController.text = '';
    rememberMedicalAppointmentController.text = '';
    monday = false;
    tuesday = false;
    wednesday = false;
    thursday = false;
    friday = false;
    saturday = false;
    sunday = false;
    listWeek = [];
    Modular.to.pop();
  }

  @action
  List<String> daysOfWeekWord(MedicationModel medication) {
    List<String> listDaysWeek = [];

    List<int> list = medication.repeatAt;

    for (var element in list) {
      switch (element) {
        case 1:
          listDaysWeek.add("SEG");
        case 2:
          listDaysWeek.add("TER");
        case 3:
          listDaysWeek.add("QUA");
        case 4:
          listDaysWeek.add("QUI");
        case 5:
          listDaysWeek.add("SEX");
        case 6:
          listDaysWeek.add("SAB");
        case 7:
          listDaysWeek.add("DOM");
      }
    }
    return listDaysWeek;
  }

  getDateFormat(String value) {
    final date = DateTime.parse(value);
    var format = DateFormat('dd/MM/yyyy').format(date);
    return format;
  }

  @action
  sheduleMedication(NotificationModel notification) async {
    await notificationController.scheduleNotification(
      days: notification.days!,
      notificationModel: notification,
      scheduleNotificationDateTime: notification.schedule!,
    );
  }

  @action
  sheduleMedicalAppointment(NotificationModel notification) async {
    await notificationController.scheduleNotification(
      notificationModel: notification,
      scheduleNotificationDateTime: notification.schedule!,
    );
  }

  @action
  Future verifyNotification() async {
    var dateNow = DateTime.now();
    var validNotification = ConfigInit.prefs.getString('validNotification');
    if (validNotification != null) {
      var dateValid = DateTime.parse(validNotification);

      if (dateNow.isBefore(dateValid)) {
        await _listNotification();
        await ConfigInit.prefs
            .setString('validNotification', dateNow.toString());
      }
    } else {
      await _listNotification();
      await ConfigInit.prefs.setString('validNotification', dateNow.toString());
    }
  }

  @action
  Future _listNotification() async {
    if (listMedication != null && listMedication!.isNotEmpty) {
      for (var element in listMedication!) {
        var notificationModel = NotificationModel(
          id: element.id,
          body: element.remember,
          days: element.repeatAt,
          title: element.title,
          payload: '/',
          schedule: element.timer,
        );
        await sheduleMedication(notificationModel);
      }
    }
  }

  @action
  bool validDate(MedicationModel medication) {
    final dateNow = DateTime.now();
    var date = DateTime.parse(
        '${dateNow.year}-${dateNow.month}-${dateNow.day} ${medication.timer}');
    if (!dateNow.isBefore(date)) {
      return false;
    }
    return true;
  }

  @action
  Future logout() async {
    final resutl = await ConfigInit.prefs.clear();
    if (resutl) {
      _appController.user = null;
      Modular.to.pushReplacementNamed('/');
    }
  }
}
