class BinEntry {
  const BinEntry({
    required this.itemName,
    required this.quantity,
    this.materialType,
  });

  final String itemName;
  final int quantity;
  final String? materialType;

  Map<String, dynamic> toJson() {
    return {
      "itemName": itemName,
      "quantity": quantity,
      "materialType": materialType,
    };
  }

  factory BinEntry.fromJson(Map<String, dynamic> json) {
    // Backward compatibility with previously saved weight-based entries.
    final String fallbackName = (json["title"] ?? "Unknown Item") as String;
    final int fallbackQuantity =
        (json["weightKg"] as num?)?.round() ?? (json["count"] as num?)?.round() ?? 1;

    return BinEntry(
      itemName: (json["itemName"] ?? fallbackName) as String,
      quantity: (json["quantity"] as num?)?.toInt() ?? fallbackQuantity,
      materialType: (json["materialType"] ?? json["subtitle"]) as String?,
    );
  }
}
