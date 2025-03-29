import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qolbu/app/widgets/app_scaffold_widget.dart';

import '../controllers/memorize_controller.dart';

class MemorizeView extends GetView<MemorizeController> {
  const MemorizeView({super.key});
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: const Center(
        child: Text(
          'MemorizeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
