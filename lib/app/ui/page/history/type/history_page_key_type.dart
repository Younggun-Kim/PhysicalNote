import 'package:flutter/material.dart';

/// 이력 화면 키 타입
enum HistoryPageKeyType {
  dropDownDialog(key: Key('DropDownDialog')),
  filterButton(key: Key('HistoryHeaderFilterButton')),

  // 웰리니스
  wellness(key: Key('HistoryWellness')),

  // 운동강도
  intensity(key: Key('HistoryIntensity')),

  // 부상
  injury(key: Key('HistoryInjury'));

  final Key key;

  const HistoryPageKeyType({required this.key});
}
