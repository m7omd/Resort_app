import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class HijriGregorianDatePickerBottomSheet extends StatefulWidget {
  final DateTime initialDate;
  final List<DateTime> bookedDates; // قائمة التواريخ المحجوزة مسبقاً
  final Function(DateTime selectedDate) onDateSelected;

  const HijriGregorianDatePickerBottomSheet({
    super.key,
    required this.initialDate,
    required this.bookedDates,
    required this.onDateSelected,
  });

  @override
  State<HijriGregorianDatePickerBottomSheet> createState() =>
      _HijriGregorianDatePickerBottomSheetState();
}

class _HijriGregorianDatePickerBottomSheetState
    extends State<HijriGregorianDatePickerBottomSheet> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.initialDate;
    _selectedDay = widget.initialDate;
  }

  // فحص هل اليوم محجوز أم لا (يتجاهل الوقت ويقارن اليوم/الشهر/السنة)
  bool _isBooked(DateTime day) {
    return widget.bookedDates.any((booked) =>
    booked.year == day.year &&
        booked.month == day.month &&
        booked.day == day.day);
  }

  // تحويل التاريخ إلى صيغة نصية هجرية
  String _formatHijri(DateTime date) {
    final hijri = HijriCalendar.fromDate(date);
    return '${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear} هـ';
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF0D5D6D);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // مقبض السحب الأعلى
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const Text(
            "اختر تاريخ الحجز",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // عرض التاريخ المختار (ميلادي + هجري)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "المحدد: ${_selectedDay.year}-${_selectedDay.month}-${_selectedDay.day} م  |  ${_formatHijri(_selectedDay)}",
              style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // التقويم التفاعلي
          TableCalendar(
            locale: 'ar',
            firstDay: DateTime.now(),
            lastDay: DateTime(DateTime.now().year, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

            // تعطيل الأيام المحجوزة ومنع الضغط عليها
            enabledDayPredicate: (day) => !_isBooked(day),

            onDaySelected: (selectedDay, focusedDay) {
              if (!_isBooked(selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },

            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            // تخصيص شكل أيام الشهر (الهجري والميلادي والدائرة الحمراء للمحجوز)
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) => _buildDayCell(day, isSelected: false),
              selectedBuilder: (context, day, focusedDay) => _buildDayCell(day, isSelected: true),
              todayBuilder: (context, day, focusedDay) => _buildDayCell(day, isToday: true),
              disabledBuilder: (context, day, focusedDay) {
                // شكل الأيام المحجوزة
                if (_isBooked(day)) {
                  return _buildBookedDayCell(day);
                }
                return null;
              },
            ),
          ),

          const SizedBox(height: 16),

          // زر التأكيد
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                widget.onDateSelected(_selectedDay);
                Navigator.pop(context);
              },
              child: const Text("تأكيد التاريخ", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  // بناء خلية اليوم الطبيعي أو المختار
  Widget _buildDayCell(DateTime day, {bool isSelected = false, bool isToday = false}) {
    final hijriDay = HijriCalendar.fromDate(day).hDay;
    const Color primaryColor = Color(0xFF0D5D6D);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSelected
            ? primaryColor
            : (isToday ? primaryColor.withOpacity(0.15) : Colors.transparent),
        shape: BoxShape.circle,
        border: isToday && !isSelected ? Border.all(color: primaryColor) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // اليوم الميلادي
          Text(
            '${day.day}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
          // اليوم الهجري
          Text(
            '$hijriDay',
            style: TextStyle(
              fontSize: 10,
              color: isSelected ? Colors.white70 : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // بناء خلية اليوم المحجوز (دائرة حمراء)
  Widget _buildBookedDayCell(DateTime day) {
    final hijriDay = HijriCalendar.fromDate(day).hDay;

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.red, width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${day.day}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          Text(
            '$hijriDay',
            style: TextStyle(
              fontSize: 9,
              color: Colors.red.shade300,
            ),
          ),
        ],
      ),
    );
  }
}