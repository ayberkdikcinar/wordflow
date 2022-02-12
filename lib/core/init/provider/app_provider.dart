import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

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
