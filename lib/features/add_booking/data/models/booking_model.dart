
import '../../domain/entities/booking_entity.dart';

class BookingModel extends BookingEntity {
  BookingModel({
    super.id,
    required super.customerName,
    required super.phoneNumber,
    required super.totalPrice,
    required super.bookingDate,
    required super.isPaid,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'customerName': customerName,
      'phoneNumber': phoneNumber,
      'totalPrice': totalPrice,
      'bookingDate': bookingDate.toIso8601String(),
      'isPaid': isPaid,
    };
  }
  factory BookingModel.fromFirestore(Map<String, dynamic> json, String id) {
    return BookingModel(
      id: id,
      customerName: json['customerName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      totalPrice: (json['totalPrice'] as num).toDouble(),
      bookingDate: DateTime.parse(json['bookingDate']),
      isPaid: json['isPaid'] ?? false,
    );
  }
}