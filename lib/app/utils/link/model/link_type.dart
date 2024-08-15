import 'package:get/get.dart';

enum LinkType {
  /// 앱 내부 웹뷰.
  inLink(id: 10),

  /// 외부 브라우저.
  outLink(id: 20),

  /// 앱 내부 화면.
  inAppLink(id: 30);

  /// 아이디.
  final int id;

  const LinkType({required this.id});

  /// int -> InLinkTarget.
  static LinkType from(int? targetId) =>
      LinkType.values.firstWhereOrNull((element) => element.id == targetId) ??
          LinkType.inAppLink;
}
