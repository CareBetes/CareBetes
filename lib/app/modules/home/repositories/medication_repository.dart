import 'dart:developer';
import 'package:care_betes/app/core/database/db.dart';
import 'package:care_betes/app/modules/home/models/medication_dto.dart';
import 'package:care_betes/app/modules/home/models/medication_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class IMedicationRepository {
  Future<bool> createMedication(MedicationDto medicationDto);
  Future<List<MedicationModel>> listMedication(int userId);
  Future<bool> deleteMedication(
      {required int idMedication, required int userId});
}

class MedicationRepository implements IMedicationRepository {
  final String table = "medication_calendar";
  late Database db;

  MedicationRepository() {
    _initRepository();
  }

  _initRepository() async {
    db = await DB.instance.database;
  }

  @override
  Future<bool> createMedication(MedicationDto medicationDto) async {
    try {
      final result = await db.insert(table, medicationDto.toMap());
      log("$result", name: "CreateMedication");
      return true;
    } catch (e, s) {
      log("$e", name: "CreateMedication Error", error: e, stackTrace: s);
      return false;
    }
  }

  @override
  Future<List<MedicationModel>> listMedication(int userId) async {
    try {
      final result =
          await db.query(table, where: "user_id = ?", whereArgs: [userId]);
      log("$result", name: "FindUser");
      return MedicationModel.listMedication(result);
    } catch (e) {
      log("$e", name: "FindUserError");
      return [];
    }
  }

  @override
  Future<bool> deleteMedication({
    required int idMedication,
    required int userId,
  }) async {
    try {
      final result = await db.delete(table,
          where: "user_id = ? and id = ?", whereArgs: [userId, idMedication]);
      log("$result", name: "MedicationUser");
      return true;
    } catch (e) {
      log("$e", name: "DeleteMedicationError");
      return false;
    }
  }
}
