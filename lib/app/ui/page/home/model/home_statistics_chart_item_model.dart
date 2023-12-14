/// 홈 통계 차트 아이템 모델.
class HomeStatisticsChartItemModel {
  final int id;
  final double x;
  final double y;
  final String xName;

  HomeStatisticsChartItemModel({
    required this.id,
    required this.x,
    required this.y,
    this.xName = "",
  });
}