extension StringExt on String {

  /// String에서 정규표현식을 통해 숫자만 추출하고
  /// int.tryParse를 통해 int로 반환
  int? extractParseInt() {
    final extract = replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(extract);
  }
}