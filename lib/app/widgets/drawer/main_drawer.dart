import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:qolbu/app/widgets/app_skelaton_widget.dart';
import 'package:qolbu/app/widgets/app_text_form_field.dart';
import 'package:qolbu/app/widgets/drawer/multi_drawer.dart';
import 'package:qolbu/core/extensions/widget_extension.dart';
import 'package:qolbu/core/themes/color_swatch.dart';
import 'package:qolbu/core/themes/fonts.dart';
import 'package:qolbu/core/values/consts/lottie_const.dart';
import 'package:qolbu/core/values/enums/states_enum.dart';
import 'package:qolbu/services/drawer_service.dart';

class MainDrawer<T> extends StatefulWidget {
  const MainDrawer({
    super.key,
    this.initialValue,
    required this.onItemSelected,
    required this.initState,
    this.borderRadius,
    this.withSearch = false,
    this.separator,
    this.searchHint,
    this.onLoading,
    this.onEmpty,
    this.onError,
  }) : builder = null;
  const MainDrawer.builder({
    super.key,
    this.initialValue,
    required this.onItemSelected,
    required this.initState,
    required this.builder,
    this.withSearch = false,
    this.separator,
    this.searchHint,
    this.onLoading,
    this.onEmpty,
    this.onError,
  }) : borderRadius = null;
  final String? initialValue;
  final Function(OptionData<T> optionData) onItemSelected;
  final Future<List<OptionData<T>>> Function() initState;
  final Widget Function(
    BuildContext context,
    OptionData<T> optionData,
  )? builder;
  final BorderRadius? borderRadius;
  final bool? withSearch;
  final Widget? separator;
  final String? searchHint;
  final Widget? onLoading;
  final Widget? onEmpty;
  final Widget? onError;

  @override
  State<MainDrawer<T>> createState() => _MainDrawerState<T>();
}

class _MainDrawerState<T> extends State<MainDrawer<T>> {
  late TextEditingController searchController;
  late List<OptionData<T>> data;
  late List<OptionData<T>> tData;

  String? errorMessage;
  States state = States.LOADING;

  @override
  void dispose() {
    searchController.dispose();
    data.clear();
    tData.clear();
    super.dispose();
  }

  @override
  void initState() {
    _initializeData();
    _initializeInit();
    super.initState();
  }

  void _initializeData() {
    searchController = TextEditingController();
    data = [];
    tData = [];
  }

  void _initializeInit() async {
    try {
      await widget.initState().then((value) {
        if (value.isEmpty) {
          state = States.EMPTY;
        } else {
          state = States.SUCCESS;
        }
        data = value;
        tData = value;
        setState(() {});
      }).onError((String message, __) {
        errorMessage = message;
        state = States.ERROR;
        setState(() {});
      });
    } catch (e, s) {
      e.printError(info: "INIT DATA DRAWER ERROR");
      s.printError(info: "INIT DATA DRAWER STACK TRACE");
    }
  }

  void _onSearchChanged(String value) {
    if (value.isEmpty) {
      data = tData;
      if (data.isEmpty) {
        state = States.EMPTY;
      } else {
        state = States.SUCCESS;
      }
      state = States.SUCCESS;
      setState(() {});
      return;
    }
    data = tData.where((element) {
      return element.label.toLowerCase().contains(value.toLowerCase());
    }).toList();
    if (data.isEmpty) {
      state = States.EMPTY;
    } else {
      state = States.SUCCESS;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.withSearch ?? false) ...[
          if (state.isSuccess || state.isEmpty) ...[
            AppTextFormField(
              label: widget.searchHint ?? "Cari data...",
              controller: searchController,
              onChanged: _onSearchChanged,
              prefixIcon: Icon(
                Icons.search_rounded,
                size: 24.w,
              ),
              prefixIconConstraints: BoxConstraints(minWidth: 50.w),
            ),
            8.verticalSpace
          ],
          if (state.isLoading) ...[
            AppTextFormField(
              label: widget.searchHint ?? "Cari data...",
              controller: searchController,
              onChanged: _onSearchChanged,
              prefixIcon: const Icon(Icons.search_rounded),
            ).shimmer(),
            8.verticalSpace
          ],
          if (state.isError) const SizedBox(),
        ],
        if (state.isSuccess)
          ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              var dataTile = data[index];
              return MaterialButton(
                onPressed: () {
                  DrawerService.close();
                  widget.onItemSelected(dataTile);
                },
                padding: EdgeInsets.all(12.w),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: Colors.transparent,
                elevation: 0,
                highlightElevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(4.r),
                ),
                child: _child(dataTile),
              ).innerShadow();
            },
            separatorBuilder: (_, __) => widget.separator ?? 12.verticalSpace,
            itemCount: data.length,
          ),
        if (state.isLoading)
          if (widget.onLoading == null)
            Skelaton(
              height: 50.h,
              width: double.infinity,
            ).shimmer()
          else
            widget.onLoading!,
        if (state.isEmpty) ...[
          if (widget.onEmpty == null) ...[
            16.verticalSpace,
            LottieBuilder.asset(
              AppLottie.empty,
              height: 150.h,
              width: 150.h,
              fit: BoxFit.fitWidth,
            ),
            Text(
              "Data tidak ditemukan",
              style: Fonts.poppinsMedium14,
            ),
          ] else
            widget.onEmpty!,
        ],
        if (state.isError) ...[
          if (widget.onError == null) ...[
            16.verticalSpace,
            LottieBuilder.asset(
              AppLottie.error,
              height: 150.h,
              width: 150.h,
              fit: BoxFit.fitWidth,
            ),
            Text(
              errorMessage ?? "Terjadi Kesalahan",
              style: Fonts.poppinsMedium14,
            ),
          ] else
            widget.onError!,
        ],
        16.verticalSpace,
      ],
    );
  }

  Widget _child(OptionData<T> dataTile) {
    if (widget.builder == null) {
      return Row(
        children: [
          Expanded(
            child: Text(
              dataTile.label,
              style: Fonts.poppinsRegular13,
            ),
          ),
          8.horizontalSpace,
          if (isSelected(dataTile))
            Icon(
              Icons.check_circle_outline_rounded,
              size: 20.w,
              color: AppColorSwatch.PRIMARY,
            ),
        ],
      );
    } else {
      return widget.builder!(context, dataTile);
    }
  }

  bool isSelected(OptionData<dynamic> dataTile) {
    return widget.initialValue == dataTile.label || widget.initialValue == dataTile.id;
  }
}
