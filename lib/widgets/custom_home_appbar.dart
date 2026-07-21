// import 'package:car_help/config/function/app_router.dart';
// import 'package:car_help/config/helper/cache_helper.dart';
// import 'package:car_help/config/helper/helper.dart';
// import 'package:car_help/core/utils/app_assets.dart';
// import 'package:car_help/core/utils/app_size.dart';
// import 'package:car_help/core/utils/app_strings.dart';
// import 'package:car_help/core/utils/app_styles.dart';
// import 'package:car_help/features/Notification/Presentation/widgets/custom_button_notification.dart';
// import 'package:car_help/features/addresses/presentation/manager/addresses%20cubit/transaction_details_cubit.dart';
// import 'package:car_help/features/home_client/presentation/home_helper.dart';
// import 'package:car_help/features/home_client/presentation/manager/home%20client%20cubit/home_client_cubit.dart';
// import 'package:car_help/features/home_client/presentation/widgets/location_bottom_sheet_body.dart';
// import 'package:car_help/features/profile/Presentation/profile_helper.dart';
// import 'package:car_help/features/widgets/snackbar_error.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
//
// class CustomHomeAppBar extends StatefulWidget {
//   final String title;
//   final String? userType;
//   final void Function(
//     String? lat,
//     String? lon,
//     String? address,
//   )? latLng;
//   const CustomHomeAppBar(
//       {super.key, required this.title, this.userType, this.latLng});
//
//   @override
//   State<CustomHomeAppBar> createState() => _CustomHomeAppBarState();
// }
//
// class _CustomHomeAppBarState extends State<CustomHomeAppBar> {
//   String? location;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: Row(
//         children: [
//           BlocConsumer<AddressesCubit, AddressesState>(
//             listener: (context, state) {
//               if (state is AddressesFailure) {
//                 if (state.errorMessage == AppStrings.unauthorized) {
//                   ProfileHelper.showCustomUnauthorizedDialog(
//                     context: context,
//                     onPressd: () {
//                       CacheHelper().deleteCache();
//                       refreshMessagesToken();
//                       GoRouter.of(context)
//                           .pushReplacement(AppRouter.kOnBoardingView);
//                     },
//                   );
//                 } else {
//                   snackbarError(context, state.errorMessage);
//                 }
//               } else if (state is AddressesSuccess) {
//                 if (state.data.isEmpty) {
//                   HomeHelper.showBottomSheetDialog(
//                       context: context,
//                       widget: const LocationBottomSheetBody());
//                 } else {
//                   // snackbarSuccess(context, S.of(context).addAddressSuccess);
//                   for (var element in state.data) {
//                     if (element.isDefault == 1) {
//                       setState(() {
//                         location = element.address;
//                         if (widget.latLng != null) {
//                           widget.latLng!(
//                               element.lat, element.lng, element.address);
//                         }
//                       });
//                       if (widget.userType == AppStrings.client) {
//                         BlocProvider.of<HomeClientCubit>(context)
//                             .getHome(lat: element.lat, lng: element.lng);
//                       }
//                       break;
//                     }
//                   }
//                 }
//               }
//             },
//             builder: (context, state) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.title,
//                     style: AppStyles.textStyle14_700Black,
//                   ),
//                   if (widget.userType != AppStrings.both)
//                     InkWell(
//                       onTap: () =>
//                           GoRouter.of(context).push(AppRouter.kAddressesView),
//                       child: Row(
//                         children: [
//                           if (widget.userType == AppStrings.client)
//                             SvgPicture.asset(AppAssets.locationIcon),
//                           SizedBox(
//                             width: SizeConfig.screenWidth * 0.4,
//                             child: Text(
//                               location ?? '',
//                               overflow: TextOverflow.ellipsis,
//                               style: AppStyles.textStyle12_500,
//                               maxLines: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                 ],
//               );
//             },
//           ),
//           const Spacer(),
//           const CustomButtonNotification(accountType: AppStrings.client),
//         ],
//       ),
//     );
//   }
// }
