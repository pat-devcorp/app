import 'package:app/Presentation/views/pages/home.dart';
import 'package:app/Presentation/views/pages/login.dart';
import 'package:app/Presentation/views/pages/client_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

enum Pages {
  home,
  welcome,
  client
}

class PageRouter {
  static List<PageData> get _pageList => [

    const PageData(
      key     : Pages.home,
      unbound : true,
      page    : LoginPage(),
      html    : HTMLData( route: '/home/' ),
    ),

    const PageData(
      key     : Pages.welcome,
      unbound : true,
      page    : Home(),
      html    : HTMLData( route: '/welcome/' ),
    ),

    const PageData(
      key     : Pages.client,
      unbound : false,
      page    : ClientPage(),
      html    : HTMLData( route: '/client/' ),
    ),
  ];

  static PageTransitionType transition = PageTransitionType.fade;
  static const Duration duration = Duration(milliseconds: 300);

  static void goToPage(BuildContext context, {required Pages page}) {
    PageData p = _pageList.singleWhere((e) => e.key == page, orElse: ()=> _pageList[0]);
    p.unbound ? p.pushOver(context) : p.push(context);
  }
}

class PageData {
  final bool     unbound;
  final Pages    key;
  final Widget   page;
  final HTMLData html;

  const PageData({
    this.unbound = false,
    this.key     = Pages.home,
    this.page    = const SizedBox.shrink(),
    this.html    = const HTMLData(),
  });

  push(BuildContext context) => Navigator.of(context).push(
    PageTransition(
      type  : PageTransitionType.fade,
      child : page
    )
  );

  pushOver(BuildContext context) => Navigator.of(context).pushAndRemoveUntil(
    PageTransition(
      type  : PageTransitionType.fade,
      child : page,
      isIos : Theme.of(context).platform == TargetPlatform.iOS
    ),
    (route) => false
  );
}


class HTMLData{
  final String     route;
  final HTMLBody   body;
  final HTMLHeader header;
  const HTMLData({
    this.route  = "",
    this.body   = const HTMLBody(),
    this.header = const HTMLHeader(),
  });
}

class HTMLHeader{
  final bool indexed;
  final int  title;
  final int  description;
  final int  keywords;

  const HTMLHeader({
    this.indexed     = false,
    this.title       = -1,
    this.description = -1,
    this.keywords    = -1,
  });
}

class HTMLBody{
  final int  h1;
  final int  h2;
  final int  p;

  const HTMLBody({
    this.h1 = -1,
    this.h2 = -1,
    this.p  = -1,
  });
}