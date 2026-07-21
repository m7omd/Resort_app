import 'package:nested/nested.dart';
import 'package:resort_app/features/add_booking/domain/entities/booking_entity.dart';
import 'package:resort_app/features/layout/presentation/manager/layout_cubit.dart';

import 'imports.dart';
import '../../features/booking/presentation/cubit/booking_cubit.dart';
import '../../features/add_booking/presentation/manager/add_booking_cubit.dart';

class AppHelper {
  static List<SingleChildWidget> providers = [
    BlocProvider(
      create: (context) => getIt<BookingCubit>(

      ),
    ),
    BlocProvider(
      create: (context) => getIt<BookingCubit1>(),
    ),

    BlocProvider(
      create: (context) => getIt<LayoutCubit>(),
    ),
  ];
}
