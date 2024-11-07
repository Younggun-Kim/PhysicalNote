import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/index.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/dialog/intensity_noti/intensity_noti.dart';
import 'package:physical_note/app/ui/widgets/buttons/buttons.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';

/// 홈 운동강도 노티 바텀 심트
class IntensityNotiBottomSheet extends GetView<IntensityNotiController> {
  final bool isPhysicalVisible;

  final bool isSportsVisible;

  const IntensityNotiBottomSheet({
    super.key,
    required this.isPhysicalVisible,
    required this.isSportsVisible,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 40),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringRes.enterIntensityBeforeForget.tr,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorRes.gray9f9f9f,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 20),
                Visibility(
                  visible: isSportsVisible,
                  child: Obx(
                    () => IntensityNotiItem(
                      type: IntensityType.sports,
                      value: controller.sportsSlider.value,
                      time: controller.sportsTime.value,
                      onSliderChanged: (double value) {
                        controller.onSportsSliderChanged(value);
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: isPhysicalVisible && isSportsVisible,
                  child: const SizedBox(height: 54),
                ),
                Visibility(
                  visible: isPhysicalVisible,
                  child: Obx(
                    () => IntensityNotiItem(
                      type: IntensityType.physical,
                      value: controller.physicalSlider.value,
                      time: controller.physicalTime.value,
                      onSliderChanged: (double value) {
                        controller.onPhysicalSliderChanged(value);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 54),
                Row(
                  children: [
                    Expanded(
                      child: RoundButton.gray(
                        height: 44,
                        text: StringRes.cancel.tr,
                        textStyle: const TextStyle(
                          color: ColorRes.gray9f9f9f,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: RoundButton(
                        height: 44,
                        text: StringRes.save.tr,
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: ColorRes.white,
                          fontWeight: FontWeight.w400,
                        ),
                        onPressed: () {
                          controller.onSaveBtnPressed(
                            isSportsUpdated: isSportsVisible,
                            isPhysicalUpdated: isPhysicalVisible,
                          );
                        }, // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: _CloseButton(),
          ),
          Obx(
            () => Visibility(
              visible: controller.isLoading.value,
              child: const Center(
                child: CircularProgressIndicator(
                  color: ColorRes.primary,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWellOver(
      onTap: () {
        Get.back();
      },
      child: SvgPicture.asset(Assets.xCloseGray),
    );
  }
}
