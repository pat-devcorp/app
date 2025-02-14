import 'package:get_it/get_it.dart';

import '../../../Application/State/authentication_state.dart';
import '../../language/localization_service.dart';
import '../../provider/authentication_provider.dart';
import '../../router/router.dart';
import '../../router/model/pages.dart';
import '../widget/notification_snack_bar.dart';
import '../model/dimension.dart';

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
    final LocalizationService _localizationService = GetIt.instance<LocalizationService>();

    final authState = ref.watch(authenticationProvider);
    final authNotifier = ref.read(authenticationProvider.notifier);

    ref.listen(authenticationProvider, (previous, next) {
      if (next == AuthenticationState.authenticated) {
        NotificationSnackBar.show(context, "Operation Successful!", SnackBarType.success);
        PageRouter.goToPage(context, page: Pages.home);
      } else if (next == AuthenticationState.error) {
        NotificationSnackBar.show(context, "Something went wrong!", SnackBarType.error);
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Image.asset(
                "assets/image/vector-1.png",
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'email'),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'password'),
            ),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: FilledButton(
                onPressed: authState == AuthenticationState.loading
                    ? null
                    : () => authNotifier.login(context, _usernameController.text, _passwordController.text),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: authState == AuthenticationState.loading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                    )
                    : Text(
                  _localizationService.loginButtonLabel,
                    style: TextStyle(fontSize: context.dimensions[Dimension.large]),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
