class MultiSelectItem<T> {
  final T value;
  final String label;
  bool selected = false;

  MultiSelectItem(this.value, this.label);
}