enum ItemCategory {
  book('Book'),
  clothes('Clothes'),
  electronics('Electronics'),
  supplies('Supplies'),
  other('Other');

  final String label;

  const ItemCategory(this.label);

  static ItemCategory fromLabel(String label) {
    return ItemCategory.values.firstWhere(
      (e) => e.label.toLowerCase() == label.toLowerCase(),
      orElse: () => ItemCategory.other,
    );
  }
}
