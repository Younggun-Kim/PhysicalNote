import 'package:get/get.dart';

enum DeviceType {
  aos(key: 'AOS'),
  ios(key: 'IOS');

  final String key;

  const DeviceType({required this.key});

  static DeviceType get current => GetPlatform.isAndroid ? DeviceType.aos : DeviceType.ios;
}
