/// Extensions on nullable [List] of any type
extension CustomListExtensions<T, I> on List<T>? {
  /// Add or update an item in the list
  List<T> addOrUpdateItem({
    required T item,
    required bool Function(T element) predicate,
  }) {
    //if the list is not null
    if (this != null) {
      //check if the item already exist so it needs to be updated
      final index = this!.indexWhere(predicate);

      if (index == -1) {
        //if the item does not exist -> append to list
        return [...this!, item];
      } else {
        //if the item exists -> replace at index
        this!.removeAt(index);
        this!.insert(index, item);
        return this!;
      }
    } else {
      //if the list is null
      return [item];
    }
  }

  /// Update single item based on index
  List<T> updateItem({
    required T item,
    required int index,
  }) {
    //if the list is not null
    if (this != null) {
      this!.removeAt(index);
      this!.insert(index, item);
      return this!;
    } else {
      //if the list is null
      return [item];
    }
  }
}

/// Extensions on nullable [Iterable] of any type
extension NullableListExtension<T> on Iterable<T>? {
  /// Checks if the iterable is null or empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}
