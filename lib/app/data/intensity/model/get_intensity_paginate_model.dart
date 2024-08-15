import 'package:physical_note/app/data/intensity/model/get_intensity_list_item_response_model.dart';
import 'package:physical_note/app/data/network/model/base_list_model/paginate_model.dart';

class GetIntensityPaginateModel {
  final double? lastWeekAvgIntensityLevel;
  final String? lastWeekAvgWorkoutTime;
  final double? thisWeekAvgIntensityLevel;
  final String? thisWeekAvgWorkoutTime;
  final PaginateModel<GetIntensityListItemResponseModel>? workoutIntensityList;

  GetIntensityPaginateModel(
    this.lastWeekAvgIntensityLevel,
    this.lastWeekAvgWorkoutTime,
    this.thisWeekAvgIntensityLevel,
    this.thisWeekAvgWorkoutTime,
    this.workoutIntensityList,
  );

  factory GetIntensityPaginateModel.fromJson(Map<String, dynamic> json) {
    return GetIntensityPaginateModel(
      json['lastWeekAvgIntensityLevel'] as double?,
      json['lastWeekAvgWorkoutTime'] as String?,
      json['thisWeekAvgIntensityLevel'] as double?,
      json['thisWeekAvgWorkoutTime'] as String?,
      json['workoutIntensityList'] != null
          ? PaginateModel<GetIntensityListItemResponseModel>.fromJson(
              json['workoutIntensityList'],
              (itemJson) =>
                  GetIntensityListItemResponseModel.fromJson(itemJson))
          : null,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'lastWeekAvgIntensityLevel': lastWeekAvgIntensityLevel,
        'lastWeekAvgWorkoutTime': lastWeekAvgWorkoutTime,
        'thisWeekAvgIntensityLevel': thisWeekAvgIntensityLevel,
        'thisWeekAvgWorkoutTime': thisWeekAvgWorkoutTime,
        'workoutIntensityList': workoutIntensityList?.toJson(),
      };
}
