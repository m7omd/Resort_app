class BookingEntity {
  final String? id;
  final String customerName;
  final String phoneNumber;
  final double totalPrice;
  final DateTime bookingDate;
  final bool isPaid;

  BookingEntity({
    this.id,
    required this.customerName,
    required this.phoneNumber,
    required this.totalPrice,
    required this.bookingDate,
    required this.isPaid,
  });
}