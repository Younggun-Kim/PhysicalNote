import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

class InjuryPage extends StatelessWidget {
  /// 추가 버튼 클릭.
  final VoidCallback onPressedAdd;

  const InjuryPage({
    super.key,
    required this.onPressedAdd,
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
          ],
        ),
      );
}
