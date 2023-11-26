import 'package:get_storage/get_storage.dart';
import 'package:physical_note/app/utils/getx/base_storage.dart';

enum _Key {

  /// Api Key.
  apiKey,

  /// SNS 타입.
  snsType,

  /// 정보 등록 여부.
  isRegisteredInformation,
}

class UserStorage extends BaseStorage {
  static const storageName = "user_storage";

  /// Api key.
  late final apiKey = "".val(_Key.apiKey.name, getBox: getBox);

  /// Sns.
  late final snsType = 0.val(_Key.snsType.name, getBox: getBox);

  /// 정보 등록 여부
  late final isRegisteredInformation = false.val(_Key.isRegisteredInformation.name, getBox: getBox);

  /// 로그인 여부.
  bool get isLogin => apiKey.val.isNotEmpty;

  UserStorage() : super(name: storageName);
}
