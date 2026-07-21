import '../../core/utils/imports.dart';

class CustomListTile extends StatelessWidget {
  final Widget? title;
  final Widget? subTitle;
  final Widget? trailing;
  final Widget? leading;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;
  const CustomListTile({super.key, this.title, this.subTitle, this.padding, this.onTap, this.trailing, this.leading});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: padding ?? EdgeInsets.zero,
      minVerticalPadding: 5,
      minTileHeight: 0,
      visualDensity: const VisualDensity(vertical: 0, horizontal: 0),
      horizontalTitleGap: 10,
      minLeadingWidth: 0,
      dense: true,
      titleAlignment: ListTileTitleAlignment.center,
      title: title,
      subtitle: subTitle,
      onTap: onTap,
      trailing: trailing,
      leading: leading,
    );
  }
}
