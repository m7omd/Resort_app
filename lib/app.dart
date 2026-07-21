import 'package:easy_localization/easy_localization.dart';

import 'config/routes/app_router.dart';
import 'core/utils/app_helper.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_size.dart';
import 'core/utils/app_strings.dart';
import 'core/utils/imports.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final langCode = context.locale.languageCode; // ar / en

    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: AppHelper.providers,
      child: MaterialApp.router(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeManger.appTheme(),
        routerConfig: AppRouter.router,

      ),
    );
  }
}
