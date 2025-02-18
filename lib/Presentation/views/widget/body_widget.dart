import 'dart:async';

import 'package:app/Presentation/views/widget/app_bar_widget.dart';
import 'package:app/Presentation/views/widget/side_bar_widget.dart';
import 'package:flutter/material.dart';

class BodyWidget extends StatefulWidget {
  final Widget Function() body;

  const BodyWidget ({
    required this.body,
    super.key
  });

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  StreamController<bool>? streamController;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder ( builder : ( context, size ) {
      return Scaffold(
        backgroundColor : Theme.of(context).scaffoldBackgroundColor,
        body : Padding(
          padding : const EdgeInsets.all(20),
          child   : Row(
            children: [
              Padding(
                padding : const EdgeInsets.only(right: 10),
                child   : SideBarWidget(),
              ),
              Expanded(
                child : Column(
                  mainAxisAlignment  : MainAxisAlignment.center,
                  crossAxisAlignment : CrossAxisAlignment.center,
                  children : [
                    Padding(
                      padding : const EdgeInsets.only(bottom: 20),
                      child   : AppBarWidget(),
                    ),
                    Expanded(
                      child : Center(
                        child : StreamBuilder(
                          stream  : streamController?.stream,
                          builder : (context, snapshot) =>
                          snapshot.connectionState == ConnectionState.none
                          ? widget.body.call()
                          : const Center(child: CircularProgressIndicator(strokeWidth: 1)),
                        )
                      )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}