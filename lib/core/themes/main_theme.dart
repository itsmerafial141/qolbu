import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qolbu/core/themes/color_swatch.dart';
import 'package:qolbu/core/themes/colors.dart';
import 'package:qolbu/core/themes/fonts.dart';
import 'package:qolbu/core/utils/helpers.dart';
import 'package:qolbu/core/values/consts/double_const.dart';

ThemeData get darkTheme {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: _setColorPrimiaryIsThemeModeDark(true),
    appBarTheme: _appBarTheme(true),
    textTheme: _textTheme(true),
    switchTheme: _switchTheme(true),
    floatingActionButtonTheme: _floatingActionButtonTheme(true),
    elevatedButtonTheme: _elevatedButtonTheme(true),
    outlinedButtonTheme: _outlinedButtonTheme(true),
    textSelectionTheme: _textSelectionTheme(true),
    // primaryTextTheme: _primaryTextTheme(true),
    // colorScheme: _colorScheme(true),
    // inputDecorationTheme: _inputDecorationTheme(true),
    textButtonTheme: _textButtonTheme(), useMaterial3: false,
    menuButtonTheme: _menuButtonThemeData(),
    cardTheme: _cardThemeData(),
    iconButtonTheme: _iconButtonTheme(true),
  );
}

ThemeData get lightTheme {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFFAFAFA),
    primaryColor: _setColorPrimiaryIsThemeModeDark(false),
    appBarTheme: _appBarTheme(false),
    textTheme: _textTheme(false),
    switchTheme: _switchTheme(false),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColorSwatch.PRIMARY.shade200,
      headerForegroundColor: Colors.white,
      confirmButtonStyle: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColorSwatch.PRIMARY,
        textStyle: Fonts.poppinsBold14,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
      ),
      cancelButtonStyle: ElevatedButton.styleFrom(
        foregroundColor: AppColorSwatch.PRIMARY,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
      ),
    ),

    floatingActionButtonTheme: _floatingActionButtonTheme(false),
    elevatedButtonTheme: _elevatedButtonTheme(false),
    outlinedButtonTheme: _outlinedButtonTheme(false),
    textSelectionTheme: _textSelectionTheme(false),
    // primaryTextTheme: _primaryTextTheme(false),
    colorScheme: _colorScheme(false),
    inputDecorationTheme: _inputDecorationTheme(false),
    textButtonTheme: _textButtonTheme(),
    // menuButtonTheme: _menuButtonThemeData(),
    cardTheme: _cardThemeData(),
    iconButtonTheme: _iconButtonTheme(false),
    useMaterial3: false,
    chipTheme: ChipThemeData(
      backgroundColor: Colors.white,
      labelStyle: Fonts.poppinsRegular14.copyWith(
        color: AppColorSwatch.DISABLE.shade400,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(
          width: 1,
          color: AppColorSwatch.DISABLE.shade400,
        ),
      ),
    ),
  );
}

IconButtonThemeData _iconButtonTheme(bool isDark) {
  return const IconButtonThemeData(
    style: ButtonStyle(
      minimumSize: WidgetStatePropertyAll(Size.square(10)),
      overlayColor: WidgetStatePropertyAll(Colors.red),
      iconColor: WidgetStatePropertyAll(Colors.red),
      shadowColor: WidgetStatePropertyAll(Colors.red),
      surfaceTintColor: WidgetStatePropertyAll(Colors.red),
      backgroundColor: WidgetStatePropertyAll(Colors.red),
    ),
  );
}

TextButtonThemeData _textButtonTheme() {
  return TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: Fonts.poppinsMedium14,
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      foregroundColor: Colors.white10,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
  );
}

OutlinedButtonThemeData _outlinedButtonTheme(bool isDark) {
  return OutlinedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: _setColorPrimiaryIsThemeModeDark(isDark),
      textStyle: Fonts.poppinsSemibold16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.r),
      ),
      minimumSize: Size.fromHeight(AppDouble.BUTTON_HEIGHT.w),
      side: BorderSide(
        width: 1,
        color: _setColorPrimiaryIsThemeModeDark(isDark),
      ),
    ).merge(
      ButtonStyle(
        elevation: WidgetStateProperty.resolveWith<double>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) return 0;
            return 0;
          },
        ),
      ),
    ),
  );
}

FloatingActionButtonThemeData _floatingActionButtonTheme(bool isDark) {
  return FloatingActionButtonThemeData(
    elevation: 0,
    highlightElevation: 0,
    backgroundColor: _setColorPrimiaryIsThemeModeDark(isDark),
  );
}

SwitchThemeData _switchTheme(bool isDark) {
  return SwitchThemeData(
    thumbColor: WidgetStateProperty.all(
      _setColorIsThemeModeDark(!isDark),
    ),
    trackColor: WidgetStateProperty.all(
      _setColorIsThemeModeDark(!isDark).withValues(alpha: .5),
    ),
  );
}

TextTheme _textTheme(bool isDark) {
  return TextTheme(
    titleLarge: Fonts.poppinsSemibold16.copyWith(
      color: _setColorIsThemeModeDark(isDark),
    ),
    titleMedium: Fonts.poppinsMedium14.copyWith(
      color: _setColorIsThemeModeDark(isDark),
    ),
    titleSmall: Fonts.poppinsSemibold12.copyWith(
      color: _setColorIsThemeModeDark(isDark),
    ),
    bodyLarge: Fonts.poppinsRegular16.copyWith(
      color: _setColorIsThemeModeDark(isDark),
    ),
    bodyMedium: Fonts.poppinsRegular14.copyWith(
      color: _setColorIsThemeModeDark(isDark),
    ),
    bodySmall: Fonts.poppinsRegular12.copyWith(
      color: _setColorIsThemeModeDark(isDark),
    ),
  );
}

ElevatedButtonThemeData _elevatedButtonTheme(bool isDark) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      disabledBackgroundColor: AppColor.button.disableBackground,
      disabledForegroundColor: AppColor.button.disablePrimaryTextColor,
      foregroundColor: AppColor.button.primaryTextColor,
      backgroundColor: AppColor.button.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(99.r),
      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.w),
      textStyle: Fonts.poppinsMedium12.copyWith(
        height: (20 / 14).sp,
        color: AppColor.button.primaryTextColor,
      ),
    ).merge(
      ButtonStyle(
        elevation: WidgetStateProperty.resolveWith<double>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) return 0;
            return 0;
          },
        ),
      ),
    ),
  );
}

InputDecorationTheme _inputDecorationTheme(bool isDark) {
  return InputDecorationTheme(
    errorMaxLines: 1,
    iconColor: AppColorSwatch.DISABLE[600],
    isDense: true,
    filled: true,
    isCollapsed: false,
    fillColor: AppColor.INPUT_FILL_COLOR,
    hintStyle: Fonts.title.mediumRegular16.copyWith(
      color: AppColor.textField.textColor,
    ),
    labelStyle: Fonts.poppinsRegular14.copyWith(
      color: AppColor.textField.textColor,
    ),
    errorStyle: Fonts.poppinsRegular16.copyWith(
      color: AppColorSwatch.DANGER,
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 10.w,
      horizontal: 16.w,
    ),
    border: _OutlinedInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        width: 1.w,
        color: AppColor.textField.borderStandard,
      ),
    ),
    enabledBorder: _OutlinedInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        width: 1.w,
        color: AppColor.textField.borderStandard,
      ),
    ),
    disabledBorder: _OutlinedInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        width: 1.w,
        color: AppColor.textField.borderStandard,
      ),
    ),
    focusedBorder: _OutlinedInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        width: 1.w,
        color: AppColor.textField.focusedBorderStandard,
      ),
    ),
    errorBorder: _OutlinedInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        width: 1.w,
        color: AppColor.textField.errorBorderStandard,
      ),
    ),
    focusedErrorBorder: _OutlinedInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        width: 1.w,
        color: AppColor.textField.errorBorderStandard,
      ),
    ),
  );
}

ColorScheme _colorScheme(bool isDark) {
  return ColorScheme.fromSwatch(
    primarySwatch: AppColorSwatch.PRIMARY,
  ).copyWith(
    secondary: _setColorPrimiaryIsThemeModeDark(isDark),
  );
}

// TextTheme _primaryTextTheme(bool isDark) {
//   return TextTheme(
//     displayLarge: AppFonts.poppinsRegular16.copyWith(
//       color: _setColorIsThemeModeDark(isDark),
//     ),
//     displayMedium: AppFonts.poppinsRegular14.copyWith(
//       color: _setColorIsThemeModeDark(isDark),
//     ),
//     displaySmall: AppFonts.poppinsRegular12.copyWith(
//       color: _setColorIsThemeModeDark(isDark),
//     ),
//     headlineLarge: AppFonts.poppinsBold16.copyWith(
//       color: _setColorIsThemeModeDark(isDark),
//     ),
//     headlineMedium: AppFonts.poppinsBold14.copyWith(
//       color: _setColorIsThemeModeDark(isDark),
//     ),
//     headlineSmall: AppFonts.poppinsBold12.copyWith(
//       color: _setColorIsThemeModeDark(isDark),
//     ),
//     labelLarge: AppFonts.poppinsMedium16.copyWith(
//       color: _setColorIsThemeModeDark(isDark),
//     ),
//     labelMedium: AppFonts.poppinsMedium14.copyWith(
//       color: _setColorIsThemeModeDark(isDark),
//     ),
//     labelSmall: AppFonts.poppinsMedium12.copyWith(
//       color: _setColorIsThemeModeDark(isDark),
//     ),
//     bodyLarge: AppFonts.poppinsRegular16.copyWith(
//       color: _setColorIsThemeModeDark(isDark),
//     ),
//     bodyMedium: AppFonts.poppinsRegular14.copyWith(
//       color: _setColorIsThemeModeDark(isDark),
//     ),
//     bodySmall: AppFonts.poppinsRegular12.copyWith(
//       color: _setColorIsThemeModeDark(isDark),
//     ),
//     titleLarge: AppFonts.poppinsSemibold16.copyWith(
//       color: _setColorIsThemeModeDark(isDark),
//     ),
//     titleMedium: AppFonts.poppinsSemibold14.copyWith(
//       color: _setColorIsThemeModeDark(isDark),
//     ),
//     titleSmall: AppFonts.poppinsSemibold12.copyWith(
//       color: _setColorIsThemeModeDark(isDark),
//     ),
//   );
// }

TextSelectionThemeData _textSelectionTheme(bool isDark) {
  return TextSelectionThemeData(
    cursorColor: _setColorIsThemeModeDark(isDark),
  );
}

AppBarTheme _appBarTheme(bool isDark) {
  return AppBarTheme(
    toolbarHeight: AppDouble.APPBAR_HEIGHT.w,
    backgroundColor: AppColor.SECONDARY,
    foregroundColor: AppColor.PRIMARY,
    systemOverlayStyle: AppHelper.systemUiOverlayStyle.copyWith(
      statusBarIconBrightness: Brightness.light,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(
          AppDouble.BORDER_RADIUES.r,
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColor.PRIMARY),
    elevation: 0,
    toolbarTextStyle: const TextTheme().bodyLarge,
    titleTextStyle: Fonts.poppinsRegular16.copyWith(
      color: isDark ? AppColor.WHITE : AppColor.PRIMARY,
    ),
  );
}

MenuButtonThemeData _menuButtonThemeData() {
  return MenuButtonThemeData(
    style: MenuItemButton.styleFrom(
      disabledBackgroundColor: AppColor.INPUT_DISABLE_COLOR,
      foregroundColor: AppColor.WHITE,
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDouble.BORDER_RADIUES.r),
      ),
      minimumSize: Size.fromHeight(AppDouble.BUTTON_HEIGHT.w),
    ),
  );
}

CardTheme _cardThemeData() {
  return CardTheme(
    color: AppColor.foundations.PRIMARY_A,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 0,
    margin: EdgeInsets.zero,
  );
}

Color _setColorIsThemeModeDark(bool isDark) => isDark ? AppColor.WHITE : AppColorSwatch.TEXT;

Color _setColorPrimiaryIsThemeModeDark(bool isDark) =>
    isDark ? AppColor.SECONDARY : AppColor.foundations.PRIMARY_A;

class _OutlinedInputBorder extends InputBorder {
  const _OutlinedInputBorder({
    super.borderSide = const BorderSide(),
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
  });

  final BorderRadius borderRadius;

  @override
  bool get isOutline => false;

  @override
  _OutlinedInputBorder copyWith({
    BorderSide? borderSide,
    BorderRadius? borderRadius,
  }) {
    return _OutlinedInputBorder(
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(borderSide.width);
  }

  @override
  _OutlinedInputBorder scale(double t) {
    return _OutlinedInputBorder(
      borderSide: borderSide.scale(t),
      borderRadius: borderRadius * t,
    );
  }

  // @override
  // ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
  //   if (a is _OutlinedInputBorder) {
  //     final _OutlinedInputBorder outline = a;
  //     return _OutlinedInputBorder(
  //       borderRadius: BorderRadius.lerp(outline.borderRadius, borderRadius, t)!,
  //       borderSide: BorderSide.lerp(outline.borderSide, borderSide, t),
  //     );
  //   }
  //   return super.lerpFrom(a, t);
  // }

  // @override
  // ShapeBorder? lerpTo(ShapeBorder? b, double t) {
  //   if (b is _OutlinedInputBorder) {
  //     final _OutlinedInputBorder outline = b;
  //     return _OutlinedInputBorder(
  //       borderRadius: BorderRadius.lerp(borderRadius, outline.borderRadius, t)!,
  //       borderSide: BorderSide.lerp(borderSide, outline.borderSide, t),
  //     );
  //   }
  //   return super.lerpTo(b, t);
  // }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(borderRadius.resolve(textDirection).toRRect(rect).deflate(borderSide.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  // @override
  // void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection}) {
  //   canvas.drawRRect(borderRadius.resolve(textDirection).toRRect(rect), paint);
  // }

  // @override
  // bool get preferPaintInterior => true;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    final Paint paint = borderSide.toPaint();
    final RRect outer = borderRadius.toRRect(rect);
    final RRect center = outer.deflate(borderSide.width / 2.0);
    canvas.drawRRect(center, paint);
  }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) {
  //     return true;
  //   }
  //   if (other.runtimeType != runtimeType) {
  //     return false;
  //   }
  //   return other is _OutlinedInputBorder &&
  //       other.borderSide == borderSide &&
  //       other.borderRadius == borderRadius;
  // }

  // @override
  // int get hashCode => Object.hash(borderSide, borderRadius);
}
