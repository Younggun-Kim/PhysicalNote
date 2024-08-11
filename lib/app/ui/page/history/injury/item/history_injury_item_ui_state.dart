import 'package:physical_note/app/config/constant/index.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';

class HistoryInjuryItemUiState {
  final int id;
  final InjuryLevelType? injuryLevelType;
  final InjuryType? injuryType;
  final MuscleType? muscleType;
  final DistinctionType? direction;
  final BodyPartsType? bodyPart;
  final String recordDate;
  final String? comment;
  final bool? recoveryYn;
  final String? recoveryDate;
  final String muscleImage;

  HistoryInjuryItemUiState({
    required this.id,
    required this.injuryLevelType,
    required this.injuryType,
    required this.muscleType,
    required this.direction,
    required this.bodyPart,
    required this.recordDate,
    required this.comment,
    required this.recoveryYn,
    required this.recoveryDate,
    required this.muscleImage,
  });

  /// formatted Record Date
  DateTime get formattedRecordDate => recordDate.toDate('yyy-MM-dd');
}
