import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:qolbu/app/data/models/auth_model.dart';
import 'package:qolbu/app/data/models/user_model.dart';
import 'package:qolbu/core/values/consts/hive_box_const.dart';
import 'package:qolbu/core/values/keys/hive_box_name_key.dart';

mixin HiveService implements HiveBox {
  static Future<void> initialize() async {
    try {
      await Hive.initFlutter();
      await _initializeAdpter();
      await _initializeBox();
      "Success Initialize Hive".printInfo(info: "HIVE");
    } catch (e) {
      "Error Initialize Hive : $e".printError(info: "HIVE");
    }
  }

  static Future<void> _initializeAdpter() async {
    if (!Hive.isAdapterRegistered(AuthModelAdapter().typeId)) {
      Hive.registerAdapter(AuthModelAdapter());
    }
    if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
      Hive.registerAdapter(UserModelAdapter());
    }
  }

  static Future<void> _initializeBox() async {
    if (!Hive.isBoxOpen(HiveBoxName.data)) {
      HiveBox.data = await Hive.openBox(HiveBoxName.data);
    }
    if (!Hive.isBoxOpen(HiveBoxName.config)) {
      HiveBox.config = await Hive.openBox(HiveBoxName.config);
    }
  }

  static Future<void> closeAllBox() async {
    if (Hive.isBoxOpen(HiveBoxName.data)) HiveBox.data.close();
    if (Hive.isBoxOpen(HiveBoxName.config)) HiveBox.config.close();
  }
}
