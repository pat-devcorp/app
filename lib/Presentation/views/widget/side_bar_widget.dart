import 'package:app/Presentation/language/ui_labels.dart';
import 'package:app/Presentation/riverpods/theme_riverpod.dart'; 
import 'package:app/Presentation/router/pages.dart';
import 'package:app/Presentation/router/router.dart';
import 'package:app/Presentation/views/widget/switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class SideBarWidget extends StatefulWidget {
  const SideBarWidget({super.key});

  @override
  SideBarWidgetState createState() => SideBarWidgetState();
}

class SideBarWidgetState extends State<SideBarWidget> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool isExpanded = true;
  bool expanding = false;
  final UiLabels labels = GetIt.instance<UiLabels>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer(builder: (context, ref, child) { 
      return AnimatedContainer(
      width    : isExpanded ? 265 : 95,
      curve    : Curves.easeInOut,
      duration : Duration(milliseconds: 300),
      child    : Stack(
        children: [
          AnimatedContainer(
            curve      : Curves.easeInOut,
            width      : isExpanded ? 250 : 80,
            duration   : Duration(milliseconds: 300),
            padding    : EdgeInsets.symmetric(vertical: 40),
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
            child : Column(
              children : [
                Expanded(
                  child : Padding(
                    padding : const EdgeInsets.symmetric(horizontal: 20),
                    child   : Column(
                      children : [
                        Padding(
                          padding : const EdgeInsets.only(bottom: 40),
                          child   : Row(
                            mainAxisAlignment : MainAxisAlignment.center,
                            children : [
                              Icon(
                                Icons.circle_outlined,
                                color : colorScheme.primary,
                                size  : 35
                              ),
                              if (isExpanded)
                              Flexible(
                                child : 
                                const Text(
                                  " 9780Bitcoin", 
                                  overflow : TextOverflow.ellipsis,
                                  style    :
                                  TextStyle(
                                    fontSize   : 17,
                                    fontWeight : FontWeight.w500
                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
                        MenuItem(
                          isSelected : _selectedIndex == 1,
                          isExpanded : isExpanded,
                          expanding  : expanding,
                          title      : labels.home,
                          icon       : Icons.dashboard, 
                          onTap      : () {
                            PageRouter.goToPage(context, page: Pages.home);
                            setState(() => _selectedIndex = 1);
                          },
                        ),
                        MenuItem(
                          isSelected : _selectedIndex == 2,
                          isExpanded : isExpanded,
                          expanding  : expanding,
                          title      : labels.clientList,
                          icon       : Icons.person, 
                          onTap      : () {
                            PageRouter.goToPage(context, page: Pages.clientsList);
                            setState(() => _selectedIndex = 2);
                          }
                        ),
                        MenuItem(
                          isSelected : _selectedIndex == 3,
                          isExpanded : isExpanded,
                          expanding  : expanding,
                          title      : labels.registerClient,
                          icon       : Icons.person_add_sharp, 
                          onTap      : () {
                            PageRouter.goToPage(context, page: Pages.registerClient);
                            setState(() => _selectedIndex = 3);
                          }
                        ),
                        MenuItem(
                          isSelected : _selectedIndex == 4,
                          isExpanded : isExpanded,
                          expanding  : expanding,
                          title      : labels.logout,
                          icon       : Icons.logout_outlined, 
                          onTap      : () {
                            PageRouter.goToPage(context, page: Pages.login);
                            setState(() => _selectedIndex = 4);
                          }
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding : const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                  child   : 
                  SwitchWidget(
                    icon       : ref.watch(themeRiverpodProvider) == ThemeMode.dark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                    label      : ref.watch(themeRiverpodProvider) == ThemeMode.dark ? "Modo oscuro" : "Modo claro",
                    value      : ref.watch(themeRiverpodProvider) == ThemeMode.dark,
                    onChanged  : (bool value) => ref.read(themeRiverpodProvider.notifier).toggleTheme(),
                    isExpanded : isExpanded,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width  : 40,
                        height : 40,
                        decoration : 
                        BoxDecoration(
                          color        : colorScheme.onSurface,
                          borderRadius : BorderRadius.all(Radius.circular(20))
                        ),
                        child : 
                        Icon(
                          Icons.person, 
                          size  : 20,
                          color : colorScheme.surface
                        ),
                      ),
                      if (isExpanded)
                      Flexible(
                        child: Padding(
                          padding : const EdgeInsets.only(left: 10),
                          child   : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ernesto Cuadros",
                                overflow : TextOverflow.ellipsis,
                                style    : 
                                TextStyle(
                                  fontSize : 13
                                ),
                              ),
                              Padding(
                                padding : const EdgeInsets.only(top: 2),
                                child   : Text(
                                  "Asistente de gerencia",
                                  overflow : TextOverflow.ellipsis,
                                  style    : 
                                  TextStyle(
                                    fontSize : 11,
                                    color    : Colors.grey
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          AnimatedPositioned(
            duration : Duration(milliseconds: 300),
            curve    : Curves.easeInOut,
            left     : isExpanded ? 235 : 65,
            top      : 88,
            child    : 
            Center(
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color        : colorScheme.shadow,
                      offset: Offset(5, 0),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child :
                IconButton(
                  icon : Icon(isExpanded ? Icons.arrow_back_ios_rounded : Icons.arrow_forward_ios_rounded, size: 10),
                  onPressed : () {
                    setState(() {
                      expanding = true;
                      isExpanded = !isExpanded;
                    });

                    Future.delayed(Duration(milliseconds: 300), () {
                      setState(() => expanding = false);
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ); },);
  }
}

class MenuItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isExpanded;
  final bool expanding;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.isExpanded,
    required this.expanding,
    this.isSelected = false,
  });

  @override
  MenuItemState createState() => MenuItemState();
}

class MenuItemState extends State<MenuItem> {
  Color? _containerColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return MouseRegion(
      onEnter : (_) => setState(() => _containerColor = Color(0xFF212121)),
      onExit  : (_) => setState(() => _containerColor = Colors.transparent),
      child   : 
      GestureDetector(
        onTap : widget.onTap,
        child : 
        Container(
          margin     : const EdgeInsets.symmetric(vertical: 4),
          padding    : EdgeInsets.symmetric(horizontal: widget.isExpanded && !widget.expanding ? 20 : 10, vertical: 10),
          decoration : 
          BoxDecoration(
            color        : _containerColor,
            borderRadius : BorderRadius.circular(20),
          ),
          child : Row(
            crossAxisAlignment : CrossAxisAlignment.center,
            children : [
              Expanded(
                child : Row(
                  children : [
                    Icon(
                      widget.icon,
                      color : widget.isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                      size  : 20,
                    ),
                    if (widget.isExpanded)
                    Flexible(
                      child : 
                      Padding(
                        padding : const EdgeInsets.only(left: 10),
                        child   : 
                        Text(
                          widget.title,
                          overflow : widget.expanding ? TextOverflow.ellipsis : TextOverflow.clip,
                          style    : 
                          TextStyle(
                            fontSize : 13,
                            color    : colorScheme.onSurface
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.isSelected)
              Icon(
                Icons.arrow_forward,
                size  : 15,
                color : colorScheme.primary,
              )
            ],
          ) 
        ),
      ),
    );
  }
}