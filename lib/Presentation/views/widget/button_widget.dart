import 'package:app/Presentation/views/widget/texts_widget.dart';
import 'package:flutter/material.dart';

// ESTADOS:
// -> normal  : estado por defecto
// -> loading : muestra un indicador de carga
// -> success : muestra un ícono de éxito
// -> error   : muestra un ícono de error
// PROPIEDADES:
// -> onPressed    :  Callback que se ejecuta al presionar el botón.
// -> buttonState  : Estado actual del botón.
// -> successIcon  : Ícono que se mostrará cuando el estado sea "success".
// -> errorIcon    : Ícono que se mostrará cuando el estado sea "error".
// -> textColor    : Color del texto mostrado en el botón.
// -> width        : Ancho del botón en su estado normal.
// -> text         : Texto que se muestra en el botón.
// -> color        : Color de fondo del botón.


class CustomButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final ButtonState buttonState;
  final IconData? successIcon;
  final IconData? errorIcon;
  final Color textColor;
  final bool isDisabled;
  final IconData? icon;
  final double width;
  final String text;
  final Color color;

  const CustomButton({
    super.key,
    this.buttonState = ButtonState.normal,
    this.textColor = Colors.white,
    this.successIcon = Icons.check,
    this.errorIcon = Icons.close,
    this.isDisabled = false,
    this.width = 160,
    required this.color,
    required this.text,
    this.onPressed,
    this.icon,
  });

  //para trasacciones
   CustomButton.function({
    super.key,
    this.icon,
    required this.text,
    required Null Function() onPressed,
  })  : color       = Color(0xFF00AB00),
        buttonState = ButtonState.normal,
        textColor   = Colors.white,
        successIcon = Icons.check,
        errorIcon   = Icons.close,
        isDisabled  = false,
        onPressed   = null,
        width       = 150;

  // para botones deshabilitados
  const CustomButton.disabled({
    super.key,
    this.icon,
    required this.text,
  })  : color       = Colors.grey,
        textColor   = Colors.grey,
        width       = 150,
        isDisabled  = true,
        successIcon = null,
        errorIcon   = null,
        buttonState = ButtonState.normal,
        onPressed   = null;

  // Botones solo con texto
  const CustomButton.onlyText({
    super.key,
    this.icon,
    required this.text,
    this.onPressed,
    this.textColor  = Colors.green
  })  : color       = Colors.transparent,
        width       = 150,
        isDisabled  = false,
        successIcon = null,
        errorIcon   = null,
        buttonState = ButtonState.normal;

  // Boton predeterminado
  const CustomButton.green({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  })  : color       = Colors.green,
        textColor   = Colors.white,
        width       = 150,
        isDisabled  = false,
        successIcon = null,
        errorIcon   = null,
        buttonState = ButtonState.normal;

  // Boton secundario
  const CustomButton.gris({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  })  : color       = Colors.grey,
        textColor   = Colors.white,
        width       = 150,
        isDisabled  = false,
        successIcon = null,
        errorIcon   = null,
        buttonState = ButtonState.normal;

  //  Boton oscuro
  const CustomButton.black({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  })  : color       = Colors.black,
        textColor   = Colors.green,
        width       = 150,
        isDisabled  = false,
        successIcon = null,
        errorIcon   = null,
        buttonState = ButtonState.normal;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

enum ButtonState { normal, loading, success, error }

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ValueNotifier<ButtonState> _buttonState =
      ValueNotifier(ButtonState.normal);
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration   : const Duration(milliseconds: 100),
      lowerBound : 0.9,
      upperBound : 1.0,
      vsync      : this,
    );
    _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    _buttonState.dispose();
    super.dispose();
  }

  /// Simulacion del boton function
  ///
  /// Durante este proceso:
  ///  - Se muestra un indicador de carga (loading).
  ///  - Se determina aleatoriamente si el resultado es éxito o error.
  ///  - Finalmente, el botón vuelve a su estado normal.
  Future<void> _startProcess() async {
    _buttonState.value = ButtonState.loading;
    try {
      await Future.delayed(const Duration(seconds: 3));
      _buttonState.value = DateTime.now().second % 2 == 0
          ? ButtonState.success
          : ButtonState.error;
    } catch (e) {
      _buttonState.value = ButtonState.error;
    }
    await Future.delayed(const Duration(seconds: 2));
    _buttonState.value = ButtonState.normal;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ButtonState>(
      valueListenable: _buttonState,
      builder: (context, state, child) {
        return MouseRegion(
          cursor: widget.isDisabled
              ? SystemMouseCursors.basic
              : SystemMouseCursors.click,
          onEnter: (_) {
            if (!widget.isDisabled) {
              setState(() => _isHovered = true);
            }
          },
          onExit: (_) {
            if (!widget.isDisabled) {
              setState(() => _isHovered = false);
            }
          },
          child: AnimatedScale(
            scale: _isHovered ? 1.05 : 1.0,
            duration: const Duration(milliseconds: 300),
            child: GestureDetector(
              onTapDown: (_) => _controller.reverse(),
              onTapUp: (_) async {
                await _controller.forward();
                if (!widget.isDisabled) {
                  if (widget.onPressed != null) {
                    widget.onPressed?.call();
                  } else if (widget.buttonState == ButtonState.normal) {
                    _startProcess();
                  }
                }
              },
              child: ScaleTransition(
                scale: _controller,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: (state == ButtonState.loading ||
                          state == ButtonState.success ||
                          state == ButtonState.error)
                      ? 45
                      : widget.width,
                  height: 45,
                  decoration: widget.color == Colors.transparent
                      ? null
                      : BoxDecoration(
                          color: widget.isDisabled
                              ? Colors.transparent
                              : (_isHovered
                                  ? widget.color.withValues(alpha: 0.90)
                                  : widget.color),
                          borderRadius: BorderRadius.circular(
                            (state == ButtonState.loading ||
                                    state == ButtonState.success ||
                                    state == ButtonState.error)
                                ? 30
                                : 20,
                          ),
                          border: widget.isDisabled
                              ? Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                )
                              : null,
                          boxShadow: widget.isDisabled
                              ? []
                              : [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(_isHovered ? 0.25 : 0.15),
                                    spreadRadius: _isHovered ? 4 : 2,
                                    blurRadius: _isHovered ? 10 : 6,
                                    offset: const Offset(2, 4),
                                  ),
                                ],
                        ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                      child: state == ButtonState.loading
                          ? const Center(
                              child: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          : state == ButtonState.success
                              ? Icon(
                                  widget.successIcon,
                                  color: Colors.white,
                                  size: 20,
                                )
                              : state == ButtonState.error
                                  ? Icon(
                                      widget.errorIcon,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  : FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          if (widget.icon != null)
                                            Icon(
                                              widget.icon,
                                              color: widget.textColor,
                                              size: 20,
                                            ),
                                          if (widget.icon != null)
                                            const SizedBox(width: 8),
                                          // Texto del botón.
                                          CustomText(
                                            text: widget.text,
                                            type: TextType.button,
                                            color: widget.textColor,
                                          ),
                                        ],
                                      ),
                                    ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
