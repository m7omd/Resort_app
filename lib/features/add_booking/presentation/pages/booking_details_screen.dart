import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:resort_app/core/utils/app_colors.dart';
import 'package:resort_app/core/utils/app_text__styles.dart';
import 'package:resort_app/features/booking/presentation/cubit/states.dart';
import 'package:resort_app/widgets/custom_app_bar.dart';
import '../../../../widgets/custom_list_tile.dart';
import '../../../booking/domain/entity/booking_entity.dart';
import '../../../booking/presentation/cubit/booking_cubit.dart';
import '../manager/add_booking_states.dart';

class BookingDetailsScreen extends StatelessWidget {
  final BookingEntity booking;
  BookingDetailsScreen({super.key, required this.booking});
  late final hijriText = HijriCalendar.fromDate(booking.bookingDate);
  late String dayName = DateFormat('EEEE', 'ar').format(booking.bookingDate); // هيطلع: الجمعة
  late String dayNumber = DateFormat('d').format(booking.bookingDate); // هيطلع رقم اليوم (مثلا: 10)
  late String monthName = DateFormat('MMMM', 'ar').format(booking.bookingDate);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF1F5),
      appBar: CustomAppBar(title: 'تفاصيل الحجز', showBack: true),
      body: BlocListener<BookingCubit, BookingStates>(
        listenWhen: (previous, current) =>
            current is BookingLoading || current is BookingSuccess || current is BookingFailure,
        listener: (context, state) {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
          child: Column(
            children: [
              Card(
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
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.lightGrey,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("$dayName", style: AppTextStyles.textstyle12_bold.copyWith(height: 1.0)),
                                Text("$dayNumber", style: AppTextStyles.textstyle12_regular.copyWith(height: 1.0,
                                    color: AppColors.primary
                                )),
                                Text(hijriText.hDay.toString(), style: AppTextStyles.textstyle12_regular.copyWith(height: 1.0
                                    , color: AppColors.red
                                )),
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
                              color: booking.isConfirm ? Colors.green.withOpacity(.12) : Colors.red.withOpacity(.12),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: booking.isConfirm ? Colors.green.withOpacity(.3) : Colors.red.withOpacity(.3),
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
                        title: Text("المبلغ الكلي", style: AppTextStyles.textstyle18_regular_black),
                        trailing: Text(
                          "${booking.totalPrice} ريال",
                          style: AppTextStyles.headingMedium.copyWith(color: Colors.green, fontSize: 18),
                        ),
                      ),
                      Divider(),
                      CustomListTile(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        title: Text("المبلغ المدفوع", style: AppTextStyles.textstyle18_regular_black),
                        trailing: Text(
                          "${booking.amountPaid} ريال",
                          style: AppTextStyles.headingMedium.copyWith(fontSize: 18),
                        ),
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
              const SizedBox(height: 20),

              Row(
                children: [
                  // زر التعديل
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      // onPressed: () async {
                      //   final bool? isUpdated = await Navigator.push<bool>(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => BlocProvider(
                      //         create: (context) => getIt<BookingCubit1>(),
                      //         child: AddBookingScreen(booking: booking),
                      //       ),
                      //     ),
                      //   );
                      //
                      //   if (isUpdated == true && context.mounted) {
                      //     GoRouter.of(context).pop();
                      //   }
                      // },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.primary, width: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        'تعديل',
                        style: TextStyle(color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // زر الحذف
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _showDeleteDialog(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.primary, width: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        'حذف',
                        style: TextStyle(color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: const Text('هل أنت متأكد من رغبتك في حذف هذا الحجز نهائياً؟'),
          actions: [
            TextButton(onPressed: () => context.pop(dialogContext), child: const Text('إلغاء')),
            TextButton(
              onPressed: () {
                context.pop(dialogContext);
                if (booking.id != null) {
                  context.read<BookingCubit>().removeBooking(booking.id!);
                  context.pop();
                }
              },
              child: const Text('حذف', style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        );
      },
    );
  }
}
