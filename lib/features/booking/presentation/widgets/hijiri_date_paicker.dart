import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class HijriGregorianDatePickerBottomSheet extends StatefulWidget {
  final DateTime initialDate;
  final List<DateTime> bookedDates;
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

    // 1. نبدأ بالتاريخ المبدئي المُمرر
    DateTime candidateDate = _normalizeDate(widget.initialDate);

    // 2. لو كان التاريخ المبدئي (مثلاً اليوم 22) محجوزاً، ابحث عن أول يوم متاح بعده
    while (_checkIsBooked(candidateDate)) {
      candidateDate = candidateDate.add(const Duration(days: 1));
    }

    // 3. تعيين اليوم المختار ليكون اليوم المتاح فوراً
    _selectedDay = candidateDate;
    _focusedDay = candidateDate;
  }

  // دالة مساعدة لتطبيع التاريخ وإلغاء الساعات والدقائق
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  // فحص هل تاريخ معين محجوز أم لا
  bool _checkIsBooked(DateTime day) {
    final normalized = _normalizeDate(day);
    return widget.bookedDates.any((booked) => _normalizeDate(booked) == normalized);
  }

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

          TableCalendar(
            locale: 'ar',
            firstDay: DateTime.now().subtract(const Duration(days: 1)),
            lastDay: DateTime(DateTime.now().year, 12, 31),
            focusedDay: _focusedDay,

            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            enabledDayPredicate: (day) => !_checkIsBooked(day),

            onDaySelected: (selectedDay, focusedDay) {
              if (!_checkIsBooked(selectedDay)) {
                setState(() {
                  _selectedDay = _normalizeDate(selectedDay);
                  _focusedDay = _normalizeDate(focusedDay);
                });
              }
            },

            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) => _buildDayCell(day, isSelected: false),
              selectedBuilder: (context, day, focusedDay) => _buildDayCell(day, isSelected: true),
              todayBuilder: (context, day, focusedDay) => _buildDayCell(day, isToday: true),
              disabledBuilder: (context, day, focusedDay) {
                if (_checkIsBooked(day)) {
                  return _buildBookedDayCell(day);
                }
                return null;
              },
            ),
          ),

          const SizedBox(height: 16),

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

  Widget _buildDayCell(DateTime day, {bool isSelected = false, bool isToday = false}) {
    final hijriDay = HijriCalendar.fromDate(day).hDay;
    const Color primaryColor = Color(0xFF0D5D6D);

    return Container(
      margin: const EdgeInsets.all(4),
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
          Text(
            '${day.day}',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
          Text(
            '$hijriDay',
            style: TextStyle(
              fontSize: 9,
              color: isSelected ? Colors.white70 : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

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