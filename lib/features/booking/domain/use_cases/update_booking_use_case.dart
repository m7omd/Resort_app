
import '../repository/booking_repository.dart';
import '../entity/booking_entity.dart';
class UpdateBookingUseCase {
  final BookingRepository repository;
  UpdateBookingUseCase(this.repository);

  Future<void> call(BookingEntity booking) async {
    return await repository.updateBooking(booking);
  }
}