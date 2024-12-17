import 'package:flutter/material.dart';

import '../../features/initialization/view/initialization.dart';
import '../../features/initialization/view/login.dart';
import '../widgets/custom_bottom_navigator.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> getRoutes() {
    var routes = {
      '/PostLogoutScreen': (context) => const LoginPage(),
      '/HomeScreen': (context) => const CustomBottomNavigator(),
      '/InitializationScreen': (context) => const InitializationPage(),
    };
    return {
      ...routes,
    };
  }
}
