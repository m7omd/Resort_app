import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resort_app/features/add_booking/presentation/pages/add_booking_view.dart';
import 'package:resort_app/features/add_booking/presentation/pages/home_view.dart';
import 'package:resort_app/features/booking/presentation/pages/bookings_view.dart';
import 'package:resort_app/features/layout/presentation/manager/layout_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../add_booking/presentation/pages/statics_screen.dart';
import '../../../booking/presentation/pages/create_booking_view.dart';
import '../../../booking/presentation/pages/statics_screen.dart';
import '../manager/layout_states.dart';
import '../widgets/custom_nav_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PersistentBottomNavBarItem itemStyle(IconData icon, int index, String title) {
      final bool isActive = context.read<LayoutCubit>().index == index;
      return PersistentBottomNavBarItem(
        title: title,
        iconSize: 28,
        inactiveColorPrimary: AppColors.black,
        icon: isActive && index != 0
            ? Icon(
                icon,
                size: 28,

                // height: getProportionateScreenHeight(32),
                // width: getProportionateScreenWidth(32),
                // size: 25,
              )
            : Icon(
                icon,
                size: 28,
                // height: getProportionateScreenHeight(32),
                // width: getProportionateScreenWidth(32),
                // size: 25,
              ),

        activeColorPrimary: AppColors.primary,
        activeColorSecondary: AppColors.primary,
        textStyle: const TextStyle(
          // fontFamily: AppStrings.arabicFont,
          fontSize: 15,
          height: 0,
          color: Colors.grey,
          fontWeight: FontWeight.w700,
        ),
      );
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        itemStyle(Icons.date_range_sharp, 0, "الحجوزات"),
        itemStyle(Icons.add, 1, "إضافة حجز"),
        itemStyle(Icons.stacked_bar_chart, 2, "الاحصائيات"),
      ];
    }

    return  BlocBuilder<LayoutCubit,LayoutStates>(builder: (context,state) {
      return CustomNavBar(
        items: navBarsItems(),
        controller: context.read<LayoutCubit>().controller,
        onItemSelected: (index) {
          context.read<LayoutCubit>().toggleNavBar(value: index);
            print("indexxxx$index");

        },
        screens: [
          const BookingsView(),
          const CreateBookingView(),
          const StaticsScreen(),

        ],
      );

    });
  }
}
