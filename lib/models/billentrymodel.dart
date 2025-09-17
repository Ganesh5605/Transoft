class BillEntryItem {
  final String ltr;
  final String fat;
  final String snf;
  final String degree;
  final String rate;
  final String amount;

  BillEntryItem({
    required this.ltr,
    required this.fat,
    required this.snf,
    required this.degree,
    required this.rate,
    required this.amount,
  });

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'ltr': ltr,
      'fat': fat,
      'snf': snf,
      'degree': degree,
      'rate': rate,
      'amount': amount,
    };
  }

  // Create model from JSON
  factory BillEntryItem.fromJson(Map<String, dynamic> json) {
    return BillEntryItem(
      ltr: json['ltr'] ?? '',
      fat: json['fat'] ?? '',
      snf: json['snf'] ?? '',
      degree: json['degree'] ?? '',
      rate: json['rate'] ?? '',
      amount: json['amount'] ?? '',
    );
  }
}
