class HistoryWellnessItemUiState {
  final int id;
  final String recordDate;
  final int? sleep;
  final int? stress;
  final int? fatigue;
  final int? muscleSoreness;
  final int? urine;
  final double? emptyStomachWeight;
  final double? bodyFat;
  double? sleepAvg;
  double? stressAvg;
  double? fatigueAvg;
  double? muscleSorenessAvg;
  double? urineAvg;
  double? weightAvg;
  String? differenceFat;

  HistoryWellnessItemUiState({
    required this.id,
    required this.recordDate,
    required this.sleep,
    required this.stress,
    required this.fatigue,
    required this.muscleSoreness,
    required this.urine,
    required this.emptyStomachWeight,
    required this.bodyFat,
    this.sleepAvg,
    this.stressAvg,
    this.fatigueAvg,
    this.muscleSorenessAvg,
    this.urineAvg,
    this.weightAvg,
    this.differenceFat,
  });
}