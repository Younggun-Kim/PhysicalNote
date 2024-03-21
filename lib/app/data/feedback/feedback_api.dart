import 'package:physical_note/app/data/feedback/model/get_feedback_response_model.dart';
import 'package:physical_note/app/data/network/api.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/utils/utils.dart';

class FeedbackAPI extends API {
  FeedbackAPI() : super(basePath: "/api/workout_calendar");

  /// 피드백 조회.
  /// - parameters
  ///    - String recordDate - 일정 날짜.
  Future<dynamic> getFeedback(String recordDate) async {
    final response = await get(requestUrl + "?recordDate=$recordDate");

    if (response.status.hasError) {
      return ServerResponseFailModel.fromJson(response.body);
    } else {
      return GetFeedbackResponseModel.fromJson(response.body);
    }
  }
}
