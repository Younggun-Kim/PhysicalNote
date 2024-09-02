import 'package:get_storage/get_storage.dart';
import 'package:physical_note/app/utils/getx/base_storage.dart';

enum UserStorageKey {
  /// Api Key.
  apiKey,

  /// SNS 타입.
  snsType,

  /// 정보 등록 여부.
  isRegisteredInformation,

  /// 웰리니스 정렬기준
  wellnessOrder,

  /// 웰리니스 조회기간
  wellnessDate,

  /// 운동강도 정렬기준
  intensityOrder,

  /// 운동강도 조회기간
  intensityDate,

  /// 부상체크 정렬기준
  injuryOrder,

  /// 부상체크 조회기간
  injuryDate;
}

class UserStorage extends BaseStorage {
  static const storageName = "user_storage";

  /// Api key.
  late final apiKey = "".val(UserStorageKey.apiKey.name, getBox: getBox);

  /// Sns.
  late final snsType = "".val(UserStorageKey.snsType.name, getBox: getBox);

  /// 정보 등록 여부
  late final isRegisteredInformation =
      false.val(UserStorageKey.isRegisteredInformation.name, getBox: getBox);

  /// 로그인 여부.
  bool get isLogin => apiKey.val.isNotEmpty;

  /// get string
  String getString(UserStorageKey key) {
    return ReadWriteValue<String>(key.name, '', getBox).val;
  }

  /// set string
  void setString(UserStorageKey key, String value) {
    final storageValue = ReadWriteValue<String>(key.name, '', getBox);
    storageValue.val = value;
  }

  /// remove
  void remove(UserStorageKey key) {
    storage.remove(key.name);
  }

  /// 이력 필터 데이터틀 삭제
  void removeFilter() {
    storage.remove(UserStorageKey.wellnessOrder.name);
    storage.remove(UserStorageKey.wellnessDate.name);
    storage.remove(UserStorageKey.intensityOrder.name);
    storage.remove(UserStorageKey.intensityDate.name);
    storage.remove(UserStorageKey.injuryOrder.name);
    storage.remove(UserStorageKey.injuryDate.name);
  }

  UserStorage() : super(name: storageName);
}
