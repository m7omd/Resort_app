import 'package:dartz/dartz.dart';
import 'package:resort_app/core/errors/failures.dart';
import 'package:resort_app/features/booking/domain/entity/booking_entity.dart';
import 'package:resort_app/features/booking/domain/repository/booking_repository.dart';

class GetBookingsUseCase {
  final BookingRepository bookingRepository;
  GetBookingsUseCase({required this.bookingRepository});

  Future<Either<Failure, List<BookingEntity>>> call() async {
    return await bookingRepository.getBookings();
  }
}
