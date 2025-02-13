import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';

import 'web/html_data.dart';
import 'pages.dart';

class PageData {
  final bool unbound;
  final Pages key;
  final Widget page;
  final HTMLData html;

  const PageData({
    this.unbound = false,
    required this.key,
    required this.page,
    this.html = const HTMLData(),
  });

  void push(BuildContext context, PageTransitionType transition) =>
      Navigator.of(context).push(
        PageTransition(type: transition, child: page),
      );

  void pushOver(BuildContext context, PageTransitionType transition) =>
      Navigator.of(context).pushAndRemoveUntil(
        PageTransition(
          type: transition,
          child: page,
        ),
            (route) => false,
      );
}