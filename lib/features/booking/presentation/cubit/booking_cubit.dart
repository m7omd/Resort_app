import 'package:resort_app/features/booking/domain/entity/booking_entity.dart';
import 'package:resort_app/features/booking/domain/use_cases/delete_booking_use_case.dart';
import 'package:resort_app/features/booking/presentation/cubit/states.dart';
import '../../../../core/utils/imports.dart';
import '../../../booking/domain/use_cases/add_booking_use_case.dart';
import '../../../booking/domain/use_cases/get_bookings_use_case.dart';

class BookingCubit extends Cubit<BookingStates> {
  BookingCubit({required this.addBookingUseCase, required this.getBookingsUseCase, required this.deleteBookingUseCase})
    : super(InitialBookingState());
  final AddBookingUseCase addBookingUseCase;
  final GetBookingsUseCase getBookingsUseCase;
  final DeleteBookingUseCase deleteBookingUseCase;

  Future<void> addBooking(BookingEntity booking) async {
    emit(LoadingAddBookingState());
    final result = await addBookingUseCase.call(booking);
    result.fold(
      (failure) => emit(FailureAddBookingState(errorMessage: failure.errMessage)),
      (success) {
        emit(SuccessAddBookingState());
        getBookings();

      }
    );
  }

  Future<void> getBookings() async {
    emit(LoadingGetBookingsState());
    final result = await getBookingsUseCase.call();
    result.fold(
      (failure) => emit(FailureGetBookingsState(errorMessage: failure.errMessage)),
      (success) => emit(SuccessGetBookingsState(bookings: success)),
    );
  }

  Future<void> removeBooking(String bookingId) async {
    emit(LoadingDeleteBookingState());
    try {
      await deleteBookingUseCase(bookingId);
      emit(SuccessDeleteBookingState());
      getBookings();
    } catch (e) {
      emit(FailureDeleteBookingState(errorMessage: e.toString()));
    }
  }

  bool isConfirm = false;
  bool isEnabled = true;

  void toggleEnabled() {
    isEnabled = !isEnabled;
    emit(UpdateBookingUiState());
  }

  void toggleConfirmStatus(bool value) {
    isConfirm = value;
    emit(UpdateBookingUiState());
  }

  // دالة تُرجع قائمة تواريخ الحجوزات من الحالة الحالية
  List<DateTime> get bookedDates {
    if (state is SuccessGetBookingsState) {
      return (state as SuccessGetBookingsState)
          .bookings
          .map((b) => b.bookingDate)
          .toList();
    }
    return []; // إرجاع قائمة فارغة إذا لم تكن البيانات محملة بعد
  }
}
