import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/home2/items/today_training/home_today_training_item_ui_state.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';

/// V2. Home 컨트롤러
class HomeController extends BaseController {
  /// 오늘의 훈련 스크롤 컨트롤러
  final todayTrainingController = PageController();

  final todayTrainingItems = <HomeTodayTrainingItemUiState>[
    HomeTodayTrainingItemUiState(
      id: 1,
      imageUrl: '',
      name: '전술훈련',
      place: '강릉종합운동장',
      time: '09:00 - 11:00',
    ),
    HomeTodayTrainingItemUiState(
      id: 2,
      imageUrl: '',
      name: '전술훈련',
      place: '강릉종합운동장',
      time: '09:00 - 11:00',
    ),
    HomeTodayTrainingItemUiState(
      id: 3,
      imageUrl: '',
      name: '전술훈련',
      place: '강릉종합운동장',
      time: '09:00 - 11:00',
    ),
  ].obs;
}
