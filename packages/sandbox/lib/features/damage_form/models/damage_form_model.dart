class DamageForm {
  const DamageForm({
    required this.date,
    required this.description,
    required this.price,
  });
  DamageForm.init() : date = DateTime.now(), description = '', price = null;

  final DateTime date;
  final String description;
  final int? price; // in cents to be shown as euros with 2 decimals

  bool get hasEditedFields => description.isNotEmpty || price != null;

  DamageForm copyWith({
    DateTime? date,
    String? description,
    int? price,
  }) {
    return DamageForm(
      date: date ?? this.date,
      description: description ?? this.description,
      price: price ?? this.price,
    );
  }
}
