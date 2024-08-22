/// 오늘의 훈련 Item Ui State
class HomeTodayTrainingItemUiState {
  /// id
  final int id;

  /// 이미지.
  final String? imageUrl;

  /// 훈련명.
  final String? name;

  /// 장소.
  final String? place;

  /// 시간.
  final String? time;

  HomeTodayTrainingItemUiState({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.place,
    required this.time,
  });
}
