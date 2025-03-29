import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/surah_controller.dart';

class SurahView extends GetView<AllSurahController> {
  const SurahView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SurahView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SurahView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
