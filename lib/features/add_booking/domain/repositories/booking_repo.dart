import '../entities/booking_entity.dart';

abstract class BookingRepository1 {
  Future<void> addBooking(BookingEntity booking);
  Stream<List<BookingEntity>> getBookings(); // الجديدة للـ Home
  Future<void> updateBooking1(BookingEntity booking); // جديدة
}