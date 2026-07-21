import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resort_app/features/booking/domain/entity/booking_entity.dart';
import '../../../booking/data/model/booking_model.dart';

abstract class BookingRemoteDataSource {
  Future<void> addBooking(BookingEntity booking);
  Future<List<BookingEntity>> getBookings();
  Future<void> deleteBooking({required String id});
  Future<void> updateBooking({required BookingEntity booking});
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  BookingRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> addBooking(BookingEntity booking) async {
    final model = BookingModel(
      customerName: booking.customerName,
      phoneNumber: booking.phoneNumber,
      totalPrice: booking.totalPrice,
      bookingDate: booking.bookingDate,
      isConfirm: booking.isConfirm,
      amountPaid: booking.amountPaid,
      paymentStatus: booking.paymentStatus,
    );
    await firestore.collection('bookings').add(model.toFireStore());
  }

  @override
  Future<List<BookingEntity>> getBookings() async {
    // بدل snapshots استخدم get عشان تجيب الداتا مرة واحدة
    final snapshot = await firestore.collection('bookings').get();
    return snapshot.docs.map((doc) {
      return BookingModel.fromFireStore(doc.data(), doc.id);
    }).toList();
  }

  @override
  Future<void> deleteBooking({required String id}) async {
    await firestore.collection("bookings").doc(id).delete();
  }

  @override
  Future<void> updateBooking({required BookingEntity booking})async {
    final model = BookingModel(
      customerName: booking.customerName,
      phoneNumber: booking.phoneNumber,
      totalPrice: booking.totalPrice,
      bookingDate: booking.bookingDate,
      isConfirm: booking.isConfirm,
      paymentStatus: booking.paymentStatus,
      amountPaid: booking.amountPaid,
    );

    await firestore.collection('bookings').doc(booking.id).update(model.toFireStore());
  }

}
