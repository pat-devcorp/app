import 'package:app/presentation/views/pages/settings_page.dart';

import '../views/pages/home_page.dart';
import '../views/pages/login_page.dart';
import 'web/html_data.dart';
import 'middlewate/utils.dart';
import 'page_data.dart';
import 'pages.dart';

final Map<Pages, PageData> pageMap = {
  Pages.login: PageData(
    key: Pages.login,
    unbound: true,
    page: const LoginPage(),
    html: const HTMLData(route: '/login/'),
    preConditions: [checkLoginPreCondition],
    postConditions: [logPageTransitionPostCondition],
  ),
  Pages.home: PageData(
    key: Pages.home,
    unbound: true,
    page: HomePage(),
    html: const HTMLData(route: '/home/'),
    preConditions: [checkSomeOtherCondition],
    postConditions: [logPageTransitionPostCondition],
  ),
  Pages.settings: PageData(
    key: Pages.settings,
    unbound: true,
    page: SettingsPage(),
    html: const HTMLData(route: '/setting/'),
    preConditions: [checkSomeOtherCondition],
    postConditions: [logPageTransitionPostCondition],
  ),
};