import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:resort_app/core/utils/app_colors.dart';
import 'package:resort_app/features/booking/domain/entity/booking_entity.dart';
import 'package:resort_app/features/booking/domain/entity/payment_status.dart';
import 'package:resort_app/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:resort_app/features/booking/presentation/cubit/states.dart';
import 'package:resort_app/features/layout/presentation/manager/layout_cubit.dart';
import 'package:resort_app/widgets/custom_app_bar.dart';
import 'package:resort_app/widgets/custom_button.dart';
import 'package:resort_app/widgets/custom_dropdown.dart';
import 'package:resort_app/widgets/custom_text_form_field.dart';
import 'package:resort_app/widgets/snackbar_error.dart';
import 'package:resort_app/widgets/snackbar_success.dart';
import '../../../../core/utils/imports.dart';
import '../../../add_booking/presentation/widgets/custom_date_picker_field.dart';
import '../widgets/hijiri_date_paicker.dart';

class CreateBookingView extends StatefulWidget {
  const CreateBookingView({super.key});

  @override
  State<CreateBookingView> createState() => _CreateBookingViewState();
}

class _CreateBookingViewState extends State<CreateBookingView> {
  late final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController();
  late final _phoneController = TextEditingController();
  late final _priceController = TextEditingController();
  late final _amountPaidController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  PaymentStatus _paymentStatus = PaymentStatus.unpaid;
  // أضف هذه الدالة داخل _CreateBookingViewState لتشغيل التقويم
  void _showDatePickerDialog(List<DateTime> bookedDates) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return HijriGregorianDatePickerBottomSheet(
          initialDate: _selectedDate,
          bookedDates: bookedDates, // تمرير التواريخ المحجوزة
          onDateSelected: (date) {
            setState(() {
              _selectedDate = date;
            });
          },
        );
      },
    );
  }

  late final hijriText = HijriCalendar.fromDate(_selectedDate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "إضافة حجز جديد", showBack: false),
      body: Padding(
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
                validator: (val) => val!.isEmpty ? 'من فضلك أدخل رقم الهاتف' : null,
              ),
              const SizedBox(height: 16),

              // المبلغ الكلي
              CustomTextFormField(
                enabled: context.read<BookingCubit>().isEnabled,
                controller: _priceController,
                keyboardType: TextInputType.number,
                hintText: 'المبلغ الكلي',
                labelText: 'المبلغ الكلي',
                validator: (val) => val!.isEmpty ? 'من فضلك أدخل المبلغ' : null,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                enabled: context.read<BookingCubit>().isEnabled,
                controller: _amountPaidController,
                keyboardType: TextInputType.number,
                hintText: 'المبلغ المدفوع',
                labelText: 'المبلغ المدفوع',
                // validator: (val) => val!.isEmpty ? 'من فضلك أدخل المبلغ' : null,
              ),
              const SizedBox(height: 16),

              // CustomDatePickerField(
              //   isEnabled: true,
              //   initialValue: "",
              //   label: "تاريخ الحجز",
              //   firstDate: DateTime.now(),
              //   initialDate: DateTime.now(),
              //   lastDate: DateTime(DateTime.now().year, 12, 31),
              //
              //   onDateSelected: (date) {
              //     if (date != null) {
              //       setState(() => _selectedDate = date);
              //     }
              //   },
              // ),
              // نص يوضح التاريخ الهجري للسهولة
              InkWell(
                onTap: () {
                  final bookedDates = context.read<BookingCubit>().bookedDates;
                  _showDatePickerDialog(bookedDates);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("تاريخ الحجز", style: TextStyle(fontSize: 12, color: Colors.grey)),
                          Text(
                            "${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day} م  (${hijriText.hDay} ${hijriText.longMonthName})",
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Icon(Icons.calendar_month_rounded, color: AppColors.primary),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              CustomDropDown<PaymentStatus>(
                hint: "حالة الدفع",
                label: "حالة الدفع",
                value: _paymentStatus,
                onChange: (value) {
                  if (value != null) {
                    setState(() => _paymentStatus = value);
                  }
                },
                items: PaymentStatus.values.map((status) {
                  return DropdownMenuItem<PaymentStatus>(value: status, child: Text(status.value));
                }).toList(),
              ),
              BlocBuilder<BookingCubit, BookingStates>(
                builder: (context, state) => SwitchListTile(
                  title: Text('تم تاكيد الحجز ؟', style: AppTextStyles.textstyle18_regular),
                  value: context.read<BookingCubit>().isConfirm,
                  onChanged: (bool value) => context.read<BookingCubit>().toggleConfirmStatus(value),
                ),
              ),
              const SizedBox(height: 32),

              BlocConsumer<BookingCubit, BookingStates>(
                listener: (context, state) {
                  if (state is SuccessAddBookingState) {
                    snackbarSuccess(context, "تم أضافة الحجز بنجاح");
                    _nameController.clear();
                    _amountPaidController.clear();
                    _phoneController.clear();
                    _priceController.clear();
                    context.read<LayoutCubit>().toggleNavBar(value: 0);
                  } else if (state is FailureAddBookingState) {
                    snackbarError(context, state.errorMessage);
                    // context.read<LayoutCubit>().toggleNavBar(value: 0);
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    title: "حفظ الحجز",
                    titleColor: AppColors.white,
                    color: AppColors.primary,
                    isEnabled: state is! LoadingAddBookingState,
                    isLoading: state is LoadingAddBookingState,
                    onPressed: () {
                      context.read<BookingCubit>().toggleEnabled();
                      if (_formKey.currentState!.validate()) {
                        final booking = BookingEntity(
                          customerName: _nameController.text.trim(),
                          phoneNumber: _phoneController.text.trim(),
                          totalPrice: double.parse(_priceController.text.trim()),
                          bookingDate: _selectedDate,
                          paymentStatus: _paymentStatus,
                          isConfirm: context.read<BookingCubit>().isConfirm,
                          amountPaid: double.tryParse(_amountPaidController.text.trim()) ?? 0.0,
                        );
                        context.read<BookingCubit>().addBooking(booking);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
