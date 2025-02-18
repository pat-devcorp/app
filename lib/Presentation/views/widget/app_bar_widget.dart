import 'package:app/Presentation/language/ui_labels.dart';
import 'package:app/Presentation/views/widget/body_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppBarWidget extends StatefulWidget {
  final List<Tabs> tabs; 

  const AppBarWidget({
    this.tabs = const [],
    super.key
  });

  @override
  AppBarWidgetState createState() => AppBarWidgetState();
}

class AppBarWidgetState extends State<AppBarWidget> with SingleTickerProviderStateMixin {
  final UiLabels labels = GetIt.instance<UiLabels>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      padding    : EdgeInsets.symmetric(horizontal: 20),
      height     : 50,
      decoration : 
      BoxDecoration(
        color        : colorScheme.surface,
        borderRadius : const BorderRadius.all(Radius.circular(20)),
        boxShadow    : [
          BoxShadow(
            color        : colorScheme.shadow,
            blurRadius   : 10,
            spreadRadius : 1,
          ),
        ],
      ),
      child: Row(
        children: [
          widget.tabs.isNotEmpty
          ? Row(
            children: widget.tabs.map((tab) =>
              Text(tab.name)
            ).toList(),
          )
          : Text("name de page")
        ],
      ),
    );
  }
}