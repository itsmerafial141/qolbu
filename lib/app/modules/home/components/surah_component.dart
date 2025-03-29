import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qolbu/app/controllers/surah_controller.dart';
import 'package:qolbu/app/data/models/surah_model.dart';
import 'package:qolbu/app/modules/home/controllers/home_controller.dart';
import 'package:qolbu/app/widgets/app_skelaton_widget.dart';
import 'package:qolbu/core/extensions/widget_extension.dart';
import 'package:qolbu/core/themes/colors.dart';
import 'package:qolbu/core/themes/fonts.dart';
import 'package:qolbu/core/values/consts/svg_asset_const.dart';

class SurahComponent extends StatefulWidget {
  const SurahComponent({super.key});

  @override
  State<SurahComponent> createState() => _SurahComponentState();
}

class _SurahComponentState extends State<SurahComponent> with AutomaticKeepAliveClientMixin {
  SurahController get controller => SurahController.find;

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
            itemCount: data?.length ?? 0,
            child: (context, index) {
              var surah = data![index];
              return SurahTile(
                data: surah,
                index: index,
                onTap: controller.onTapSurah,
              );
            },
          );
        },
        onLoading: onLoading.shimmer(),
      ),
    );
  }

  Widget customFooterBuilder(BuildContext context, LoadStatus? mode) {
    return switch (mode) {
      // LoadStatus.loading => SurahTile.loading().shimmer().margin(horizontal: 24.w),
      // LoadStatus.canLoading => Text(
      //     "Lepaskan untuk memuat lebih banyak",
      //     textAlign: TextAlign.center,
      //     style: Fonts.poppinsRegular12.copyWith(
      //       color: AppColor.PRIMARY.withValues(alpha: .5),
      //     ),
      //   ),
      LoadStatus.canLoading || LoadStatus.loading => ElevatedButton(
          onPressed: HomeController.find.onTapSeeAllSurah,
          child: Text("Lihat Semua Surah"),
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
      child: (context, index) => SurahTile.loading(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SurahTile extends StatelessWidget {
  final bool? isLoading;
  final SurahModel? data;
  final int? index;
  final void Function(SurahModel data)? onTap;

  const SurahTile._({this.isLoading, this.data, this.onTap, this.index});

  factory SurahTile.loading() => SurahTile._(isLoading: true);

  factory SurahTile({
    required SurahModel data,
    required int index,
    required void Function(SurahModel data) onTap,
  }) {
    return SurahTile._(data: data, onTap: onTap, index: index);
  }

  void _onTap() {
    if (onTap != null) onTap!(data!);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: _buttonTile(),
          tilePadding: EdgeInsets.zero,
          dense: true,
          childrenPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          showTrailingIcon: false,
          onExpansionChanged: (value) {},
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
              decoration: BoxDecoration(
                color: AppColor.SECONDARY.withValues(alpha: .2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    data?.arti ?? '',
                    style: Fonts.poppinsSemibold14.copyWith(color: AppColor.PRIMARY),
                  ),
                  8.verticalSpaceFromWidth,
                  HtmlWidget(
                    data?.deskripsi ?? '',
                    textStyle: Fonts.poppinsRegular12,
                    customStylesBuilder: (element) {
                      if (element.localName == 'i') {
                        return {
                          'font-weight': 'bold',
                          'color': '#18392B',
                        };
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            8.verticalSpaceFromWidth,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (isLoading ?? false) ? null : _onTap,
                child: Text("Baca Surah"),
              ),
            ),
          ],
        ),
      ),
    );
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
                  Text(data?.namaLatin ?? "", style: Fonts.poppinsMedium16),
                4.verticalSpaceFromWidth,
                if (isLoading ?? false)
                  Skelaton.text(width: 200.w)
                else
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          (data?.tempatTurun ?? '').toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Fonts.poppinsMedium12.copyWith(
                            color: AppColor.RomanSilver,
                          ),
                        ),
                      ),
                      5.horizontalSpace,
                      Icon(Icons.circle, size: 4.w, color: AppColor.RomanSilver),
                      5.horizontalSpace,
                      Flexible(
                        child: Text(
                          "${data?.jumlahAyat ?? 0} AYAT",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Fonts.poppinsMedium12.copyWith(
                            color: AppColor.RomanSilver,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          16.horizontalSpace,
          if (isLoading ?? false)
            Skelaton.text(width: 50.w, height: 30.w)
          else
            Text(
              data?.nama ?? '',
              style: GoogleFonts.amiri(
                color: AppColor.PRIMARY,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
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
