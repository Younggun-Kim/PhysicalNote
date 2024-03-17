import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:physical_note/app/config/constant/sns_type.dart';
import 'package:physical_note/app/resources/colors/color_res.dart';
import 'package:physical_note/app/ui/page/find_id_complete/items/find_id_compete_item_ui_state.dart';

class FindIdCompleteItem extends StatelessWidget {
  final FindIdCompleteItemUiState uiState;

  UserSnsType get snsType => uiState.snsType;

  String? get id => uiState.id;

  const FindIdCompleteItem({super.key, required this.uiState});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Image.asset(
            snsType.toImage(),
            width: 44,
            height: 44,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 50),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snsType.toUser(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: ColorRes.fontBlack,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  id ?? "",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.fontBlack,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
