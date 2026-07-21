import 'package:resort_app/features/booking/domain/entity/booking_entity.dart';

abstract class BookingStates {}

class InitialBookingState extends BookingStates {}

/// add booking
class LoadingAddBookingState extends BookingStates {}

class SuccessAddBookingState extends BookingStates {}

class FailureAddBookingState extends BookingStates {
  final String errorMessage;
  FailureAddBookingState({required this.errorMessage});
}


/// toggle enable

class UpdateBookingUiState extends BookingStates {}



/// get bookings
class LoadingGetBookingsState extends BookingStates {}
class SuccessGetBookingsState extends BookingStates {
  List<BookingEntity> bookings;
  SuccessGetBookingsState({required this.bookings});
}
class FailureGetBookingsState extends BookingStates {
  final String errorMessage;
  FailureGetBookingsState({required this.errorMessage});
}


/// delete bookings
class LoadingDeleteBookingState extends BookingStates {}
class SuccessDeleteBookingState extends BookingStates {}
class FailureDeleteBookingState extends BookingStates {
  final String errorMessage;
  FailureDeleteBookingState({required this.errorMessage});
}