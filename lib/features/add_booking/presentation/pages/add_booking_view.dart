import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resort_app/core/utils/app_colors.dart';
import 'package:resort_app/widgets/custom_app_bar.dart';
import 'package:resort_app/widgets/custom_button.dart';
import 'package:resort_app/widgets/custom_text_form_field.dart';
import 'package:resort_app/widgets/snackbar_error.dart';
import 'package:resort_app/widgets/snackbar_success.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../core/utils/imports.dart';
import '../../domain/entities/booking_entity.dart';
import '../manager/add_booking_cubit.dart';
import '../manager/add_booking_states.dart';
import '../widgets/custom_date_picker_field.dart';

class AddBookingScreen extends StatefulWidget {
  final BookingEntity? booking; // معامل اختياري: لو موجود يبقى تعديل، لو null يبقى إضافة
  const AddBookingScreen({super.key, this.booking});

  @override
  State<AddBookingScreen> createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  late final _formKey = GlobalKey<FormState>();
  late var _nameController = TextEditingController();
  late var _phoneController = TextEditingController();
  late var _priceController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  bool _isPaid = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  bool get isEditMode => widget.booking != null; // متغير يحدد هل إحنا في وضع التعديل أم لا

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: isEditMode ? widget.booking!.customerName : '');
    _phoneController = TextEditingController(text: isEditMode ? widget.booking!.phoneNumber : '');
    _priceController = TextEditingController(text: isEditMode ? widget.booking!.totalPrice.toStringAsFixed(0) : '');

    _selectedDate = isEditMode ? widget.booking!.bookingDate : DateTime.now();
    _isPaid = isEditMode ? widget.booking!.isPaid : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "إضافة حجز جديد", showBack: isEditMode ? true : false),
      body: BlocListener<BookingCubit1, BookingState>(
        listener: (context, state) {
          if (state is BookingLoading) {
            showDialog(
              context: context,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else if (state is BookingSuccess) {
            GoRouter.of(context);
            snackbarSuccess(context, 'تم حفظ الحجز بنجاح');
            GoRouter.of(context).go(AppRouter.kHomeView);
          } else if (state is BookingFailure) {
            GoRouter.of(context);
            snackbarError(context, 'خطأ: ${state.error}');
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // اسم العميل
                CustomTextFormField(
                  controller: _nameController,
                  hintText: 'اسم العميل',
                  labelText: 'اسم العميل',
                  validator: (val) => val!.isEmpty ? 'من فضلك أدخل الاسم' : null,
                ),
                const SizedBox(height: 16),

                CustomTextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  hintText: 'رقم الهاتف',
                  labelText: 'رقم الهاتف',
                  // decoration: const InputDecoration(labelText: 'رقم الهاتف', border: OutlineInputBorder()),
                  validator: (val) => val!.isEmpty ? 'من فضلك أدخل رقم الهاتف' : null,
                ),
                const SizedBox(height: 16),

                // المبلغ الكلي
                CustomTextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  hintText: 'المبلغ الكلي',
                  labelText: 'المبلغ الكلي',
                  validator: (val) => val!.isEmpty ? 'من فضلك أدخل المبلغ' : null,
                ),
                const SizedBox(height: 16),
                CustomDatePickerField(
                  isEnabled: true,
                  initialValue: isEditMode ? "${widget.booking!.bookingDate}" : "",
                  label: "تاريخ الحجز",
                  firstDate: DateTime.now(),
                  initialDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year, 12, 31),

                  onDateSelected: (date) {
                    if (date != null) {
                      setState(() => _selectedDate = date);
                    }
                  },
                ),
                const SizedBox(height: 16),

                // تم الدفع أم لا (Checkbox or Switch)
                SwitchListTile(
                  title: const Text('تم الدفع؟'),
                  value: _isPaid,
                  onChanged: (bool value) => setState(() => _isPaid = value),
                ),
                const SizedBox(height: 32),

                // زر الحفظ
                CustomButton(
                  title: "حفظ الحجز",
                  titleColor: AppColors.white,
                  color: AppColors.primary,

                  // onPressed: () {
                  //   if (_formKey.currentState!.validate()) {
                  //     final booking = BookingEntity(
                  //       customerName: _nameController.text.trim(),
                  //       phoneNumber: _phoneController.text.trim(),
                  //       totalPrice: double.parse(_priceController.text.trim()),
                  //       bookingDate: _selectedDate,
                  //       isPaid: _isPaid,
                  //     );
                  //     context.read<BookingCubit>().createBooking(booking);
                  //   }
                  // },
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final updatedBooking = BookingEntity(
                        id: isEditMode
                            ? widget.booking!.id
                            : null, // بنمرر الـ ID القديم لو تعديل عشان يروح للـ Firestore يعدل نفس الدوكيومنت
                        customerName: _nameController.text.trim(),
                        phoneNumber: _phoneController.text.trim(),
                        totalPrice: double.parse(_priceController.text.trim()),
                        bookingDate: _selectedDate,
                        isPaid: _isPaid,
                      );

                      if (isEditMode) {
                        // تشغيل لوجيك التعديل
                        context.read<BookingCubit1>().editBooking(updatedBooking);
                      } else {
                        // تشغيل لوجيك الإضافة الجديد
                        context.read<BookingCubit1>().createBooking(updatedBooking);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
