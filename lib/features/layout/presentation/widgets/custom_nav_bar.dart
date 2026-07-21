
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';

class CustomNavBar extends StatefulWidget {
  final void Function(int)? onItemSelected;
  final List<PersistentBottomNavBarItem> items;
  final List<Widget> screens;
  final PersistentTabController controller;

  const CustomNavBar({
    super.key,
    this.onItemSelected,
    required this.items,
    required this.screens,
    required this.controller,
  });

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        resizeToAvoidBottomInset: true,

        navBarHeight: getProportionateScreenHeight(72),
        controller: widget.controller,

        context,
        // popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
        hideNavigationBarWhenKeyboardAppears: true,
        decoration: const NavBarDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          colorBehindNavBar: Colors.white,
        ),
        // margin: EdgeInsets.all(5),
        confineToSafeArea: true,
        onItemSelected: widget.onItemSelected,
        stateManagement: true,

        padding: EdgeInsets.symmetric(vertical: 5),
        screens: widget.screens,
        items: widget.items,
        navBarStyle: NavBarStyle.style6,
        backgroundColor: AppColors.white,
      ),
    );
  }
}
