import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/data/data.dart';
import 'package:physical_note/app/ui/page/home/item/home_injury_check_item/home_injury_check_item.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

class InjuryPage extends GetView<DataController> {
  const InjuryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) => FlexibleScrollView(
        padding: const EdgeInsets.fromLTRB(30, 24, 30, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  StringRes.injuryCheck.tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: ColorRes.fontBlack,
                  ),
                ),
                const Spacer(),
                OutlineRoundButton(
                  hint: "",
                  text: StringRes.add.tr,
                  height: 28,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  onPressed: controller.onPressedAdd,
                ),
              ],
            ),
            Text(
              StringRes.painCheckLocation.tr,
              style: const TextStyle(
                fontSize: 12,
                color: ColorRes.fontDisable,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 528 / 1205,
                    child: Obx(() => SvgPicture.string(controller.humanFrontImage.value)),
                  ),
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 528 / 1205,
                    child: Obx(() => SvgPicture.string(controller.humanBackImage.value)),
                  ),
                ),
              ],
            ),
            Obx(() {
              final uiStates = controller.injuryList.toList();
              if (uiStates.isEmpty) {
                return const SizedBox();
              } else {
                return Column(
                  children: List<Widget>.generate(uiStates.length, (index) {
                    return HomeInjuryCheckItem(
                        uiState: uiStates[index],
                        isShowBorder: true,
                        onPressedEdit: () {
                          controller.onPressedEdit(uiStates[index]);
                        });
                  }).toList(),
                );
              }
            }),
          ],
        ),
      );
}
