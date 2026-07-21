import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resort_app/features/add_booking/domain/use_cases/get_booking_use_case.dart';

import '../../domain/entities/booking_entity.dart';
import '../../domain/use_cases/booking_use_case.dart';
import '../../domain/use_cases/update_booking_use_case.dart';
import 'add_booking_states.dart';

class BookingCubit1 extends Cubit<BookingState> {
  final AddBookingUseCase1 addBookingUseCase;
  final UpdateBookingUseCase updateBookingUseCase;
  final GetBookingsUseCase1 getBookingsUseCase;
  StreamSubscription? _bookingsSubscription;
  BookingCubit1({
    required this.addBookingUseCase,
    required this.getBookingsUseCase,
    required this.updateBookingUseCase,
  }) : super(BookingInitial());

  Future<void> createBooking(BookingEntity booking) async {
    emit(BookingLoading());
    try {
      await addBookingUseCase(booking);
      emit(BookingSuccess());
    } catch (e) {
      emit(BookingFailure(e.toString()));
    }
  }

  void fetchBookings() {
    emit(HomeLoading());
    _bookingsSubscription?.cancel(); // إلغاء أي اشتراك قديم لتفادي تسريب الذاكرة

    _bookingsSubscription = getBookingsUseCase().listen(
      (bookings) => emit(HomeSuccess(bookings)),
      onError: (error) => emit(HomeFailure(error.toString())),
    );
  }

  @override
  Future<void> close() {
    _bookingsSubscription?.cancel();
    return super.close();
  }

  // لوجيك الحذف
  Future<void> removeBooking(String bookingId) async {
    emit(BookingLoading());
    try {
      // await deleteBookingUseCase(bookingId);
      emit(BookingSuccess());
    } catch (e) {
      emit(BookingFailure(e.toString()));
    }
  }

  // لوجيك التعديل
  Future<void> editBooking(BookingEntity booking) async {
    emit(BookingLoading());
    try {
      await updateBookingUseCase(booking);
      emit(BookingSuccess());
    } catch (e) {
      emit(BookingFailure(e.toString()));
    }
  }
}
