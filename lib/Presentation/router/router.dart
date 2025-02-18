import 'package:app/Presentation/views/pages/client_list.dart';
import 'package:app/Presentation/views/pages/home.dart';
import 'package:app/Presentation/views/pages/register_clients_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../Presentation/views/pages/login.dart';
import 'html_data.dart';
import 'page_data.dart';
import 'pages.dart';

class PageRouter {
  static final Map<Pages, PageData> _pageMap = {
    Pages.login: PageData(
      key: Pages.login,
      unbound: true,
      page: const LoginPage(),
      html: const HTMLData(route: '/login/'),
    ),
    Pages.home: PageData(
      key: Pages.home,
      unbound: true,
      page: HomePage(),
      html: const HTMLData(route: '/home/'),
    ),
    Pages.registerClient: PageData(
      key: Pages.registerClient,
      unbound: false,
      page: RegisterClientsPage(),
      html: const HTMLData(route: 'client/register/'),
    ),
    Pages.clientsList: PageData(
      key: Pages.clientsList,
      unbound: false,
      page: ClientList(),
      html: const HTMLData(route: '/client/list/'),
    ),
  };

  static const Duration duration = Duration(milliseconds: 300);
  static PageTransitionType defaultTransition = PageTransitionType.fade;

  static void goToPage(BuildContext context,
      {required Pages page, PageTransitionType? transition}) {
    final PageData? pageData = _pageMap[page];

    if (pageData == null) {
      debugPrint('⚠️ Page not found: $page');
      return;
    }

    final transitionType = transition ?? defaultTransition;

    pageData.unbound
        ? pageData.pushOver(context, transitionType)
        : pageData.push(context, transitionType);
  }
}
