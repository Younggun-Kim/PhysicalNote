import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'home_statistics_chart_item_model.dart';

/// 홈 통계 차트 모델
class HomeStatisticsChartModel {
  final List<HomeStatisticsChartItemModel> list;
  final Color lineColor;

  HomeStatisticsChartModel({
    required this.list,
    required this.lineColor,
  });
}

extension HomeStatisticsChartModelExt on HomeStatisticsChartModel {
  List<FlSpot> toSpots() {
    return list.map((e) => FlSpot(e.x, e.y)).toList();
  }
}
