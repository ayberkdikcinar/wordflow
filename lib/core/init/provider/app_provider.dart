import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:wordflow/view/menu/menu_viewmodel.dart';
import 'package:wordflow/view/settings/settings_viewmodel.dart';

import '../theme/theme_manager.dart';

class ApplicationProvider {
  static ApplicationProvider? _instance;
  static ApplicationProvider? get instance {
    if (_instance == null) return _instance = ApplicationProvider._init();
    return _instance;
  }

  ApplicationProvider._init();

  List<SingleChildWidget> singleItems = [];
  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(
      create: (context) => ThemeManager(),
    ),
    ChangeNotifierProvider(
      create: (context) => SettingsViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => MenuViewModel(),
    ),
    /*Provider<MyFirebaseAuth>(
      create: (context) => MyFirebaseAuth(FirebaseAuth.instance),
    ),*/
    /*StreamProvider(
      create: (context) => context.read<MyFirebaseAuth>().authStatus,
      initialData: null,
    ),*/
  ];
  List<SingleChildWidget> uiChangesItems = [];
}
