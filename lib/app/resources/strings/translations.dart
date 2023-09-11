import 'package:get/get.dart';
import 'package:physical_note/app/resources/strings/en_us.dart';
import 'package:uuid/uuid.dart';

part 'string_res.dart';
part 'ko_kr.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ko_KR': koKr,
        'en_US': enUs,
      };
}
