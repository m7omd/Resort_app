import '../entities/booking_entity.dart';
import '../repositories/booking_repo.dart';

class AddBookingUseCase1 {
  final BookingRepository1 repository;

  AddBookingUseCase1({required this.repository});

  Future<void> call(BookingEntity booking) async {
    return await repository.addBooking(booking);
  }
}
