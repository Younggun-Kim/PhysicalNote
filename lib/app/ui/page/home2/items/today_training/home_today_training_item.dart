import 'package:flutter/cupertino.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/home2/items/today_training/home_today_training_item_ui_state.dart';

/// 홈 - 오늘의 훈련 Item
class HomeTodayTrainingItem extends StatelessWidget {
  final HomeTodayTrainingItemUiState uiState;

  const HomeTodayTrainingItem({super.key, required this.uiState});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(right: 24),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorRes.thirdPrimary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              uiState.imageUrl ?? '',
              errorBuilder: (
                BuildContext context,
                Object error,
                StackTrace? stackTrace,
              ) {
                return Container(
                  width: 96,
                  height: 69,
                  color: ColorRes.disable,
                );
              },
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    uiState.name ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ColorRes.fontBlack,
                      letterSpacing: -0.5,
                      height: 24 / 16,
                    ),
                  ),
                  Text(
                    uiState.place ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorRes.fontBlack,
                      letterSpacing: -0.5,
                      height: 20 / 14,
                    ),
                  ),
                  Text(
                    uiState.time ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorRes.fontBlack,
                      letterSpacing: -0.5,
                      height: 20 / 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
