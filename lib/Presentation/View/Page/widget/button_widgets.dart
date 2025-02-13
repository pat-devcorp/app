import 'package:app/Presentation/View/Page/widget/colors_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ButtonFunction extends StatefulWidget {
  final IconData? icon;
  final String text;

  const ButtonFunction({
    super.key,
    this.icon,
    required this.text,
  });

  @override
  State<ButtonFunction> createState() => _ButtonFunctionState();
}

enum ButtonState { normal, loading, success, error }

class _ButtonFunctionState extends State<ButtonFunction> {
  ButtonState buttonState = ButtonState.normal;

  Future<void> startProcess() async {
    setState(() => buttonState = ButtonState.loading);

    try {
      await Future.delayed(const Duration(seconds: 3));

      bool isSuccess = DateTime.now().second % 2 == 0;

      if (!isSuccess) {
        throw Exception("Error simulado");
      }

      setState(() => buttonState = ButtonState.success);
    } catch (e) {
      setState(() => buttonState = ButtonState.error);
    }

    await Future.delayed(const Duration(seconds: 2));

    setState(() => buttonState = ButtonState.normal);
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = buttonState == ButtonState.loading;
    final bool isSuccess = buttonState == ButtonState.success;
    final bool isError = buttonState == ButtonState.error;

    final Color buttonColor = isSuccess
        ? AppColors.mainGreen
        : isError
            ? AppColors.textRed
            : AppColors.mainGreen;

    return GestureDetector(
      onTap: buttonState == ButtonState.normal ? startProcess : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: isLoading || isSuccess || isError ? 45 : 160,
        height: isLoading || isSuccess || isError ? 45 : 45,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(isLoading || isSuccess || isError ? 30 : 10),
          boxShadow: [
            BoxShadow(
              color: buttonColor.withValues(alpha: 0.25),
              offset: const Offset(0, 5),
              blurRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: isLoading
                ? const Center(
                    child: SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : isSuccess
                    ? const Icon(Icons.check, color: Colors.white, size: 20)
                    : isError
                        ? const Icon(Icons.close, color: Colors.white, size: 20)
                        : FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (widget.icon != null) Icon(widget.icon, color: Colors.white, size: 20),
                                if (widget.icon != null) const SizedBox(width: 8),
                                Text(
                                  widget.text,
                                  style: TextStyle(
                                    color      : AppColors.whiteBackground,
                                    fontWeight : FontWeight.w500,
                                    fontFamily : GoogleFonts.nunito().fontFamily,
                                    fontSize   : 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
          ),
        ),
      ),
    );
  }
}

class DisabledButton extends StatelessWidget {
  final IconData? icon;
  final String text;

  const DisabledButton({
    super.key,
    this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.whiteBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.grayBackground, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) Icon(icon, color: AppColors.grayBackground, size: 20),
                if (icon != null) const SizedBox(width: 8),
                Text(
                  text,
                  style: GoogleFonts.nunito(
                    color: AppColors.grayBackground,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnlyText extends StatefulWidget {
  final IconData? icon;
  final String text;
  final VoidCallback? onPressed;
  final Color textColor;

  const OnlyText({
    super.key,
    this.icon,
    required this.text,
    this.onPressed,
    this.textColor = AppColors.mainGreen,
  });

  @override
  State<OnlyText> createState() => _OnlyTextState();
}

class _OnlyTextState extends State<OnlyText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration   : const Duration(milliseconds: 100),
      lowerBound : 0.9,
      upperBound : 1.0,
      vsync      : this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.reverse(),
      onTapUp: (_) async {
        await _controller.forward();
        widget.onPressed?.call();
      },
      child: ScaleTransition(
        scale: _controller,
        child: Container(
          width: 160,
          height: 45,
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null) Icon(widget.icon, color: widget.textColor, size: 20),
                if (widget.icon != null) const SizedBox(width: 8),
                Text(
                  widget.text,
                  style: GoogleFonts.nunito(
                   color      : widget.textColor,
                   fontWeight : FontWeight.w500,
                   fontSize   : 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class GreenButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final String text;

  const GreenButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.mainGreen,
    this.textColor = AppColors.whiteBackground,
  });

  @override
  State<GreenButton> createState() => _GreenButtonState();
}

class _GreenButtonState extends State<GreenButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.90,
      upperBound: 1.0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.reverse(),
      onTapUp: (_) async {
        await _controller.forward();
        widget.onPressed();
      },
      child: ScaleTransition(
        scale: _controller,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 160,
          height: 45,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: widget.backgroundColor.withValues(alpha: 0.3),
                offset: Offset(0, _controller.value == 0.95 ? 3 : 5),
                blurRadius: _controller.value == 0.95 ? 3 : 5,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.text,
                  style: GoogleFonts.nunito(
                    color: widget.textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class GrisButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final String text;

  const GrisButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.textGray,
    this.textColor = AppColors.whiteBackground,
  });

  @override
  State<GrisButton> createState() => _GrisButtonState();
}

class _GrisButtonState extends State<GrisButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.90,
      upperBound: 1.0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.reverse(),
      onTapUp: (_) async {
        await _controller.forward();
        widget.onPressed();
      },
      child: ScaleTransition(
        scale: _controller,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 160,
          height: 45,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: widget.backgroundColor.withValues(alpha: 0.3),
                offset: Offset(0, _controller.value == 0.95 ? 3 : 5),
                blurRadius: _controller.value == 0.95 ? 3 : 5,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.text,
                  style: GoogleFonts.nunito(
                    color: widget.textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


