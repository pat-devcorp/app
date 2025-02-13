import 'page_data.dart';
import 'pages.dart';
import 'web/html_data.dart';
import '../../Presentation/views/pages/home.dart';
import '../../Presentation/views/pages/login.dart';
import '../../Presentation/views/pages/client_page.dart';

import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

class PageRouter {
  static final Map<Pages, PageData> _pageMap = {
    Pages.home: PageData(
      key: Pages.home,
      unbound: true,
      page: const LoginPage(),
      html: const HTMLData(route: '/home/'),
    ),
    Pages.welcome: PageData(
      key: Pages.welcome,
      unbound: true,
      page: const Home(),
      html: const HTMLData(route: '/welcome/'),
    ),
    Pages.client: PageData(
      key: Pages.client,
      unbound: false,
      page: const ClientPage(),
      html: const HTMLData(route: '/client/'),
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