import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resort_app/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:resort_app/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:resort_app/features/booking/presentation/cubit/states.dart';

class StaticsScreen extends StatelessWidget {
  const StaticsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF0D5D6D);
    const Color orangeColor = Color(0xFFE28731);
    return Scaffold(
      backgroundColor: const Color(0xFFEBF1F5),
      appBar: AppBar(
        title: const Text(
          'إحصائيات الشهر',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: BlocBuilder<BookingCubit, BookingStates>(
        builder: (context, state) {
          if (state is LoadingGetBookingsState) {
            return const Center(child: CircularProgressIndicator(color: primaryColor));
          } else if (state is SuccessGetBookingsState) {
            final bookings = state.bookings;

            // --- اللوجيك والحسابات أوتوماتيكياً ---
            int totalBookings = bookings.length;

            double totalExpectedIncome = 0;
            double totalReceivedIncome = 0;
            double totalRemainingIncome = 0;

            int paidInFullCount = 0;
            int partialPaidCount = 0;

            for (var booking in bookings) {
              // 1. حساب إجمالي الدخل المتوقع والمستلم
              totalExpectedIncome += booking.totalPrice;
              totalReceivedIncome += booking.amountPaid;

              // 2. التحقق مما إذا كان الحجز مدفوعاً بالكامل أم جزئياً
              if (booking.amountPaid >= booking.totalPrice) {
                paidInFullCount++;
              } else {
                partialPaidCount++;
              }
            }

            // 3. حساب إجمالي المبلغ المتبقي بعد جمع كل الحجوزات
            totalRemainingIncome = totalExpectedIncome - totalReceivedIncome;

            // التأكد من عدم وجود قيم سالبة في حال تم دفع مبلغ أكبر من المطلوب بالخطأ
            if (totalRemainingIncome < 0) totalRemainingIncome = 0;

            // حساب النسبة المئوية للحجز بالكامل لشريط التقدم
            double paidFullRatio = totalBookings > 0 ? (paidInFullCount / totalBookings) : 0.0;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // 1. كارت إجمالي الحجوزات
                  _buildStatCard(title: "إجمالي الحجوزات", value: "$totalBookings", isBig: true),
                  const SizedBox(height: 12),

                  // 2. كارت إجمالي الدخل المتوقع
                  _buildStatCard(
                    title: "إجمالي الدخل المتوقع",
                    value: "${totalExpectedIncome.toStringAsFixed(0)} ج.م",
                    isBig: true,
                  ),
                  const SizedBox(height: 12),

                  // 3. صف الكروت الصغيرة (المبلغ المتبقي والمبلغ المستلم)
                  Row(
                    children: [
                      // كارت المبلغ المتبقي (يمين في التصميم العربي)
                      Expanded(
                        child: _buildStatCard(
                          title: "المبلغ المتبقي",
                          value: "${totalRemainingIncome.toStringAsFixed(0)} ج.م",
                          valueColor: const Color(0xFFC53030), // لون أحمر غامق
                          icon: const Icon(Icons.warning_amber_rounded, color: Color(0xFFC53030), size: 20),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // كارت المبلغ المستلم (يسار في التصميم العربي)
                      Expanded(
                        child: _buildStatCard(
                          title: "المبلغ المستلم",
                          value: "${totalReceivedIncome.toStringAsFixed(0)} ج.م",
                          valueColor: const Color(0xFF2F855A), // لون أخضر غامق
                          icon: const Icon(Icons.check_circle_rounded, color: Color(0xFF2F855A), size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // 4. كارت مصدر الدخل والشريط البياني (نسخة آمنة ضد الـ flex 0)
                  Card(
                    color: Colors.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "مصدر الدخل",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          const SizedBox(height: 16),

                          // شريط التقدم الملون المخصص باستخدام الـ Stack لتفادي مشاكل الـ Spacer
                          Container(
                            height: 16,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: orangeColor, // لون الخلفية البرتقالي الافتراضي (جزئياً)
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Stack(
                                  children: [
                                    // الجزء البترولي (الحجز بالكامل) يتمدد ديناميكياً حسب النسبة
                                    FractionallySizedBox(
                                      widthFactor: paidFullRatio, // النسبة بين 0.0 و 1.0
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          // لو النسبة 100% بنخلي الحواف دائرية بالكامل، لو أقل بيبقى دائري من اليمين فقط نفس الصورة
                                          borderRadius: paidFullRatio == 1.0
                                              ? BorderRadius.circular(8)
                                              : const BorderRadius.only(
                                                  topRight: Radius.circular(8),
                                                  bottomRight: Radius.circular(8),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),

                          // مفتاح الألوان تحت الشريط
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _buildLegendItem("تم الدفع: جزئياً", orangeColor),
                              const SizedBox(width: 24),
                              _buildLegendItem("الحجز بالكامل", primaryColor),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is FailureGetBookingsState) {
            return Center(child: Text('حدث خطأ أثناء تحميل البيانات: ${state.errorMessage}'));
          }
          return const Center(child: Text('لا توجد بيانات متاحة حالياً'));
        },
      ),
    );
  }

  // ودجت مساعد لبناء الكروت بشكل موحد ومتطابق مع الصورة
  Widget _buildStatCard({
    required String title,
    required String value,
    bool isBig = false,
    Color? valueColor,
    Widget? icon,
  }) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: isBig ? 24.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // محاذاة النص لليمين مثل الصورة
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: icon != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
              children: [
                if (icon != null) icon,
                Text(
                  value,
                  style: TextStyle(
                    fontSize: isBig ? 26 : 20,
                    // fontWeight: FontWeight.black,
                    color: valueColor ?? Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ودجت بناء مفتاح الألوان (Legend)
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54),
        ),
        const SizedBox(width: 8),
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
        ),
      ],
    );
  }
}
