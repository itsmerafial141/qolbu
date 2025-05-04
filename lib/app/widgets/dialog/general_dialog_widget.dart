import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qolbu/app/widgets/dialog/double_button_dialog_widget.dart';
import 'package:qolbu/app/widgets/dialog/single_button_dialog.dart';
import 'package:qolbu/core/extensions/font_extension.dart';
import 'package:qolbu/core/themes/color_swatch.dart';
import 'package:qolbu/core/themes/fonts.dart';
import 'package:qolbu/core/utils/helpers.dart';
import 'package:qolbu/core/values/consts/svg_asset_const.dart';
import 'package:qolbu/services/dialog_service.dart';
import 'package:qolbu/services/flavor_service.dart';

class GeneralDialog extends StatelessWidget {
  final void Function()? onPressed;
  final String textButton;
  final String icon;
  final String label;
  final List<TextDescription>? textDescriptions;
  final IconDecoration? iconDecoration;

  const GeneralDialog({
    super.key,
    this.onPressed,
    required this.textButton,
    this.icon = AppSvg.icAlert,
    required this.label,
    this.textDescriptions,
    this.iconDecoration,
  });

  const factory GeneralDialog.error({
    void Function()? onPressed,
    String textButton,
    String icon,
    String label,
    String? errorText,
    IconDecoration? iconDecoration,
    List<TextDescription>? textDescriptions,
  }) = _ErrorGeneralDialog;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 41.w),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 17.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                icons(
                  backgroundColor: iconDecoration?.backgroundColor,
                  forgroundColor: iconDecoration?.forgroundColor,
                ),
                15.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        label,
                        style: Fonts.poppinsSemibold16.fh(22.4.w),
                      ),
                      if (textDescriptions?.isNotEmpty ?? false) ...[
                        5.verticalSpaceFromWidth,
                        RichText(
                          text: TextSpan(
                            style: Fonts.poppinsRegular14
                                .copyWith(color: AppColorSwatch.NETRAL.shade500)
                                .fh(19.6),
                            children: textDescriptions?.map(
                              (e) {
                                return TextSpan(text: e.text, style: e.textStyle);
                              },
                            ).toList(),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ],
            ),
            _errorWidget,
            25.verticalSpaceFromWidth,
            ElevatedButton(
              onPressed: onPressed != null ? onPressed! : DialogService.instance.close,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 25.w),
              ),
              child: Text(textButton),
            ),
          ],
        ),
      ),
    );
  }

  Container icons({
    Color? backgroundColor = const Color(0xFFC3F4F2),
    Color? forgroundColor = AppColorSwatch.PRIMARY,
  }) {
    return Container(
      height: 40.w,
      width: 40.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: Center(
        child: SvgPicture.asset(
          icon,
          width: 20.w,
          height: 20.w,
          // fit: BoxFit.scaleDown,
          // ignore: deprecated_member_use
          color: forgroundColor,
        ),
      ),
    );
  }

  Widget get _errorWidget => const SizedBox();
}

class _ErrorGeneralDialog extends GeneralDialog {
  final String? errorText;
  const _ErrorGeneralDialog({
    super.onPressed,
    super.textButton = "Tutup",
    super.icon,
    super.label = "Terjadi kesalahan",
    super.textDescriptions,
    super.iconDecoration,
    this.errorText,
  });

  @override
  Container icons({
    Color? backgroundColor = const Color(0xFFC3F4F2),
    Color? forgroundColor = AppColorSwatch.PRIMARY,
  }) {
    return super.icons(
      backgroundColor: iconDecoration?.backgroundColor ?? AppColorSwatch.DANGER.shade200,
      forgroundColor: iconDecoration?.forgroundColor ?? AppColorSwatch.DANGER,
    );
  }

  @override
  Widget get _errorWidget {
    if (!FlavorServices.instance.flavor.isDevelopment || errorText == null) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        25.verticalSpaceFromWidth,
        ExpansionTile(
          title: const Text("Error Data"),
          tilePadding: EdgeInsets.zero,
          shape: Border(
            top: BorderSide(width: 1.w, color: AppColorSwatch.NETRAL.shade200),
            bottom: BorderSide(width: 1.w, color: AppColorSwatch.NETRAL.shade200),
          ),
          collapsedShape: Border(
            top: BorderSide(width: 1.w, color: AppColorSwatch.NETRAL.shade200),
            bottom: BorderSide(width: 1.w, color: AppColorSwatch.NETRAL.shade200),
          ),
          childrenPadding: EdgeInsets.symmetric(vertical: 8.w),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              errorText ?? "",
              style: Fonts.poppinsRegular12.copyWith(color: AppColorSwatch.NETRAL),
            ),
            8.verticalSpaceFromWidth,
            ElevatedButton(
              onPressed: () => _onTapCopy(errorText ?? ""),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
                backgroundColor: AppColorSwatch.PRIMARY.shade200,
                foregroundColor: AppColorSwatch.PRIMARY,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.copy_rounded,
                    color: AppColorSwatch.PRIMARY,
                    size: 18.w,
                  ),
                  8.horizontalSpace,
                  const Text("Salin"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _onTapCopy(String s) {
    Clipboard.setData(ClipboardData(text: s));
    AppHelper.rawSanckBar(
      backgroundColor: AppColorSwatch.PRIMARY.shade200,
      style: Fonts.poppinsRegular12.copyWith(color: AppColorSwatch.PRIMARY),
      message: "Berhasil salin data",
    );
  }
}
