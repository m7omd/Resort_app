import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:resort_app/features/booking/data/model/booking_model.dart';
import 'package:resort_app/features/booking/domain/entity/booking_entity.dart';
import 'package:resort_app/features/booking/domain/repository/booking_repository.dart';

import '../../../../core/errors/failures.dart';
import '../data_source/booking_remote_data_source.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource bookingRemoteDataSource;
  BookingRepositoryImpl({required this.bookingRemoteDataSource});
  @override
  Future<Either<Failure, void>> addBooking(BookingEntity booking) async {
    try {
      await bookingRemoteDataSource.addBooking(booking);
      return const Right(null); // نجاح
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? "حدث خطأ في السيرفر"));
    } catch (e, stackTrace) {
      print("===== GET BOOKINGS ERROR =====");
      print(e);
      print(stackTrace);
      print("==============================");
      return Left(ServerFailure("حدث مشكلة"));
    }
  }

  @override
  Future<Either<Failure, List<BookingEntity>>> getBookings() async {
    try {
      final bookings = await bookingRemoteDataSource.getBookings();
      return Right(bookings);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? "حدث خطأ في السيرفر"));
    } catch (e, stackTrace) {
      print("===== GET BOOKINGS ERROR =====");
      print(e);
      print(stackTrace);
      print("==============================");
      return Left(ServerFailure("حدث مشكلة في جلب الحجوزات"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBooking(String bookingId) async {
    try {
      await bookingRemoteDataSource.deleteBooking(id: bookingId);
      return const Right(null); // نجاح
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? "حدث خطأ في السيرفر"));
    } catch (e, stackTrace) {
      print("===== delte BOOKINGS ERROR =====");
      print(e);
      print(stackTrace);
      print("==============================");
      return Left(ServerFailure("حدث مشكلة"));
    }
  }

  @override
  Future<Either<Failure, void>> updateBooking(BookingEntity booking)async {
    try {
      await bookingRemoteDataSource.updateBooking(booking: booking);
      return const Right(null); // نجاح
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? "حدث خطأ في السيرفر"));
    } catch (e, stackTrace) {
      print("===== delte BOOKINGS ERROR =====");
      print(e);
      print(stackTrace);
      print("==============================");
      return Left(ServerFailure("حدث مشكلة"));
    }
  }
}
