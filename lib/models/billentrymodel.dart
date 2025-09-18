class BillEntryItem {
   String Item;
   String Unit;
   String Qty;
   String rate;
   String amount;

  BillEntryItem({
    required this.Item,
    required this.Unit,
    required this.Qty,
    required this.rate,
    required this.amount,
  });

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'item': Item,
      'Unit': Unit,
      'qty': Qty,
      'rate': rate,
      'amount': amount,
    };
  }

  // Create model from JSON
  factory BillEntryItem.fromJson(Map<String, dynamic> json) {
    return BillEntryItem(
      Item: json['item'] ?? '',
      Unit: json['Unit'] ?? '',
      Qty: json['qty'] ?? '',
      rate: json['rate'] ?? '',
      amount: json['amount'] ?? '',
    );
  }
}
