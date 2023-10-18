import 'package:care_betes/app/core/config_init/config_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app/app_modular.dart';
import 'app/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ConfigInit();

  runApp(
    ModularApp(
      module: AppModular(),
      child: const AppWidget(),
    ),
  );
}
