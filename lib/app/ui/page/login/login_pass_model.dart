import 'package:physical_note/app/data/login/model/post_pass_response_model.dart';

class LoginPassModel {
  final String passToken;
  final PostPassResponseModel response;

  LoginPassModel({
    required this.passToken,
    required this.response,
  });
}
