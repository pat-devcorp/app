import 'package:app/Presentation/language/ui_labels.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  AppBarWidgetState createState() => AppBarWidgetState();
}

class AppBarWidgetState extends State<AppBarWidget> with SingleTickerProviderStateMixin {
  final UiLabels labels = GetIt.instance<UiLabels>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      height: 50,
      decoration : 
      BoxDecoration(
        color        : colorScheme.surface,
        borderRadius : 
        const BorderRadius.all(Radius.circular(20)),
        boxShadow : [
          BoxShadow(
            color        : colorScheme.shadow,
            blurRadius   : 10,
            spreadRadius : 1,
          ),
        ],
      ),
    );
  }
}