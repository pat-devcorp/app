import 'package:app/Presentation/riverpods/page_riverpod.dart';
import 'package:app/Presentation/views/pages/client_list.dart';
import 'package:app/Presentation/views/pages/home.dart';
import 'package:app/Presentation/views/pages/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    Pages.clients: PageData(
      key: Pages.clients,
      unbound: false,
      page: ClientList(),
      html: const HTMLData(route: '/client/register/'),
    ),
    Pages.transactions: PageData(
      key: Pages.transactions,
      unbound: false,
      page: TransactionsList(),
      html: const HTMLData(route: '/TransactionsList/list/'),
    ),
  };

  static const Duration duration = Duration(milliseconds: 300);
  static PageTransitionType defaultTransition = PageTransitionType.fade;

  static void goToPage(BuildContext context, WidgetRef ref, {required Pages page, PageTransitionType? transition}) {
    final PageData? pageData = _pageMap[page];

    ref.read(pageRiverpodProvider.notifier).changePage(page: page);

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
