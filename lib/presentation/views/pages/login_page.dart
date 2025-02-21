import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/service/base_service_status.dart';
import '../../language/ui_labels.dart';
import '../../provider/authentication_provider.dart';
import '../../router/pages.dart';
import '../../router/page_router.dart';
import '../molecules/notification_snack_bar.dart';
import '../organisms/custom_drop_down.dart';
import '../style/dimensions.dart';

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
  bool _obscureText = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UiLabels labels = GetIt.instance<UiLabels>();
    final formTittle = labels.loginLabels.tittle;
    final inputPasswordLabel = labels.loginLabels.inputPasswordLabel;
    final loginButtonLabel = labels.loginLabels.loginButtonLabel;

    final colorScheme = Theme.of(context).colorScheme;
    final kOnPrimary = colorScheme.onPrimary;
    final kPrimary = colorScheme.primary;
    final kOnSurfaceVariant = colorScheme.onSurfaceVariant;
    final kOutline = colorScheme.outline;
    final kSurface = colorScheme.surface;

    final kButtonFontSize = Dimensions.fontSizes.button;

    final kFormPadding = Dimensions.paddings.large;

    final kFormSpace = Dimensions.spaces.medium;

    final kLayoutRadius = Dimensions.radius.xlarge;
    final kButtonRadius = Dimensions.radius.medium;

    final authState = ref.watch(authenticationProvider);
    final authNotifier = ref.read(authenticationProvider.notifier);
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
                                    formTittle,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: kOnPrimary,
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
                                  topLeft: Radius.circular(kLayoutRadius),
                                  topRight: Radius.circular(kLayoutRadius),
                                ),
                                color: kSurface,
                              ),
                              padding: EdgeInsets.all(kFormPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(height: kFormSpace),
                                  CustomDropdown<RegisterUser>(
                                    values: RegisterUser.toDict(),
                                    initialValue: RegisterUser.user1,
                                    controller: _usernameController,
                                    onChanged: (RegisterUser value) {
                                      log("Seleccionado: ${_usernameController.text}");
                                    },
                                  ),
                                  SizedBox(height: kFormSpace),
                                  TextField(
                                    controller: _passwordController,
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: kOutline),
                                      ),
                                      labelText: inputPasswordLabel,
                                      labelStyle:
                                          TextStyle(color: kOnSurfaceVariant),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: kPrimary),
                                      ),
                                      suffixIcon: IconButton(
                                        // Add a suffix icon
                                        icon: Icon(_obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            _obscureText =
                                                !_obscureText; // Toggle obscureText
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: kFormSpace),
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
                                          vertical: 16, horizontal: 16),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              kButtonRadius)),
                                      backgroundColor: kPrimary,
                                      foregroundColor: kOnPrimary,
                                    ),
                                    child: authState ==
                                            BaseServiceStatus.loading
                                        ? SizedBox(
                                            height: 14,
                                            width: 14,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: kOnPrimary,
                                            ),
                                          )
                                        : Text(
                                            loginButtonLabel,
                                            style: TextStyle(
                                              fontSize: kButtonFontSize,
                                              color: kOnPrimary,
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
