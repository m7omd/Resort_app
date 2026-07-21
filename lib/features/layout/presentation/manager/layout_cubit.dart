import 'package:easy_localization/easy_localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../../core/data/data_source/local/cache_helper.dart';
import '../../../../core/utils/imports.dart';
import 'layout_states.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(InitialLayoutState());

  // void changeLanguage(Locale locale, BuildContext context) {
  //   emit(locale);
  //   CacheHelper.saveLanguageCode(locale.languageCode);
  //   context.setLocale(locale);
  // }

  int index = 0;
  final PersistentTabController controller = PersistentTabController();

  void toggleNavBar({required int value}) {
    index = value;
    controller.jumpToTab(value);
    emit(ChangeNavBarState());
  }
}
