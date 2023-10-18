import 'dart:developer';
import 'package:care_betes/app/core/config_init/config_init.dart';
import 'package:care_betes/app/core/database/db.dart';
import 'package:care_betes/app/modules/auth/models/user_dto.dart';
import 'package:care_betes/app/modules/auth/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class IAuthRepository {
  Future<bool> createUser(UserDto userDto);
  Future<UserModel?> findUser(
      {required String email, required String password});
  Future<UserModel?> getUserLogged();
  Future<bool> saveUser(int id);
}

class AuthRepository implements IAuthRepository {
  late Database db;
  final String table = "user";

  AuthRepository() {
    _initRepository();
  }

  _initRepository() async {
    db = await DB.instance.database;
  }

  @override
  Future<bool> createUser(UserDto userDto) async {
    try {
      final result = await db.insert(table, userDto.toMap());
      log("$result", name: "CreateUser");
      return true;
    } catch (e, s) {
      log("$e", name: "CreateUser Error", error: e, stackTrace: s);
      return false;
    }
  }

  @override
  Future<UserModel?> findUser(
      {required String email, required String password}) async {
    try {
      final result = await db.query(table,
          where: "email = ? and password = ?", whereArgs: [email, password]);
      log("$result", name: "FindUser");
      return UserModel.fromMap(result[0]);
    } catch (e) {
      log("$e", name: "FindUserError");
      return null;
    }
  }

  Future<UserModel?> _getUserId(int id) async {
    try {
      final result = await db.query(table, where: "id = ?", whereArgs: [id]);
      log("$result", name: "FindUser");
      return UserModel.fromMap(result[0]);
    } catch (e) {
      log("$e", name: "FindUserError");
      return null;
    }
  }

  @override
  Future<UserModel?> getUserLogged() async {
    final id = ConfigInit.prefs.getInt('idUser');
    if (id == null) return null;
    return await _getUserId(id);
  }

  @override
  Future<bool> saveUser(int id) async {
    return await ConfigInit.prefs.setInt('idUser', id);
  }
}
