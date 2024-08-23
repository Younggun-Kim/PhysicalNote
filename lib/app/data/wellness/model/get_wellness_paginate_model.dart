import 'package:physical_note/app/data/network/model/base_list_model/paginate_model.dart';
import 'package:physical_note/app/data/wellness/model/get_wellness_response_model.dart';

class GetWellnessPaginateModel {
  final double? sleepAvg;
  final double? stressAvg;
  final double? fatigueAvg;
  final double? muscleSorenessAvg;
  final double? urineAvg;
  final double? weightAvg;
  final String? differenceFat;
  final PaginateModel<GetWellnessResponseModel>? wellnessList;

  GetWellnessPaginateModel(
    this.sleepAvg,
    this.stressAvg,
    this.fatigueAvg,
    this.muscleSorenessAvg,
    this.urineAvg,
    this.weightAvg,
    this.differenceFat,
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
      json['differenceFat'] as String?,
      json['wellnessList'] != null
          ? PaginateModel<GetWellnessResponseModel>.fromJson(
              json['wellnessList'],
              (itemJson) => GetWellnessResponseModel.fromJson(itemJson))
          : null,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'sleepAvg': sleepAvg,
        'stressAvg': stressAvg,
        'fatigueAvg': fatigueAvg,
        'muscleSorenessAvg': muscleSorenessAvg,
        'urineAvg': urineAvg,
        'weightAvg': weightAvg,
        'differenceFat': differenceFat,
        'wellnessList': wellnessList?.toJson(),
      };
}
