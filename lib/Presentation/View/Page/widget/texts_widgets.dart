import 'package:app/Presentation/View/Page/widget/colors_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum TextType {
  numeric,
  normal,
  title1,
  title2,
  small,
  coin,
}

extension TextTypeExtension on TextType {
  static final Map<TextType, TextStyle> _styles = {
    TextType.numeric: TextStyle(
      fontSize   : 20,
      color      : Colors.black,
      fontWeight : FontWeight.w500,
      fontFamily : GoogleFonts.nunito().fontFamily,
      overflow   : TextOverflow.ellipsis

    ),
    TextType.normal: TextStyle(
      fontSize   : 18,
      color      : AppColors.textBlack,
      fontWeight : FontWeight.w500,
      fontFamily : GoogleFonts.nunito().fontFamily,
      overflow   : TextOverflow.ellipsis
    ),
    TextType.title1: TextStyle(
      fontSize   : 30,
      color      : AppColors.textBlack,
      fontWeight : FontWeight.w600,
      fontFamily : GoogleFonts.nunito().fontFamily,
      overflow   : TextOverflow.ellipsis
    ),
    TextType.title2: TextStyle(
      fontSize   : 25,
      color      : AppColors.textBlack,
      fontWeight : FontWeight.w600,
      fontFamily : GoogleFonts.nunito().fontFamily,
      overflow   : TextOverflow.ellipsis
    ),
    TextType.small: TextStyle(
      fontSize   : 15,
      color      : AppColors.textBlack,
      fontWeight : FontWeight.w500,
      fontFamily : GoogleFonts.nunito().fontFamily,
      overflow   : TextOverflow.ellipsis
    ),
    TextType.coin: TextStyle(
      fontSize   : 22,
      color      : AppColors.textBlack,
      fontWeight : FontWeight.w600,
      fontFamily : GoogleFonts.nunito().fontFamily,
      overflow   : TextOverflow.ellipsis
    ),
  };

  TextStyle get style => _styles[this]!;
}

class CustomText extends StatelessWidget {
  final AppColorType? appColor;
  final TextAlign? align;
  final TextType type;
  final Color? color;
  final String text;

  const CustomText({
    super.key,
    required this.text,
    required this.type,
    this.appColor,
    this.color,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign : align ?? TextAlign.left,
      style     : type.style.copyWith(
        color: color ?? appColor?.color ?? type.style.color,
      ),
    );
  }
}
