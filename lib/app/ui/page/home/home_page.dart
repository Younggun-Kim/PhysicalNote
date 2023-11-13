import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/widgets/buttons/outline_round_button.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';

import '../../../resources/resources.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: const Column(
          children: [
            SizedBox(height: 40),
            _UserInformation(),
            SizedBox(height: 48),
            _MyState(),
          ],
        ),
      );
}

/// User 정보
class _UserInformation extends GetView<HomeController> {
  const _UserInformation();

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Obx(
            () => SizedBox(
              width: 54,
              height: 54,
              child: controller.userImageUrl.isEmpty
                  ? SvgPicture.asset(Assets.userDefault)
                  : Image.network(controller.userImageUrl.value),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  "${controller.userClub.value} / ${controller.userClubCoach.value}",
                  style:
                      const TextStyle(fontSize: 12, color: ColorRes.fontBlack),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(
                    () => Text(
                      controller.userName.value,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: ColorRes.fontBlack,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    StringRes.sir.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorRes.fontBlack,
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWellOver(
                    onTap: controller.onPressedUserEdit,
                    child: SvgPicture.asset(
                      Assets.edit03,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ).paddingSymmetric(horizontal: 20);
}

/// 나의 상태.
class _MyState extends GetView<HomeController> {
  const _MyState();

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringRes.myState.tr,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: ColorRes.fontBlack,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DateTime.now().toFormattedString("yyyy년 M월 dd일"),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: ColorRes.fontBlack,
                ),
              ),
              const SizedBox(width: 5),
              InkWellOver(
                child: SvgPicture.asset(
                  Assets.codeBrowser,
                ),
              ),
              const Spacer(),
              OutlineRoundButton(
                height: 24,
                onPressed: () {},
                text: StringRes.next.tr,
                hint: '',
              ),
            ],
          ),
          const SizedBox(height: 10),
          _MyStateDisplay(),
          const SizedBox(height: 10),
          Row(
            children: [
              const Spacer(),
              SvgPicture.asset(Assets.checkRed),
              const SizedBox(width: 4),
              Text(
                StringRes.noRecordAndRecordYourStatusToday.tr,
                style: const TextStyle(
                  fontSize: 12,
                  color: ColorRes.error,
                ),
              ),
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 20);
}

class _MyStateDisplay extends GetView<HomeController> {
  Widget emptyText() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          StringRes.noData.tr,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ColorRes.fontBlack,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ColorRes.borderDeselect),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    MyStateTitle(
                        title: StringRes.hooperIndex.tr, onPressed: () {}),
                    const SizedBox(height: 10),
                    emptyText(),
                    const SizedBox(height: 16),
                    MyStateTitle(
                        title: StringRes.injuryRisk.tr, onPressed: () {}),
                    const SizedBox(height: 10),
                    emptyText(),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              const VerticalDivider(
                thickness: 1,
                color: ColorRes.disable,
                indent: 2,
                endIndent: 4,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    MyStateTitle(
                        title: StringRes.urinalysis.tr, onPressed: () {}),
                    const SizedBox(height: 10),
                    emptyText(),
                    const SizedBox(height: 16),
                    MyStateTitle(
                        title: StringRes.workoutIntensity.tr, onPressed: () {}),
                    const SizedBox(height: 10),
                    emptyText(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

class MyStateTitle extends StatelessWidget {
  final String title;

  final VoidCallback onPressed;

  const MyStateTitle({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: ColorRes.fontBlack,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 5),
          InkWellOver(
            onTap: onPressed,
            child: SvgPicture.asset(
              Assets.edit03,
            ),
          ),
          const Spacer(),
        ],
      );
}

/// 통계.
class _Statistics extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) => Column(
    children: [
      _StatisticsTitle(),
    ],
  );
}

/// 통계 타이틀.
class _StatisticsTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
    children: [
      TextButton(onPressed: () {}, child: Text("주간")),
      TextButton(onPressed: () {}, child: Text("월간"))
    ],
  );
}