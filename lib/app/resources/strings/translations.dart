import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

part 'string_res.dart';
part 'ko_kr.dart';
part 'en_us.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ko_KR': koKr,
        'en_US': enUs,
      };
}
