import 'package:flutter/material.dart';

class SwitchWidget extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final IconData icon;
  final bool isExpanded;

  const SwitchWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.icon,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment : MainAxisAlignment.center,
      children : [
        Icon(icon, size: 15),
        if (isExpanded)
        Flexible(
          child : 
          Padding(
            padding : const EdgeInsets.only(left: 10),
            child   : 
            Text(
              label, 
              overflow: TextOverflow.ellipsis,
              style : 
              TextStyle(
                fontSize : 13
              )
            ),
          ),
        ),
        Container(
          width   : 40,
          margin : EdgeInsets.only(left: 5),
          child   : 
          FittedBox(
            fit   : BoxFit.fill,
            child : 
            Switch(
              value     : value,
              onChanged : onChanged,
            ),
          ),
        )
      ],
    );
  }
}