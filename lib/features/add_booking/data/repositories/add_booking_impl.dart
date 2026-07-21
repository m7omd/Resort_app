
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/booking_entity.dart';
import '../../domain/repositories/booking_repo.dart';
import '../models/booking_model.dart';

class BookingRepositoryImpl1 implements BookingRepository1 {
  final FirebaseFirestore firestore;

  BookingRepositoryImpl1(this.firestore);

  @override
  Future<void> addBooking(BookingEntity booking) async {
    final model = BookingModel(
      customerName: booking.customerName,
      phoneNumber: booking.phoneNumber,
      totalPrice: booking.totalPrice,
      bookingDate: booking.bookingDate,
      isPaid: booking.isPaid,
    );

    await firestore.collection('bookings').add(model.toFirestore());
  }
  @override
  Stream<List<BookingEntity>> getBookings() {
    return firestore.collection('bookings').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return BookingModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }
  @override
  Future<void> deleteBooking(String bookingId) async {
    await firestore.collection('bookings').doc(bookingId).delete();
  }

  @override
  Future<void> updateBooking1(BookingEntity booking) async {
    final model = BookingModel(
      customerName: booking.customerName,
      phoneNumber: booking.phoneNumber,
      totalPrice: booking.totalPrice,
      bookingDate: booking.bookingDate,
      isPaid: booking.isPaid,
    );

    await firestore.collection('bookings').doc(booking.id).update(model.toFirestore());
  }
}