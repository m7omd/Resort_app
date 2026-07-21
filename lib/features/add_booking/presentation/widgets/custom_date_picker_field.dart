import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../widgets/custom_text_form_field.dart';


// class CustomDatePickerField extends StatefulWidget {
//   final String label;
//   final DateTime? initialDate;
//   final DateTime? firstDate;
//   final DateTime? lastDate;
//   final bool isEnabled;
//
//   final ValueChanged<DateTime>? onDateSelected;
//   final String? initialValue; // التاريخ جاي من الـ API كـ String
//
//   const CustomDatePickerField({
//     Key? key,
//     required this.label,
//     this.initialDate,
//     this.firstDate,
//     this.lastDate,
//     this.isEnabled=true,
//     this.onDateSelected,
//     this.initialValue,
//   }) : super(key: key);
//
//   @override
//   _CustomDatePickerFieldState createState() => _CustomDatePickerFieldState();
// }
//
// class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
//   late TextEditingController _controller;
//   DateTime? _selectedDate;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController();
//
//     if (widget.initialValue != null) {
//       try {
//         _selectedDate = DateTime.parse(widget.initialValue!); // parse من الـ API
//         _controller.text = DateFormat('dd/MM/yyyy').format(_selectedDate!); // عرض التاريخ
//       } catch (e) {
//         debugPrint("❌ Error parsing date: $e");
//       }
//     }
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime initial = _selectedDate ?? widget.initialDate ?? DateTime.now();
//
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: initial,
//       firstDate: widget.firstDate ?? DateTime(2020),
//       lastDate: widget.lastDate ?? DateTime(2090),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.light(
//               primary: AppColors.primary, // لون التحديد واليوم المختار
//               onPrimary: Colors.white, // لون النص فوق اليوم المختار
//               onSurface: Colors.black87, // لون النصوص
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: AppColors.primary,
//                 textStyle: const TextStyle(fontWeight: FontWeight.w600),
//               ),
//             ),
//             dialogTheme: DialogThemeData(
//               backgroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 side: BorderSide(color: Colors.grey.shade300, width: 1),
//               ),
//               elevation: 5,
//             ),
//             textTheme: const TextTheme(
//               headlineMedium: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//               bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (pickedDate != null) {
//       setState(() {
//         _selectedDate = pickedDate;
//         _controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
//       });
//       widget.onDateSelected?.call(pickedDate);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomTextFormField(
//       controller: _controller,
//       readOnly: true,
//       enabled: widget.isEnabled,
//       labelText: widget.label,
//       onTap: () => _selectDate(context),
//       height: 45,
//       prefix:  Icon(Icons.date_range,color: AppColors.primary,),
//     );
//   }
// }





class CustomDatePickerField extends StatefulWidget {
  final String label;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool isEnabled;
  final List<DateTime>? occupiedDates; // ◀ الحقل الجديد لتمرير التواريخ المحجوزة

  final ValueChanged<DateTime>? onDateSelected;
  final String? initialValue; // التاريخ جاي من الـ API كـ String

  const CustomDatePickerField({
    Key? key,
    required this.label,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.isEnabled = true,
    this.occupiedDates, // ◀ إضافته هنا في الـ Constructor
    this.onDateSelected,
    this.initialValue,
  }) : super(key: key);

  @override
  _CustomDatePickerFieldState createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  late TextEditingController _controller;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    if (widget.initialValue != null) {
      try {
        _selectedDate = DateTime.parse(widget.initialValue!); // parse من الـ API
        _controller.text = DateFormat('dd/MM/yyyy').format(_selectedDate!); // عرض التاريخ
      } catch (e) {
        debugPrint("❌ Error parsing date: $e");
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime initial = _selectedDate ?? widget.initialDate ?? DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: widget.firstDate ?? DateTime(2020),
      lastDate: widget.lastDate ?? DateTime(2090),

      // ◀ لوجيك منع اختيار الأيام المحجوزة
      selectableDayPredicate: (DateTime date) {
        if (widget.occupiedDates == null) return true; // لو مفيش تواريخ ممررة سيب كله مفتوح

        // التحقق لو اليوم الحالي متطابق مع أي يوم في اللستة
        return !widget.occupiedDates!.any((occupiedDate) =>
        occupiedDate.year == date.year &&
            occupiedDate.month == date.month &&
            occupiedDate.day == date.day);
      },

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary, // لون التحديد واليوم المختار
              onPrimary: Colors.white, // لون النص فوق اليوم المختار
              onSurface: Colors.black87, // لون النصوص للأيام العادية
            ),

            // ◀ تلوين الأيام المقفولة (المحجوزة) باللون الأحمر المطفأ نفس الصورة
            disabledColor: Colors.red.shade400,

            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
              elevation: 5,
            ),
            textTheme: const TextTheme(
              headlineMedium: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
      widget.onDateSelected?.call(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: _controller,
      readOnly: true,
      enabled: widget.isEnabled,
      labelText: widget.label,
      onTap: () => _selectDate(context),
      height: 45,
      prefix: Icon(Icons.date_range, color: AppColors.primary),
    );
  }
}