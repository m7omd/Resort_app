import '../entities/booking_entity.dart';
import '../repositories/booking_repo.dart';

class UpdateBookingUseCase {
  final BookingRepository1 repository;
  UpdateBookingUseCase(this.repository);

  Future<void> call(BookingEntity booking) async {
    return await repository.updateBooking1(booking);
  }
}