import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:resort_app/config/routes/app_router.dart';
import 'package:resort_app/core/utils/app_colors.dart';
import 'package:resort_app/core/utils/app_text__styles.dart';
import 'package:resort_app/features/add_booking/presentation/manager/add_booking_cubit.dart';
import 'package:resort_app/features/add_booking/presentation/manager/add_booking_states.dart';
import 'package:resort_app/widgets/custom_app_bar.dart';
import 'package:intl/intl.dart';
import '../../../../config/dependency_injection/service_locator.dart';
import 'add_booking_view.dart';
import 'booking_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // بدء جلب البيانات فور فتح الشاشة
    context.read<BookingCubit1>().fetchBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "الحجوزات"),
      body: BlocBuilder<BookingCubit1, BookingState>(
        buildWhen: (previous, current) {
          // اسمح بإعادة البناء فقط لو الـ State الجديدة هي خاصة بالـ Home
          return current is HomeLoading || current is HomeSuccess || current is HomeFailure;
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeSuccess) {
            final bookings = List.of(state.bookings);

            // 2. ترتيب القائمة من الأحدث للأقدم بناءً على الـ bookingDate
            bookings.sort((a, b) => a.bookingDate.compareTo(b.bookingDate));
            if (bookings.isEmpty) {
              return const Center(child: Text('لا توجد حجوزات حالياً', style: TextStyle(fontSize: 18)));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(14),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                String dayName = DateFormat('EEEE', 'ar').format(booking.bookingDate); // هيطلع: الجمعة
                String dayNumber = DateFormat('d').format(booking.bookingDate); // هيطلع رقم اليوم (مثلا: 10)
                String monthName = DateFormat(
                  'MMMM',
                  'ar',
                ).format(booking.bookingDate); // هيطلع اسم الشهر بالعربي (مثلا:
                return InkWell(
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kBookingDetails, extra: booking);
                  },
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.lightGrey,
                            ),
                            child: Column(
                              spacing: 0,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("$dayName", style: AppTextStyles.textstyle16_bold),
                                Text("$dayNumber", style: AppTextStyles.subtitle, softWrap: false),
                                Text("$monthName", style: AppTextStyles.textstyle16_bold),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                booking.customerName,
                                style: AppTextStyles.subtitle,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,

                              ),
                              // SizedBox(height: 4),
                              Text(booking.phoneNumber, style: AppTextStyles.subtitle, softWrap: false),
                              SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                                decoration: BoxDecoration(
                                  color: booking.isPaid ? Colors.green.withOpacity(0.12) : Colors.red.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: booking.isPaid ? Colors.green.withOpacity(0.5) : Colors.red.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      booking.isPaid ? Icons.check_circle_outline : Icons.error_outline,
                                      size: 16,
                                      color: booking.isPaid ? Colors.green[800] : Colors.red[800],
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      booking.isPaid ? 'تم الدفع' : 'لم يدفع',
                                      style: TextStyle(
                                        color: booking.isPaid ? Colors.green[800] : Colors.red[800],
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is HomeFailure) {
            return Center(
              child: Text('حدث خطأ: ${state.error}', style: const TextStyle(color: Colors.red)),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
