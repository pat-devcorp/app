import 'package:app/Application/State/authentication_state.dart';
import 'package:app/Application/UseCase/authentication_use_case.dart';
import 'package:app/Presentation/router/router.dart';
import 'package:app/Presentation/views/widget/button_widgets.dart';
import 'package:app/Presentation/views/widget/colors_widgets.dart';
import 'package:app/Presentation/views/widget/input_widgets.dart';
import 'package:app/Presentation/views/widget/texts_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authenticationProvider);
    final authNotifier = ref.read(authenticationProvider.notifier);

    ref.listen(authenticationProvider, (previous, next) {
      if (next == AuthenticationState.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomText(
              text: 'Login exitoso!',
              type: TextType.normal,
              color: AppColors.whiteBackground,
            ),
            backgroundColor: AppColors.mainGreen,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
        PageRouter.goToPage(context, page: Pages.welcome);
      } else if (next == AuthenticationState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomText(
              text: 'Credenciales inválidas',
              type: TextType.normal,
              color: AppColors.whiteBackground,
            ),
            backgroundColor: AppColors.textRed,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Center(
                child: CustomText(
                  text: 'Iniciar Sesión',
                  type: TextType.title2,
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputWidgets(
                          controller: _usernameController,
                          label: 'Usuario',
                          icon: Icons.person,
                        ),
                        SizedBox(height: 10),
                        InputWidgets(
                          controller: _passwordController,
                          label: 'Contraseña',
                          icon: Icons.lock,
                          //obscureText: true,
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: authState == AuthenticationState.loading
                                ? null
                                : () => authNotifier.login(context, _usernameController.text, _passwordController.text),
                            child: authState == AuthenticationState.loading
                                ? const CircularProgressIndicator()
                                : const Text("Login"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
