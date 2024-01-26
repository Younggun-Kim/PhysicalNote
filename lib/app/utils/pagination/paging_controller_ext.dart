import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'load_page.dart';

extension PagingControllerExt<K, V> on PagingController<K, V> {
  /// 페이징 시작.
  void start(
    Future<LoadPage<K, V>> Function(K pageKey) onLoadPage, {
    Future<void> Function(K pageKey, LoadPage<K, V> loadPage)? onLoadedPage,
  }) {
    addPageRequestListener((pageKey) async {
      final loadPage = await onLoadPage(pageKey);
      if (loadPage.isLastPage) {
        appendLastPage(loadPage.items);
      } else {
        appendPage(loadPage.items, loadPage.nextPageKey);
      }
      if (onLoadedPage != null) {
        await onLoadedPage(pageKey, loadPage);
      }
    });
  }

  /// 데이터 변경 알림.
  void notifyDataChanged() {
    itemList = itemList?.toList();
  }
}
