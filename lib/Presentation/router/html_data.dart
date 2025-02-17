import 'html_body.dart';
import 'html_header.dart';

class HTMLData {
  final String route;
  final HTMLHeader header;
  final HTMLBody body;

  const HTMLData({
    this.route = "",
    this.header = const HTMLHeader(),
    this.body = const HTMLBody(),
  });
}