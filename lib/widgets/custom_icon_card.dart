import '../../core/utils/app_colors.dart';
import '../../core/utils/imports.dart';

class CustomIconCard extends StatelessWidget {
  final IconData? icon;
  final Function()? onTap;
  const CustomIconCard({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(5)),
        width: 28,
        height: 28,
        child: Icon(
          icon,
          color: AppColors.grey,
        ),
      ),
    );
  }
}
