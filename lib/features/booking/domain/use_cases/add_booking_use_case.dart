import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:resort_app/features/booking/domain/entity/booking_entity.dart';
import 'package:resort_app/features/booking/domain/repository/booking_repository.dart';

import '../../../../core/errors/failures.dart';

class AddBookingUseCase {
  final BookingRepository bookingRepository;
  AddBookingUseCase({required this.bookingRepository});

  Future<Either<Failure, void>> call(BookingEntity booking) async {
    return await bookingRepository.addBooking(booking);
  }
}
