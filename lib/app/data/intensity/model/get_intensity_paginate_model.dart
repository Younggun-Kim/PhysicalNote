import 'package:physical_note/app/data/intensity/model/get_intensity_list_item_response_model.dart';
import 'package:physical_note/app/data/network/model/base_list_model/paginate_model.dart';

class GetIntensityPaginateModel {
  final String? lastWeekAvgWorkoutTime;
  final String? thisWeekAvgWorkoutTime;
  final double? sportsAvgIntensityLevel;
  final double? physicalAvgIntensityLevel;
  final PaginateModel<GetIntensityListItemResponseModel>? workoutIntensityList;

  GetIntensityPaginateModel(
    this.lastWeekAvgWorkoutTime,
    this.thisWeekAvgWorkoutTime,
    this.sportsAvgIntensityLevel,
    this.physicalAvgIntensityLevel,
    this.workoutIntensityList,
  );

  factory GetIntensityPaginateModel.fromJson(Map<String, dynamic> json) {
    return GetIntensityPaginateModel(
      json['lastWeekAvgWorkoutTime'] as String?,
      json['thisWeekAvgWorkoutTime'] as String?,
      json['sportsAvgIntensityLevel'] as double?,
      json['physicalAvgIntensityLevel'] as double?,
      json['workoutIntensityList'] != null
          ? PaginateModel<GetIntensityListItemResponseModel>.fromJson(
              json['workoutIntensityList'],
              (itemJson) =>
                  GetIntensityListItemResponseModel.fromJson(itemJson))
          : null,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'lastWeekAvgWorkoutTime': lastWeekAvgWorkoutTime,
        'thisWeekAvgWorkoutTime': thisWeekAvgWorkoutTime,
        'sportsAvgIntensityLevel': sportsAvgIntensityLevel,
        'physicalAvgIntensityLevel': physicalAvgIntensityLevel,
        'workoutIntensityList': workoutIntensityList?.toJson(),
      };
}
