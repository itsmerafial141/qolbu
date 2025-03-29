import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qolbu/app/widgets/app_scaffold_widget.dart';

import '../controllers/retain_controller.dart';

class RetainView extends GetView<RetainController> {
  const RetainView({super.key});
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: const Center(
        child: Text(
          'RetainView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
