import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/view/menu/menu_view.dart';
import 'package:wordflow/view/settings/settings_view.dart';

import 'core/constans/app_constants.dart';
import 'core/init/cache/cache_manager.dart';
import 'core/init/language/language_manager.dart';
import 'core/init/navigation/navigation_route.dart';
import 'core/init/navigation/navigation_service.dart';
import 'core/init/provider/app_provider.dart';
import 'core/init/theme/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await CacheManager.sharedPreferencesInit();

  runApp(
    MultiProvider(
      providers: [
        ...ApplicationProvider.instance!.dependItems,
      ],
      child: EasyLocalization(
        supportedLocales: LanguageManager.instance!.supportedLocales,
        path: ApplicationConstants.languagesAsset,
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      theme: context.watch<ThemeManager>().currentTheme(),
      home: const MenuView(),
    );
  }
}
