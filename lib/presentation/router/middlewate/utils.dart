import 'dart:developer';

import 'package:flutter/material.dart';

import '../pages.dart';

Future<bool> checkLoginPreCondition(BuildContext context, Pages page) async {
  log("Checking Login Precondition");
  return true;
}

Future<bool> checkSomeOtherCondition(BuildContext context, Pages page) async {
  log("Checking Some Other Condition");
  return true;
}

Future<bool> logPageTransitionPostCondition(BuildContext context, Pages page) async {
  log('➡️ Navigated to $page');
  return true;
}