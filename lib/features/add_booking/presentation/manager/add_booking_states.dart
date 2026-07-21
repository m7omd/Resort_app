import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/booking_entity.dart';
import '../../domain/use_cases/booking_use_case.dart';


abstract class BookingState {}
class BookingInitial extends BookingState {}
class BookingLoading extends BookingState {}
class BookingSuccess extends BookingState {}
class BookingFailure extends BookingState { final String error; BookingFailure(this.error); }




class HomeInitial extends BookingState {}
class HomeLoading extends BookingState {}
class HomeSuccess extends BookingState { final List<BookingEntity> bookings; HomeSuccess(this.bookings); }
class HomeFailure extends BookingState { final String error; HomeFailure(this.error); }
