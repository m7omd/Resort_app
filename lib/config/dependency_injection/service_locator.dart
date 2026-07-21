import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:resort_app/features/booking/domain/use_cases/delete_booking_use_case.dart';

import '../../core/api/api_service.dart';

// Import Features
import 'package:resort_app/features/add_booking/domain/use_cases/update_booking_use_case.dart';
import 'package:resort_app/features/booking/data/data_source/booking_remote_data_source.dart';
import 'package:resort_app/features/booking/data/repository/booking_repository_impl.dart';
import 'package:resort_app/features/booking/domain/repository/booking_repository.dart';
import 'package:resort_app/features/booking/domain/use_cases/add_booking_use_case.dart';
import 'package:resort_app/features/booking/domain/use_cases/get_bookings_use_case.dart';
import 'package:resort_app/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:resort_app/features/layout/presentation/manager/layout_cubit.dart';

// Imports لـ Booking 1 (لو لسة مستخدمهم)
import '../../features/add_booking/data/repositories/add_booking_impl.dart';
import '../../features/add_booking/domain/repositories/booking_repo.dart';
import '../../features/add_booking/domain/use_cases/booking_use_case.dart';
import '../../features/add_booking/domain/use_cases/get_booking_use_case.dart';
import '../../features/add_booking/presentation/manager/add_booking_cubit.dart';

final getIt = GetIt.instance;

void serviceLocator() {
  // ==========================================
  // 1. External Services (الخدمات الخارجية)
  // ==========================================
  // getIt.registerSingleton(ApiService(Dio()));
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // ==========================================
  // 2. Data Sources
  // ==========================================
  getIt.registerLazySingleton<BookingRemoteDataSource>(
        () => BookingRemoteDataSourceImpl(firestore: getIt<FirebaseFirestore>()),
  );

  // ==========================================
  // 3. Repositories
  // ==========================================
  getIt.registerLazySingleton<BookingRepository>(
        () => BookingRepositoryImpl(bookingRemoteDataSource: getIt<BookingRemoteDataSource>(),),
  );

  getIt.registerLazySingleton<BookingRepository1>(
        () => BookingRepositoryImpl1(getIt<FirebaseFirestore>()),
  );

  // ==========================================
  // 4. Use Cases
  // ==========================================
  // Feature: Booking
  getIt.registerLazySingleton<AddBookingUseCase>(
        () => AddBookingUseCase(bookingRepository: getIt<BookingRepository>()),
  );
  getIt.registerLazySingleton<GetBookingsUseCase>(
        () => GetBookingsUseCase(bookingRepository: getIt<BookingRepository>()),
  ); getIt.registerLazySingleton<DeleteBookingUseCase>(
        () => DeleteBookingUseCase(repository: getIt<BookingRepository>()),
  );

  // Feature: Add Booking (1)
  getIt.registerLazySingleton<AddBookingUseCase1>(
        () => AddBookingUseCase1(repository: getIt<BookingRepository1>()),
  );
  getIt.registerLazySingleton<GetBookingsUseCase1>(
        () => GetBookingsUseCase1(repository: getIt<BookingRepository1>()),
  );

  getIt.registerLazySingleton<UpdateBookingUseCase>(
        () => UpdateBookingUseCase(getIt<BookingRepository1>()),
  );

  // ==========================================
  // 5. Cubits / Blocs (توضع في النهاية دائماً!)
  // ==========================================
  getIt.registerFactory<BookingCubit>(
        () => BookingCubit(
      addBookingUseCase: getIt<AddBookingUseCase>(),
      getBookingsUseCase: getIt<GetBookingsUseCase>(),
          deleteBookingUseCase: getIt<DeleteBookingUseCase>(),
    ),
  );

  // getIt.registerFactory<BookingCubit1>(
  //       () => BookingCubit1(
  //     addBookingUseCase: getIt<AddBookingUseCase1>(),
  //     getBookingsUseCase: getIt<GetBookingsUseCase1>(),
  //     deleteBookingUseCase: getIt<DeleteBookingUseCase>(),
  //     updateBookingUseCase: getIt<UpdateBookingUseCase>(),
  //   ),
  // );

  getIt.registerFactory<LayoutCubit>(
        () => LayoutCubit(),
  );
}