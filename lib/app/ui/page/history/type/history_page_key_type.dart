import 'package:flutter/material.dart';

/// 이력 화면 키 타입
enum HistoryPageKeyType {
  filterButton(key: Key('HistoryHeaderFilterButton'));

  final Key key;

  const HistoryPageKeyType({required this.key});
}
