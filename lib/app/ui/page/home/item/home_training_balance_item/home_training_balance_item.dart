import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:physical_note/app/resources/colors/color_res.dart';

import 'home_training_balance_type.dart';

/// 홈 - 운동시간 - 트레이닝 밸런스 아이템
class HomeTrainingBalanceItem extends StatelessWidget {
  final HomeTrainingBalanceType type;

  final String period;

  final int average;

  const HomeTrainingBalanceItem({
    super.key,
    required this.type,
    required this.period,
    required this.average,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SvgPicture.asset(
            type.toAsset(),
            width: 21,
            height: 37,
          ),
          const SizedBox(height: 3),
          Text(
            period,
            style: const TextStyle(
              fontSize: 10,
              color: ColorRes.fontBlack,
            ),
          ),
          Text(
            "($average)",
            style: const TextStyle(
              fontSize: 10,
              color: ColorRes.fontDisable,
            ),
          ),
        ],
      );
}
