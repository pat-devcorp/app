import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'page_data.dart';
import 'page_map.dart';
import 'pages.dart';

class PageRouter {
  static Future<void> goToPage(BuildContext context,
      {required Pages page, PageTransitionType? transition}) async {
    final PageData? pageData = pageMap[page];

    if (pageData == null) {
      log('⚠️ Page not found: $page');
      return;
    }

    for (final precondition in pageData.preConditions) {
      final canProceed = await precondition(context, page);
      if (!canProceed) {
        log('⚠️ Precondition failed for $page');
        return;
      }
    }

    final transitionType = transition ?? PageTransitionType.fade;

    Future<void> navigationFuture;
    if (pageData.unbound) {
      navigationFuture = pageData.pushOver(context, transitionType);
    } else {
      navigationFuture = pageData.push(context, transitionType);
    }

    await navigationFuture;

    for (final postCondition in pageData.postConditions) {
      log('🔹 Running postCondition: ${postCondition.runtimeType}');
      final success = await postCondition(context, page);
      if (!success) {
        log('⚠️ Postcondition failed for $page');
      }
    }
  }
}
