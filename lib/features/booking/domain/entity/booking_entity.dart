import 'package:resort_app/features/booking/domain/entity/payment_status.dart';

class BookingEntity {
  final String? id;
  final String customerName;
  final String phoneNumber;
  final double totalPrice;
  final num amountPaid;
  final DateTime bookingDate;
  final PaymentStatus paymentStatus;
  final bool isConfirm;

  BookingEntity({
     this.id,
    required this.customerName,
    required this.phoneNumber,
    required this.totalPrice,
    required this.bookingDate,
    required this.isConfirm,
    required this.amountPaid,
    required this.paymentStatus,
  });
}