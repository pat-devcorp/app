import 'package:flutter/material.dart';

import '../pages.dart';

typedef Middleware = Future<bool> Function(BuildContext context, Pages page);