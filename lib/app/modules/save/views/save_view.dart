import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qolbu/app/widgets/app_scaffold_widget.dart';

import '../controllers/save_controller.dart';

class SaveView extends GetView<SaveController> {
  const SaveView({super.key});
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: const Center(
        child: Text(
          'SaveView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
