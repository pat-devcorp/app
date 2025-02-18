import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'theme_riverpod.g.dart';

@riverpod
class ThemeRiverpod extends _$ThemeRiverpod {
  @override
  ThemeMode build() => ThemeMode.light;
  
  void changeTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}