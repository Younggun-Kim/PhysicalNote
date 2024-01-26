import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/team_request/team_request_controller.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

class TeamRequestPage extends GetView<TeamRequestController> {
  const TeamRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageRoot(
      controller: controller,
      isFullPage: false,
      safeStatusBar: false,
      safeNavigationBar: false,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Positioned(
            top: 0,
            child: SvgPicture.asset(
              Assets.backgroundTop,
              width: 230,
              height: 230,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 200),
              Image.asset(Assets.teamRequest),
              Text(
                StringRes.teamRequest.tr,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: ColorRes.fontBlack,
                ),
              ).paddingSymmetric(horizontal: 40),
              const SizedBox(height: 46),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(Assets.backgroundBottom),
          ),
        ],
      ),
    );
  }
}
