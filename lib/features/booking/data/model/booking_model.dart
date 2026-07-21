import '../../../booking/domain/entity/booking_entity.dart';
import '../../domain/entity/payment_status.dart';

class BookingModel extends BookingEntity {
  BookingModel({
    required super.customerName,
    required super.phoneNumber,
    required super.totalPrice,
    required super.bookingDate,
    required super.isConfirm,
     super.id,
    required super.amountPaid,
    required super.paymentStatus,
  });
  Map<String, dynamic> toFireStore() {
    return {
      'customerName': customerName,
      'phoneNumber': phoneNumber,
      'totalPrice': totalPrice,
      'bookingDate': bookingDate.toIso8601String(),
      'isConfirm': isConfirm,
      'id': id,
      'amountPaid': amountPaid,
      'paymentStatus': paymentStatus.value,
    };
  }

  factory BookingModel.fromFireStore(Map<String, dynamic> json, String id) {
    return BookingModel(

      amountPaid: json['amountPaid']??0.0,
      phoneNumber: json['phoneNumber'],
      bookingDate: DateTime.parse(json['bookingDate']),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      customerName: json['customerName'],
      isConfirm: json['isConfirm'] ?? false,
      id: id,
      paymentStatus: PaymentStatus.fromString(json['paymentStatus']),
    );
  }
}
