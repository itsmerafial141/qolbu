import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:qolbu/app/data/models/response/base_raseponse.dart';
import 'package:qolbu/app/widgets/app_skelaton_widget.dart';
import 'package:qolbu/app/widgets/app_text_form_field.dart';
import 'package:qolbu/core/extensions/widget_extension.dart';
import 'package:qolbu/core/themes/color_swatch.dart';
import 'package:qolbu/core/themes/fonts.dart';
import 'package:qolbu/core/values/consts/lottie_const.dart';
import 'package:qolbu/core/values/enums/states_enum.dart';
import 'package:qolbu/services/drawer_service.dart';

class OptionData<T> {
  final String id;
  final String label;
  final T data;

  const OptionData({
    required this.id,
    required this.label,
    required this.data,
  });
}

class MultiDrawer<T> extends StatefulWidget {
  const MultiDrawer({
    super.key,
    this.initialValue,
    required this.onCompleted,
    required this.initState,
    this.borderRadius,
    this.withSearch = false,
    this.separator,
    this.searchHint,
    this.onLoading,
    this.onEmpty,
    this.onError,
  }) : builder = null;
  const MultiDrawer.builder({
    super.key,
    this.initialValue,
    required this.onCompleted,
    required this.initState,
    required this.builder,
    this.withSearch = false,
    this.separator,
    this.searchHint,
    this.onLoading,
    this.onEmpty,
    this.onError,
  }) : borderRadius = null;

  final List<OptionData<T>>? initialValue;
  final Function(List<OptionData<T>> optionData) onCompleted;
  final Future<List<OptionData<T>>> Function() initState;
  final Widget Function(BuildContext context, OptionData<T> optionData, bool isSelected)? builder;
  final BorderRadius? borderRadius;
  final bool? withSearch;
  final Widget? separator;
  final String? searchHint;
  final Widget? onLoading;
  final Widget? onEmpty;
  final Widget? onError;

  @override
  State<MultiDrawer<T>> createState() => MultiDrawerState<T>();
}

class MultiDrawerState<T> extends State<MultiDrawer<T>> {
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
    await widget.initState().then((value) {
      if (value.isEmpty) {
        state = States.EMPTY;
      } else {
        state = States.SUCCESS;
      }
      data = value;
      tData = widget.initialValue ?? [];
      setState(() {});
    }).onError((BaseResponse error, __) {
      errorMessage = error.message;
      state = States.ERROR;
      setState(() {});
    });
  }

  void _onSearchChanged(String value) async {
    if (value.isEmpty) {
      data = await widget.initState();
      if (data.isEmpty) {
        state = States.EMPTY;
      } else {
        state = States.SUCCESS;
      }
      state = States.SUCCESS;
      setState(() {});
      return;
    }
    data = data.where((element) {
      return element.label.toLowerCase().contains(value.toLowerCase());
    }).toList();

    if (data.isEmpty) {
      state = States.EMPTY;
    } else {
      state = States.SUCCESS;
    }
    setState(() {});
  }

  void _onParticipantTapped(OptionData<T> selectedData) {
    if (_isParticipantRegistered(selectedData)) {
      tData.removeWhere((element) => element.id == selectedData.id);
    } else {
      tData.add(selectedData);
    }
    setState(() {});
  }

  void _onDoneTapped() {
    DrawerService.close();
    widget.onCompleted(tData);
  }

  bool _isParticipantRegistered(OptionData<T> selectedData) {
    return tData.where((element) => element.id == selectedData.id).isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 16.verticalSpace,
        // _header().marginSymmetric(horizontal: 16.w),
        // 16.verticalSpace,
        if (widget.withSearch ?? false) ...[
          if (state.isSuccess || state.isEmpty) ...[
            AppTextFormField(
              label: widget.searchHint ?? "Cari data...",
              controller: searchController,
              onChanged: _onSearchChanged,
              prefixIcon: const Icon(Icons.search_rounded),
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
            addAutomaticKeepAlives: true,
            cacheExtent: double.infinity,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (_, index) {
              var currentData = tData[index];
              return _tile(currentData);
            },
            separatorBuilder: (_, __) =>
                widget.separator ??
                Divider(
                  thickness: 1.w,
                  height: 1.w,
                  color: AppColorSwatch.PRIMARY.shade200,
                ),
            itemCount: tData.length,
          ),
        if (state.isLoading)
          if (widget.onLoading == null)
            Skelaton(
              height: 50.w,
              width: double.infinity,
            ).shimmer()
          else
            widget.onLoading!,
        if (state.isEmpty) ...[
          if (widget.onEmpty == null) ...[
            16.verticalSpace,
            LottieBuilder.asset(
              AppLottie.empty,
              height: 150.w,
              width: 150.w,
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
              height: 150.w,
              width: 150.w,
              fit: BoxFit.fitWidth,
            ),
            Text(
              errorMessage ?? "Terjadi Kesalahan",
              style: Fonts.poppinsBold14,
            ),
          ] else
            widget.onError!,
        ],
        16.verticalSpace,
        ElevatedButton(
          onPressed: _onDoneTapped,
          child: const Text("Done"),
        ),
        16.verticalSpace,
      ],
    );
  }

  Widget _tile(OptionData<T> currentData) {
    return MaterialButton(
      onPressed: () => _onParticipantTapped(currentData),
      elevation: 0,
      highlightElevation: 0,
      padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
      color: _isParticipantRegistered(currentData) ? AppColorSwatch.PRIMARY.shade200 : null,
      shape: _isParticipantRegistered(currentData)
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: const BorderSide(width: 1, color: AppColorSwatch.PRIMARY),
            )
          : null,
      child: _child(currentData),
    ).innerShadow();
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
          if (_isParticipantRegistered(dataTile))
            Icon(
              Icons.check_circle_outline_rounded,
              size: 20.w,
              color: AppColorSwatch.PRIMARY,
            ),
        ],
      );
    } else {
      return widget.builder!(context, dataTile, _isParticipantRegistered(dataTile));
    }
  }
}
