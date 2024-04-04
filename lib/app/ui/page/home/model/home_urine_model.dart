import 'package:physical_note/app/config/constant/urine_status_type.dart';

/// 홈 소변검사 모델.
class HomeUrineModel {
  final int id;
  final int weight;
  final String differenceFat;
  final UrineStatusType urine;

  HomeUrineModel({
    required this.id,
    required this.weight,
    required this.differenceFat,
    required this.urine,
  });
}
