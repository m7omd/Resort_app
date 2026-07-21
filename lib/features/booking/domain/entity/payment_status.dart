enum PaymentStatus {
  unpaid('غير مدفوع'),
  partiallyPaid('مدفوع جزئياً'),
  paid('مدفوع بالكامل');

  final String value; // النص اللي هيتبعت للـ Firebase أو يظهر في الـ UI
  const PaymentStatus(this.value);
  // ميثود تحويل من String جاي من الـ Firebase إلى Enum
  factory PaymentStatus.fromString(String? value) {
    switch (value) {
      case 'مدفوع بالكامل':
      case 'paid':
        return PaymentStatus.paid;
      case 'مدفوع جزئياً':
      case 'partiallyPaid':
        return PaymentStatus.partiallyPaid;
      default:
        return PaymentStatus.unpaid;
    }
  }
}