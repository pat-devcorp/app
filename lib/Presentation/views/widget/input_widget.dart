import 'package:app/Presentation/views/widget/texts_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

/// DESCRIPCIÓN DE LOS INPUTS:
///  -> validator          : Función que valida el contenido del input; retorna un mensaje de error si el valor es inválido o null si es válido.
///  -> controller         : Controlador del TextFormField para gestionar el contenido del input.
///  -> keyboardType       : Define el tipo de teclado a mostrar (texto, numérico, etc.).
///  -> maxLength          : Número máximo de caracteres permitidos en el input.
///  -> icon               : Ícono mostrado al inicio del campo de texto.
///  -> suffixIcon         : Ícono mostrado al final del campo de texto, usado para acciones adicionales.
///  -> onTapSuffixIcon    : Callback que se ejecuta al tocar el suffixIcon.
///  -> label              : Etiqueta del campo de texto.
///  -> title              : Título o texto adicional que se muestra por encima del campo.
///  -> obscureText        : Indica si el contenido del campo debe ocultarse ( para contraseñas).
///  -> enabled            : Indica si el campo de texto está habilitado o deshabilitado.
///  -> autocorrect        : Habilita o deshabilita la corrección automática del texto.
///  -> autofocus          : Si es true, el campo obtiene foco automáticamente al cargar la pantalla.
///  -> hintText           : Texto sugerido que se muestra cuando el campo está vacío.
///  -> helperText         : Texto de ayuda que se muestra debajo del campo.
///  -> textCapitalization : Controla la capitalización del texto ingresado.
///  -> textStyle          : Estilo personalizado para el texto ingresado.
///  -> textInputAction    : Acción del teclado que se muestra en la esquina inferior derecha (por ejemplo, "siguiente", "enviar").
///  -> onChanged          : Callback que se ejecuta cuando cambia el contenido del input.
///  -> onFieldSubmitted   : Callback que se ejecuta al enviar el campo (por ejemplo, al presionar "enter").

class InputWidget extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;
  final TextEditingController controller;
  final VoidCallback? onTapSuffixIcon;
  final TextInputType keyboardType;
  final IconData? suffixIcon;
  final int? maxLength;
  final IconData? icon;
  final String label;
  final String? title;
  final bool obscureText;
  final bool enabled;
  final bool autocorrect;
  final bool autofocus;
  final String? hintText;
  final String? helperText;
  final TextStyle? textStyle;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  const InputWidget({
    super.key,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.autocorrect = true,
    this.autofocus = false,
    this.enabled = true,
    required this.controller,
    this.onFieldSubmitted,
    this.textInputAction,
    this.onTapSuffixIcon,
    required this.label,
    this.helperText,
    this.suffixIcon,
    this.validator,
    this.maxLength,
    this.textStyle,
    this.onChanged,
    this.hintText,
    this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: CustomText(
              text: title!,
              type: TextType.normal,
            ),
          ),
        TextFormField(
          controller         : controller,
          keyboardType       : keyboardType,
          maxLength          : maxLength,
          obscureText        : obscureText,
          enabled            : enabled,
          autocorrect        : autocorrect,
          autofocus          : autofocus,
          textCapitalization : textCapitalization,
          textInputAction    : textInputAction,
          style              : textStyle ?? textTheme.bodyMedium?.copyWith(color: Colors.black),
          onChanged          : onChanged,
          onFieldSubmitted   : onFieldSubmitted,
          inputFormatters    : maxLength != null ? [LengthLimitingTextInputFormatter(maxLength)] : null,
          decoration         : _buildInputDecoration(colorScheme),
          validator          : _buildValidator(),
        ),
      ],
    );
  }

  // Decorado del campo de texto con estilos
  // - [colorScheme]: Esquema de colores definido en el `ThemeData` de la aplicación
  InputDecoration _buildInputDecoration(ColorScheme colorScheme) {
    return InputDecoration(
      labelText  : label,
      labelStyle : GoogleFonts.nunito(
        color    : Colors.grey,
        fontSize : 16,
      ),
      hintText: hintText,
      hintStyle: GoogleFonts.nunito(
        color: Colors.grey.withValues(alpha: 0.6),
        fontSize: 14,
      ),
      prefixIcon: icon != null ? Icon(icon, color: Colors.green, size: 18) : null,
      suffixIcon: suffixIcon != null
          ? Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
                icon: Icon(suffixIcon, color: Colors.grey, size: 18),
                onPressed: onTapSuffixIcon,
              ),
          )
          : null,
      floatingLabelBehavior : FloatingLabelBehavior.never,
      contentPadding        : const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      enabledBorder         : _buildBorder(Colors.grey),
      focusedBorder         : _buildBorder(Colors.green, width: 1.4),
      errorBorder           : _buildBorder(Colors.red, width: 1.4),
      focusedErrorBorder    : _buildBorder(Colors.red),
      errorStyle: GoogleFonts.nunito(
        color: Colors.red,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      helperText: helperText,
      helperStyle: helperText != null
          ? GoogleFonts.nunito(
              color: Colors.grey,
              fontSize: 12,
            )
          : null,
      counterText: "",
    );
  }

  // Borde para los estados del campo de texto
  // - [color]: Color del borde
  // - [width]: Grosor del borde
  OutlineInputBorder _buildBorder(Color color, {double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  // Función de validación que evalúa el contenido ingresado en el campo de texto
  // -> Casos:
  // 1. Si se proporciona una función `validator`, la ejecuta y retorna el mensaje de error en caso de ser inválido
  // 2. Valida que el campo no esté vacío
  // 3. Verifica que la cantidad de caracteres no exceda el `maxLength`
  String? Function(String?)? _buildValidator() {
    return (value) {
      if (validator != null) {
        final error = validator!(value);
        if (error != null) return error;
      }
      if (value == null || value.trim().isEmpty) {
        return 'Por favor ingrese $label';
      }
      if (maxLength != null && value.length > maxLength!) {
        return 'Máximo $maxLength caracteres permitidos';
      }
      return null;
    };
  }
}
