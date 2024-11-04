import 'package:get/get.dart';

/// 운동 타입.
enum WorkoutType {
  sports("SPORTS"),
  physical("PHYSICAL");

  final String remote;

  const WorkoutType(this.remote);

  /// Key로 초기화
  static WorkoutType? from(String? rawValue) => values.firstWhereOrNull(
        (element) => element.remote == rawValue,
      );
}
