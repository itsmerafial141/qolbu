import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qolbu/app/widgets/app_scaffold_widget.dart';

import '../controllers/recite_controller.dart';

class ReciteView extends GetView<ReciteController> {
  const ReciteView({super.key});
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: const Center(
        child: Text(
          'ReciteView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
