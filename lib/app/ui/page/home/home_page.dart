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
            UserInformation(),
            SizedBox(height: 48),
            MyState(),
          ],
        ),
      );
}

/// User 정보
class UserInformation extends GetView<HomeController> {
  const UserInformation({super.key});

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
class MyState extends GetView<HomeController> {
  const MyState({super.key});

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
                onPressed: () {},
                text: StringRes.next.tr, hint: '',
              )
            ],
          )
        ],
      ).paddingSymmetric(horizontal: 20);
}
