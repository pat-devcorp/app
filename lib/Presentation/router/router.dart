import 'package:app/Presentation/views/pages/home.dart';

import 'page_data.dart';
import 'model/pages.dart';
import 'model/html_data.dart';
import '../../Presentation/views/pages/login.dart';

import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

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
      page: const HomePage(),
      html: const HTMLData(route: '/home/'),
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