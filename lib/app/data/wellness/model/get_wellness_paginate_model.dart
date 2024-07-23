import 'package:physical_note/app/data/network/model/base_list_model/paginate_model.dart';
import 'package:physical_note/app/data/wellness/model/get_wellness_response_model.dart';

class GetWellnessPaginateModel {
  final double? sleepAvg;
  final double? stressAvg;
  final double? fatigueAvg;
  final double? muscleSorenessAvg;
  final double? urineAvg;
  final double? weightAvg;
  final PaginateModel<GetWellnessResponseModel>? wellnessList;

  GetWellnessPaginateModel(
    this.sleepAvg,
    this.stressAvg,
    this.fatigueAvg,
    this.muscleSorenessAvg,
    this.urineAvg,
    this.weightAvg,
    this.wellnessList,
  );

  factory GetWellnessPaginateModel.fromJson(Map<String, dynamic> json) {
    return GetWellnessPaginateModel(
      json['sleepAvg'] as double?,
      json['stressAvg'] as double?,
      json['fatigueAvg'] as double?,
      json['muscleSorenessAvg'] as double?,
      json['urineAvg'] as double?,
      json['weightAvg'] as double?,
      json['wellnessList'] != null
          ? PaginateModel<GetWellnessResponseModel>.fromJson(
              json['wellnessList'],
              (itemJson) => GetWellnessResponseModel.fromJson(itemJson))
          : null,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'sleepAvg': this.sleepAvg,
        'stressAvg': this.stressAvg,
        'fatigueAvg': this.fatigueAvg,
        'muscleSorenessAvg': this.muscleSorenessAvg,
        'urineAvg': this.urineAvg,
        'weightAvg': this.weightAvg,
        'wellnessList': this.wellnessList?.toJson(),
      };
}
