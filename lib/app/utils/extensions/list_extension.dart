extension ListExt<T> on List<T> {
  List<R> mapWithIndex<R>(R Function(T, int i) callback) {
    List<R> result = [];
    for (int i = 0; i < length; i++) {
      R item = callback(this[i], i);
      result.add(item);
    }
    return result;
  }
}

extension CompactMap<E> on Iterable<E> {
  Iterable<T> compactMap<T>(T? Function(E) transform) {
    return map(transform)
        .where((element) => element != null)
        .cast<T>();
  }
}
