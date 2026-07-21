import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:resort_app/features/booking/domain/entity/booking_entity.dart';

import '../../../../core/errors/failures.dart';

abstract class BookingRepository {
  Future<Either<Failure, void>> addBooking(BookingEntity booking);
  Future<Either<Failure, List<BookingEntity>>> getBookings();
  Future<void> deleteBooking(String bookingId);
  Future<void> updateBooking(BookingEntity booking);
}
