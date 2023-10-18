import 'dart:developer';

import 'package:care_betes/app/core/database/db.dart';
import 'package:care_betes/app/modules/home/models/medical_appointment_dto.dart';
import 'package:care_betes/app/modules/home/models/medical_appointment_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class IMedicalAppointmentRepository {
  Future<bool> createMedicalAppointment(
      MedicalAppointmentDto medicationAppointmentDto);
  Future<List<MedicalAppointmentModel>> listMedicalAppointment(int userId);
  Future<bool> deleteMedicalAppointment(
      {required int idMedicationAppointment, required int userId});
}

class MedicalAppointmentRepository implements IMedicalAppointmentRepository {
  final String table = "medication_appointment_calendar";
  late Database db;

  MedicalAppointmentRepository() {
    _initRepository();
  }

  _initRepository() async {
    db = await DB.instance.database;
  }

  @override
  Future<bool> createMedicalAppointment(
      MedicalAppointmentDto medicationAppointmentDto) async {
    try {
      final result = await db.insert(table, medicationAppointmentDto.toMap());
      log("$result", name: "CreateMedicalAppointment");
      return true;
    } catch (e, s) {
      log("$e",
          name: "CreateMedicalAppointment Error", error: e, stackTrace: s);
      return false;
    }
  }

  @override
  Future<bool> deleteMedicalAppointment(
      {required int idMedicationAppointment, required int userId}) async {
    try {
      final result = await db.delete(table,
          where: "user_id = ? and id = ?",
          whereArgs: [userId, idMedicationAppointment]);
      log("$result", name: "MedicalAppointment");
      return true;
    } catch (e) {
      log("$e", name: "MedicalAppointmentError");
      return false;
    }
  }

  @override
  Future<List<MedicalAppointmentModel>> listMedicalAppointment(
      int userId) async {
    try {
      final result =
          await db.query(table, where: "user_id = ?", whereArgs: [userId]);
      log("$result", name: "ListMedicalAppointment");
      return MedicalAppointmentModel.listMedication(result);
    } catch (e) {
      log("$e", name: "ListMedicalAppointmentError");
      return [];
    }
  }
}
