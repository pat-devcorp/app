import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum TextType {
  numeric,   // Texto numérico
  normal,    // Texto normal
  title1,    // Título principal
  title2,    // Subtítulo (mediano)
  small,     // Texto pequeño
  button,    // Texto para botones
  coin,      // Texto usado para representar monedas
}

extension TextTypeExtension on TextType {
  static final _baseFont = GoogleFonts.nunito();

  static final Map<TextType, TextStyle> _styles = {
    TextType.numeric: _baseFont.copyWith(
      fontSize   : 20,
      color      : Colors.black,
      fontWeight : FontWeight.w500,
      overflow   : TextOverflow.ellipsis,
    ),
    TextType.normal: _baseFont.copyWith(
      fontSize   : 15,
      color      : Colors.black87,
      fontWeight : FontWeight.w500,
      overflow   : TextOverflow.ellipsis,
    ),
    TextType.title1: _baseFont.copyWith(
      fontSize   : 30,
      color      : Colors.black87,
      fontWeight : FontWeight.w600,
      overflow   : TextOverflow.ellipsis,
    ),
    TextType.title2: _baseFont.copyWith(
      fontSize   : 20,
      color      : Colors.black87,
      fontWeight : FontWeight.w600,
      overflow   : TextOverflow.ellipsis,
    ),
    TextType.small: _baseFont.copyWith(
      fontSize   : 15,
      color      : Colors.black87,
      fontWeight : FontWeight.w500,
      overflow   : TextOverflow.ellipsis,
    ),
    TextType.button: _baseFont.copyWith(
      fontSize   : 15,
      color      : Colors.black87,
      fontWeight : FontWeight.w500,
      overflow   : TextOverflow.ellipsis,
    ),
    TextType.coin: _baseFont.copyWith(
      fontSize   : 22,
      color      : Colors.black87,
      fontWeight : FontWeight.w600,
      overflow   : TextOverflow.ellipsis,
    ),
  };
  TextStyle get style => _styles[this]!;
}

class CustomText extends StatelessWidget {
  final TextAlign? align;
  final TextType type;
  final Color? color;
  final String text;

  const CustomText({
    super.key,
    required this.text,
    required this.type,
    this.color,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align ?? TextAlign.left,
      style: type.style.copyWith(
        color: color ?? type.style.color,
      ),
    );
  }
}
