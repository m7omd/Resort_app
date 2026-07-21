import '../entities/booking_entity.dart';
import '../repositories/booking_repo.dart';

class GetBookingsUseCase1 {
  final BookingRepository1 repository;

  GetBookingsUseCase1({required this.repository});

  Stream<List<BookingEntity>> call() {
    return repository.getBookings();
  }
}