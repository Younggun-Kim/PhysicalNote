import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/home2/home.dart';
import 'package:physical_note/app/ui/page/home2/items/today_training/home_today_training_item.dart';
import 'package:physical_note/app/ui/widgets/flexible_scroll_view.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: FlexibleScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _UserInfo(),
              const SizedBox(height: 20),
              _RecordButtons(),
              const SizedBox(height: 20),
              _FieldName(text: StringRes.todayTraining.tr),
              const SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: _TodayTraining(),
              ),
            ],
          ),
        ),
      );
}

/// 필드명
class _FieldName extends StatelessWidget {
  final String text;

  const _FieldName({super.key, required this.text});

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: ColorRes.fontBlack,
          letterSpacing: -0.5,
          height: 24 / 16,
        ),
      );
}

/// 로그인한 유저의 정보
class _UserInfo extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.userDefaultGreen,
            width: 54,
            height: 54,
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: '홍길동 ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: ColorRes.fontBlack,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const WidgetSpan(child: SizedBox(width: 2)),
                    TextSpan(
                      text: StringRes.sir.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: ColorRes.fontBlack,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const WidgetSpan(child: SizedBox(width: 8)),
                    WidgetSpan(
                      child: InkWellOver(
                        onTap: () {},
                        child: SvgPicture.asset(
                          Assets.editGreen,
                          width: 19,
                          height: 19,
                        ),
                      ),
                    ),
                  ]),
                ),
                const Text(
                  '여기저기FC / 정하진',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.fontBlack,
                    letterSpacing: -0.5,
                    height: 20 / 14,
                  ),
                )
              ],
            ),
          ),
        ],
      );
}

/// 기록 버튼 목록
class _RecordButtons extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: _RecordButton(
              text: StringRes.wellness.tr,
              asset: Assets.wellnessIcon,
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _RecordButton(
              text: StringRes.workoutIntensity.tr,
              asset: Assets.intensityIcon,
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _RecordButton(
              text: StringRes.injuryCheck.tr,
              asset: Assets.injuryIcon,
              onPressed: () {},
            ),
          ),
        ],
      );
}

/// 기록 버튼
class _RecordButton extends StatelessWidget {
  final String asset;

  final String text;

  final VoidCallback onPressed;

  const _RecordButton({
    required this.asset,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => InkWellOver(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(24),
        child: AspectRatio(
          aspectRatio: 100 / 82,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorRes.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 2),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(child: SvgPicture.asset(asset)),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.fontBlack,
                    letterSpacing: -0.5,
                    height: 24 / 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

/// 오늘의 훈려
class _TodayTraining extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) => Obx(
        () => PageView.builder(
          controller: controller.todayTrainingController,
          scrollDirection: Axis.horizontal,
          itemCount: controller.todayTrainingItems.length,
          itemBuilder: (BuildContext context, int index) {
            final items = controller.todayTrainingItems.toList();
            final uiState = items[index];
            return HomeTodayTrainingItem(uiState: uiState);
          },
        ),
      );
}
