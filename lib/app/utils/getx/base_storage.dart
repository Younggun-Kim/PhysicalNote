import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BaseStorage extends GetxService {
  /// 저장소 이름.
  final String name;

  /// 저장소 객체.
  late final GetStorage storage = GetStorage(name);

  /// 저장소 팩토리.
  get getBox => () => storage;

  /// 생성자.
  BaseStorage({required this.name});

  /// 저장소 초기화.
  /// 이 메소드를 호출해야 사용 가능한 상태가 됨.
  Future<BaseStorage> init() async {
    await GetStorage.init(name);
    return this;
  }

  /// 저장소 데이터 초기화.
  void clear() async {
    await storage.erase();
  }
}
