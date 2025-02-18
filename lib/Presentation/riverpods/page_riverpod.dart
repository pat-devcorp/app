import 'package:app/Presentation/router/pages.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'page_riverpod.g.dart';

@riverpod
class PageRiverpod extends _$PageRiverpod {
  @override
  Pages build() => Pages.login;

  void changePage({required Pages page}) {
    state = page;
  }
}