import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qolbu/app/controllers/juz_controller.dart';
import 'package:qolbu/app/data/models/juz_model.dart';
import 'package:qolbu/app/modules/home/controllers/home_controller.dart';
import 'package:qolbu/app/widgets/app_skelaton_widget.dart';
import 'package:qolbu/core/extensions/widget_extension.dart';
import 'package:qolbu/core/themes/colors.dart';
import 'package:qolbu/core/themes/fonts.dart';
import 'package:qolbu/core/values/consts/svg_asset_const.dart';

class JuzComponent extends StatefulWidget {
  const JuzComponent({super.key});

  @override
  State<JuzComponent> createState() => _JuzComponentState();
}

class _JuzComponentState extends State<JuzComponent> with AutomaticKeepAliveClientMixin {
  JuzController get controller => JuzController.find;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SmartRefresher(
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoading: () => controller.onLoadMore(false),
      enablePullUp: true,
      physics: BouncingScrollPhysics(),
      footer: CustomFooter(builder: customFooterBuilder),
      child: controller.obx(
        (data) {
          return listComponent(
              itemCount: data?.$1?.ayahs?.length ?? 0,
              child: (context, index) {
                var juzArabic = data!.$1!.ayahs![index];
                var juzLatin = data.$2!.ayahs![index];
                return JuzTile(
                  data: (juzArabic, juzLatin),
                  index: index,
                  onTap: controller.onTapJuz,
                );
              });
        },
        onLoading: onLoading.shimmer(),
      ),
    );
  }

  Widget customFooterBuilder(BuildContext context, LoadStatus? mode) {
    return switch (mode) {
      // LoadStatus.loading => JuzTile.loading().shimmer().margin(horizontal: 24.w),
      // LoadStatus.canLoading => Text(
      //     "Lepaskan untuk memuat lebih banyak",
      //     textAlign: TextAlign.center,
      //     style: Fonts.poppinsRegular12.copyWith(
      //       color: AppColor.PRIMARY.withValues(alpha: .5),
      //     ),
      //   ),
      LoadStatus.canLoading || LoadStatus.loading => ElevatedButton(
          onPressed: HomeController.find.onTapSeeAllJuz,
          child: Text("Lihat Semua Juz"),
        ).margin(horizontal: 24.w),
      LoadStatus.failed => Text(
          "Gagal memuat, coba lagi",
          textAlign: TextAlign.center,
          style: Fonts.poppinsRegular12.copyWith(
            color: AppColor.PRIMARY.withValues(alpha: .5),
          ),
        ),
      _ => Text(
          "Tidak ada lagi data",
          textAlign: TextAlign.center,
          style: Fonts.poppinsRegular12.copyWith(
            color: AppColor.PRIMARY.withValues(alpha: .5),
          ),
        ),
    };
  }

  ListView listComponent({
    required Widget Function(BuildContext context, int index) child,
    required int itemCount,
    ScrollPhysics? physics,
  }) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 24.w),
      physics: physics ?? BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return child(context, index);
      },
      separatorBuilder: (context, index) {
        return Divider(
          thickness: 1.w,
          height: 1.w,
          color: AppColor.DISABLE,
        ).margin(vertical: 8.w);
      },
      itemCount: itemCount,
    );
  }

  Widget get onLoading {
    return listComponent(
      itemCount: 10,
      physics: NeverScrollableScrollPhysics(),
      child: (context, index) => JuzTile.loading(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class JuzTile extends StatelessWidget {
  final bool? isLoading;
  final (Ayah, Ayah)? data;
  final int? index;
  final void Function((Ayah, Ayah) data)? onTap;

  const JuzTile._({this.isLoading, this.data, this.onTap, this.index});

  factory JuzTile.loading() => JuzTile._(isLoading: true);

  factory JuzTile({
    required (Ayah, Ayah) data,
    required int index,
    required void Function((Ayah, Ayah) data) onTap,
  }) {
    return JuzTile._(data: data, onTap: onTap, index: index);
  }

  // void _onTap() {
  //   if (onTap != null) onTap!(data!);
  // }

  @override
  Widget build(BuildContext context) {
    return _buttonTile();
    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(8.r),
    //   child: Theme(
    //     data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
    //     child: ExpansionTile(
    //       title: _buttonTile(),
    //       tilePadding: EdgeInsets.zero,
    //       dense: true,
    //       childrenPadding: EdgeInsets.zero,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(8.r),
    //       ),
    //       showTrailingIcon: false,
    //       onExpansionChanged: (value) {},
    //       children: [
    //         Container(
    //           padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
    //           decoration: BoxDecoration(
    //             color: AppColor.SECONDARY.withValues(alpha: .2),
    //             borderRadius: BorderRadius.circular(8.r),
    //           ),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.stretch,
    //             children: [
    //               Text(
    //                 data?.text ?? '',
    //                 style: Fonts.poppinsSemibold14.copyWith(color: AppColor.PRIMARY),
    //               ),
    //               8.verticalSpaceFromWidth,
    //               HtmlWidget(
    //                 data?.deskripsi ?? '',
    //                 textStyle: Fonts.poppinsRegular12,
    //                 customStylesBuilder: (element) {
    //                   if (element.localName == 'i') {
    //                     return {
    //                       'font-weight': 'bold',
    //                       'color': '#18392B',
    //                     };
    //                   }
    //                   return null;
    //                 },
    //               ),
    //             ],
    //           ),
    //         ),
    //         8.verticalSpaceFromWidth,
    //         SizedBox(
    //           width: double.infinity,
    //           child: ElevatedButton(
    //             onPressed: (isLoading ?? false) ? null : _onTap,
    //             child: Text("Baca Juz"),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget _buttonTile() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          indexTile(),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isLoading ?? false)
                  Skelaton.text(width: 100.w, height: 24.w)
                else
                  Text(data?.$1.text ?? "", style: Fonts.poppinsMedium16),
                if (isLoading ?? false)
                  Skelaton.text(width: 100.w, height: 24.w)
                else
                  Text(
                    data?.$2.text ?? "",
                    style: Fonts.poppinsRegular12.copyWith(
                      color: AppColor.RomanSilver,
                    ),
                  ),
                // 4.verticalSpaceFromWidth,
                // if (isLoading ?? false)
                //   Skelaton.text(width: 200.w)
                // else
                //   Row(
                //     children: [
                //       Flexible(
                //         child: Text(
                //           (data?. ?? '').toUpperCase(),
                //           maxLines: 1,
                //           overflow: TextOverflow.ellipsis,
                //           style: Fonts.poppinsMedium12.copyWith(
                //             color: AppColor.RomanSilver,
                //           ),
                //         ),
                //       ),
                //       5.horizontalSpace,
                //       Icon(Icons.circle, size: 4.w, color: AppColor.RomanSilver),
                //       5.horizontalSpace,
                //       Flexible(
                //         child: Text(
                //           "${data?.jumlahAyat ?? 0} AYAT",
                //           maxLines: 1,
                //           overflow: TextOverflow.ellipsis,
                //           style: Fonts.poppinsMedium12.copyWith(
                //             color: AppColor.RomanSilver,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
              ],
            ),
          ),
          // 16.horizontalSpace,
          // if (isLoading ?? false)
          //   Skelaton.text(width: 50.w, height: 30.w)
          // else
          //   Text(
          //     data?.nama ?? '',
          //     style: GoogleFonts.amiri(
          //       color: AppColor.PRIMARY,
          //       fontWeight: FontWeight.bold,
          //       fontSize: 20.sp,
          //     ),
          //   ),
        ],
      ),
    );
  }

  Widget indexTile() {
    if (isLoading ?? false) return Skelaton(width: 36.w, height: 36.w, borderRadius: 99.r);
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          AppSvg.icArabicBorder,
          width: 36.w,
          height: 36.w,
        ),
        Text(((index ?? 0) + 1).toString(), style: Fonts.poppinsMedium14),
      ],
    );
  }
}
