class PostLoginResponseModel {
  final String? token;
  final String? userId;
  final String? loginId;
  final String? name;

  PostLoginResponseModel({
    this.token,
    this.userId,
    this.loginId,
    this.name,
  });

  factory PostLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      PostLoginResponseModel(
        token: json['token'],
        userId: json['userId'],
        loginId: json['loginId'],
        name: json['name'],
      );

  // static List<PostLoginResponseModel> listFromJson(list) =>
  //     List<PostLoginResponseModel>.from(list.map((x) => PostLoginResponseModel.fromJson(x)));
}
