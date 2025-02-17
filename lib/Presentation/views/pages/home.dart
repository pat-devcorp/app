import 'package:app/Presentation/language/ui_labels.dart';
import 'package:app/Presentation/views/widget/body_widget.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UiLabels labels = GetIt.instance<UiLabels>();

  @override
  Widget build(BuildContext context) {
    return BodyWidget(
      body: () => Text(labels.welcomeTo9780Bitcoin)
    );
  }
}
