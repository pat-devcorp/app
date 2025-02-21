import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';

import 'web/html_data.dart';
import 'middlewate/middleware.dart';
import 'pages.dart';

class PageData {
  final Pages key;
  final bool unbound;
  final Widget page;
  final HTMLData html;
  final List<Middleware> preConditions;
  final List<Middleware> postConditions;

  PageData({
    required this.key,
    required this.unbound,
    required this.page,
    required this.html,
    this.preConditions = const [],
    this.postConditions = const [],
  });

  static const Duration duration = Duration(milliseconds: 300);

  Future<void> push(BuildContext context, PageTransitionType transitionType) async {
    await Navigator.push(
      context,
      PageTransition(
        type: transitionType,
        duration: duration,
        child: page,
      ),
    );
  }

  Future<void> pushOver(BuildContext context, PageTransitionType transitionType) async {
    await Navigator.pushReplacement(
      context,
      PageTransition(
        type: transitionType,
        duration: duration,
        child: page,
      ),
    );
  }
}
