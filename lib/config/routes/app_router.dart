import 'package:resort_app/features/booking/domain/entity/booking_entity.dart';
import 'package:resort_app/features/add_booking/presentation/pages/booking_details_screen.dart';
import '../../core/utils/imports.dart';
import '../../features/layout/presentation/pages/home_layout.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

abstract class AppRouter {
  static const kLoginView = "/MobileLogin";
  static const kHomeView = "/home";
  static const kBookingDetails = "/booking_details";

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: kHomeView,
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(child: Text('Page not found: ${state.uri}')),
    ),
    routes: <RouteBase>[
      GoRoute(path: kHomeView, builder: (context, state) => HomeLayout()),
      GoRoute(
        path: kBookingDetails,
        builder: (context, state) {
          if (state.extra is! BookingEntity) {
            return const Scaffold(body: Center(child: Text("Booking data is missing")));
          }
          final booking = state.extra as BookingEntity;
          return BookingDetailsScreen(booking: booking);
        },
      ),
    ],
  );
}
