import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../Domain/Model/base_service_status.dart';
import '../../language/ui_labels.dart';
import '../../provider/authentication_provider.dart';
import '../../router/pages.dart';
import '../../router/router.dart';
import '../style/dimension.dart';
import '../widget/notification_snack_bar.dart';
import '../widget/custom_drop_down.dart';

enum RegisterUser {
  user1("test@example.com"),
  user2("user2@example.com"),
  user3("user3@example.com");

  final String value;

  const RegisterUser(this.value);

  static Map<RegisterUser, Map<String, dynamic>> toDict() {
    return {
      for (var user in RegisterUser.values)
        user: {"label": user.name, "value": user.value}
    };
  }
}

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final UiLabels labels = GetIt.instance<UiLabels>();

    final authState = ref.watch(authenticationProvider);
    final authNotifier = ref.read(authenticationProvider.notifier);

    final radiusLayout = context.dimensions[Dimension.xlarge] ?? 30;
    final radiusButton = context.dimensions[Dimension.medium] ?? 20;
    final dimensionLarge = context.dimensions[Dimension.large] ?? 16;
    final spaceLarge = context.dimensions[Dimension.xlarge] ?? 25;

    ref.listen(authenticationProvider, (previous, next) {
      if (next == BaseServiceStatus.success) {
        NotificationSnackBar.show(
            context, labels.operationSuccess, NotificationSnackBarType.success);
        PageRouter.goToPage(context, page: Pages.home);
      } else if (next == BaseServiceStatus.error) {
        NotificationSnackBar.show(
            context, labels.operationError, NotificationSnackBarType.error);
      }
    });

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: 0.0,
              top: -20.0,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  "assets/image/vector-1.png",
                  color: colorScheme.primary.withValues(alpha: 0.5),
                  colorBlendMode: BlendMode.srcATop,
                ),
              ),
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: constraints.maxHeight * 0.6,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    labels.tittleLoginForm,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: colorScheme.onPrimary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(radiusLayout),
                                  topRight: Radius.circular(radiusLayout),
                                ),
                                color: colorScheme.surface,
                              ),
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(height: spaceLarge),
                                  CustomDropdown<RegisterUser>(
                                    values: RegisterUser.toDict(),
                                    initialValue: RegisterUser.user1,
                                    controller: _usernameController,
                                    onChanged: (RegisterUser value) {
                                      log("Seleccionado: ${_usernameController.text}");
                                    },
                                  ),
                                  SizedBox(height: spaceLarge),
                                  TextField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: colorScheme.outline),
                                      ),
                                      labelText: labels.inputPasswordLabel,
                                      labelStyle: TextStyle(
                                          color: colorScheme.onSurfaceVariant),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: colorScheme.primary),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spaceLarge),
                                  FilledButton(
                                    onPressed:
                                        authState == BaseServiceStatus.loading
                                            ? null
                                            : () => authNotifier.login(
                                                  context,
                                                  _usernameController.text,
                                                  _passwordController.text,
                                                ),
                                    style: FilledButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          vertical: dimensionLarge,
                                          horizontal: dimensionLarge),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              radiusButton)),
                                      backgroundColor: colorScheme.primary,
                                      foregroundColor: colorScheme.onPrimary,
                                    ),
                                    child: authState ==
                                        BaseServiceStatus.loading
                                        ? SizedBox(
                                            height: dimensionLarge,
                                            width: dimensionLarge,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: colorScheme.onPrimary,
                                            ),
                                          )
                                        : Text(
                                            labels.loginButtonLabel,
                                            style: TextStyle(
                                              fontSize: dimensionLarge,
                                              color: colorScheme
                                                  .onPrimary, // ✅ No `const` needed
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
