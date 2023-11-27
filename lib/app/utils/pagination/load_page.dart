class LoadPage<K, V> {
  List<V> items;

  bool isLastPage;

  K nextPageKey;

  LoadPage({
    required this.items,
    required this.isLastPage,
    required this.nextPageKey,
  });
}