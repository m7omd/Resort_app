
import '../repository/booking_repository.dart';

class DeleteBookingUseCase {
  final BookingRepository repository;
  DeleteBookingUseCase({required this.repository});

  Future<void> call(String bookingId) async {
    return await repository.deleteBooking(bookingId);
  }
}