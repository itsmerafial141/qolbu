import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({
    super.key,
    required this.barrierDismissible,
  });

  final bool barrierDismissible;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: kDebugMode ? true : barrierDismissible,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // const SizedBox().backgroundColor(color: const Color(0x20000000)),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SizedBox(
                  width: 56.w,
                  height: 56.w,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xff3C3C3C)),
                    strokeWidth: 7.w,
                    strokeCap: StrokeCap.round,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
