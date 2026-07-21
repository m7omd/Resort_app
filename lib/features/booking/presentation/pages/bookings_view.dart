import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:resort_app/core/utils/app_colors.dart';
import 'package:resort_app/core/utils/app_text__styles.dart';
import 'package:resort_app/features/booking/presentation/cubit/states.dart';
import 'package:resort_app/widgets/custom_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:resort_app/widgets/custom_list_tile.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../core/utils/imports.dart';
import '../cubit/booking_cubit.dart';

class BookingsView extends StatefulWidget {
  const BookingsView({super.key});
  @override
  State<BookingsView> createState() => _BookingsViewState();
}
class _BookingsViewState extends State<BookingsView> {
  @override
  void initState() {
    super.initState();
    // بدء جلب البيانات فور فتح الشاشة
    context.read<BookingCubit>().getBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "الحجوزات"),
      body: BlocBuilder<BookingCubit, BookingStates>(
        // buildWhen: (previous, current) {
        //   // اسمح بإعادة البناء فقط لو الـ State الجديدة هي خاصة بالـ Home
        //   return current is HomeLoading || current is HomeSuccess || current is HomeFailure;
        // },
        builder: (context, state) {
          if (state is LoadingGetBookingsState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SuccessGetBookingsState) {
            final bookings = List.of(state.bookings);
            bookings.sort((a, b) => a.bookingDate.compareTo(b.bookingDate));
            if (bookings.isEmpty) {
              return const Center(child: Text('لا توجد حجوزات حالياً', style: TextStyle(fontSize: 18)));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(6),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                late final hijriText = HijriCalendar.fromDate(booking.bookingDate);

                String dayName = DateFormat('EEEE', 'ar').format(booking.bookingDate); // هيطلع: الجمعة
                String dayNumber = DateFormat('d').format(booking.bookingDate); // هيطلع رقم اليوم (مثلا: 10)
                String monthName = DateFormat(
                  'MMMM',
                  'ar',
                ).format(booking.bookingDate); // هيطلع اسم الشهر بالعربي (مثلا:
                return InkWell(
                  onTap: () {
                    context.push(AppRouter.kBookingDetails, extra: booking);
                  },

                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.lightGrey,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("$dayName", style: AppTextStyles.textstyle12_bold.copyWith(height: 1.0)),
                                    Text(
                                      "$dayNumber",
                                      style: AppTextStyles.textstyle12_regular.copyWith(
                                        height: 1.0,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    Text(
                                      hijriText.hDay.toString(),
                                      style: AppTextStyles.textstyle12_regular.copyWith(
                                        height: 1.0,
                                        color: AppColors.red,
                                      ),
                                    ),
                                    Text("$monthName", style: AppTextStyles.textstyle12_bold.copyWith(height: 1.0)),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
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
                                  Text(booking.phoneNumber, style: AppTextStyles.textstyle18_regular, softWrap: false),
                                ],
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                decoration: BoxDecoration(
                                  color: booking.isConfirm
                                      ? Colors.green.withOpacity(.12)
                                      : Colors.red.withOpacity(.12),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: booking.isConfirm
                                        ? Colors.green.withOpacity(.3)
                                        : Colors.red.withOpacity(.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      booking.isConfirm ? Icons.check_circle_outline : Icons.error_outline,
                                      size: 16,
                                      color: booking.isConfirm ? Colors.green[800] : Colors.red[800],
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      booking.isConfirm ? 'تم التاكيد' : 'غير مؤكد',
                                      style: TextStyle(
                                        color: booking.isConfirm ? Colors.green[800] : Colors.red[800],
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          CustomListTile(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            title: Text("المبلغ المدفوع", style: AppTextStyles.textstyle18_regular_black),
                            trailing: Text("${booking.amountPaid} ريال", style: AppTextStyles.headingMedium),
                          ),
                          Divider(),
                          CustomListTile(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            title: Text("حالة الدفع", style: AppTextStyles.textstyle18_regular_black),
                            trailing: Text(booking.paymentStatus.value, style: AppTextStyles.textstyle18_regular),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is FailureGetBookingsState) {
            return Center(
              child: Text('حدث خطأ: ${state.errorMessage}', style: const TextStyle(color: Colors.red)),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
