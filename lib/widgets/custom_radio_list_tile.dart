import '../../core/utils/app_colors.dart';
import '../../core/utils/imports.dart';

class CustomRadioListTile<T> extends StatelessWidget {
  final T value;
  final T? groupValue; // groupValue can be null
  final ValueChanged<T?>? onChanged; // onChanged now accepts nullable T
  final String title;

  const CustomRadioListTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.title,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: RadioListTile<T?>(
        value: value,
        toggleable: true,
        dense: true,
        title: Text(title, style:AppTextStyles.textstyle13_regular),
        activeColor: AppColors.primary,
        groupValue: groupValue,
        onChanged: onChanged, // Accepts a function that handles nullable T
        contentPadding: EdgeInsets.zero,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        // controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }
}
