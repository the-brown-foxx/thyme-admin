extension Search<E> on List<E> {
  List<E> search(
    final String query, {
    required final List<String Function(E element)> keys,
    final bool caseSensitive = false,
  }) {
    return where((final element) {
      for (final key in keys) {
        final adjustedKey =
            caseSensitive ? key(element) : key(element).toLowerCase();
        final adjustedQuery = caseSensitive ? query : query.toLowerCase();

        if (adjustedKey.contains(adjustedQuery)) {
          return true;
        }
      }
      return false;
    }).toList();
  }
}
