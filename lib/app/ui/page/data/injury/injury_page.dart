import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/home/item/home_injury_check_item/home_injury_check_item.dart';
import 'package:physical_note/app/ui/page/home/item/home_injury_check_item/home_injury_check_item_ui_state.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

class InjuryPage extends StatelessWidget {
  /// 부상 목록.
  final List<HomeInjuryCheckItemUiState> uiStates;

  /// 사람 앞 모습.
  final String humanFrontImage;

  /// 사람 뒷 모습.
  final String humanBackImage;

  /// 추가 버튼 클릭.
  final VoidCallback onPressedAdd;

  /// 편집 버튼 클릭.
  final Function(HomeInjuryCheckItemUiState uiState) onPressedEdit;

  const InjuryPage({
    super.key,
    required this.uiStates,
    required this.humanFrontImage,
    required this.humanBackImage,
    required this.onPressedAdd,
    required this.onPressedEdit,
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
                  onPressed: onPressedAdd,
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
                    child: SvgPicture.string(humanFrontImage),
                  ),
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 528 / 1205,
                    child: SvgPicture.string(humanBackImage),
                  ),
                ),
              ],
            ),
            if (uiStates.isEmpty)
              const SizedBox()
            else
              Column(
                children: List<Widget>.generate(uiStates.length, (index) {
                  return HomeInjuryCheckItem(
                      uiState: uiStates[index],
                      isShowBorder: true,
                      onPressedEdit: () {
                        onPressedEdit(uiStates[index]);
                      });
                }).toList(),
              ),
          ],
        ),
      );
}
