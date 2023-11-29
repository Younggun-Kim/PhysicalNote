/// 정보검색 Arguments.
class SearchCategoryArgs {
  final bool isSports;

  final int? categoryId;

  final int? sportsId;

  SearchCategoryArgs({
    required this.isSports,
    this.categoryId,
    this.sportsId,
  });
}
