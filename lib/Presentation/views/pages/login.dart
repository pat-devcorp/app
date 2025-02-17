import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../Application/State/authentication_state.dart';
import '../../language/ui_labels.dart';
import '../../provider/authentication_provider.dart';
import '../../router/pages.dart';
import '../../router/router.dart';
import '../style/dimension.dart';
import '../widget/input_widget.dart';
import '../widget/notification_snack_bar.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  //final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UiLabels labels = GetIt.instance<UiLabels>();

    final authState = ref.watch(authenticationProvider);
    final authNotifier = ref.read(authenticationProvider.notifier);

    final dimensionLarge = context.dimensions[Dimension.large] ?? 16;
    //final spaceLarge = context.dimensions[Dimension.large] ?? 16;

    ref.listen(authenticationProvider, (previous, next) {
      if (next == AuthenticationState.authenticated) {
        NotificationSnackBar.show(
            context, labels.operationSuccess, SnackBarType.success);
        PageRouter.goToPage(context, page: Pages.home);
      } else if (next == AuthenticationState.error) {
        NotificationSnackBar.show(
            context, labels.operationError, SnackBarType.error);
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        bottom: false,
        child: Container(
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
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 15.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                FlutterIcons.keyboard_backspace_mdi,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Log in to your account",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height - 180.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              InputWidget(
                                //controller: _usernameController,
                                topLabel: labels.userLabel,
                                hintText: "Enter your email address",
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              InputWidget(
                                //controller: _passwordController,
                                topLabel: labels.passwordLabel,
                                obscureText: true,
                                hintText: "Enter your password",
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Forgot Password?",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Center(
                                child: FilledButton(
                                  onPressed:
                                      authState == AuthenticationState.loading
                                          ? null
                                          : () => authNotifier.login(
                                              context,
                                              _usernameController.text,
                                              _passwordController.text),
                                  style: FilledButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        vertical: dimensionLarge,
                                        horizontal: dimensionLarge),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  child:
                                      authState == AuthenticationState.loading
                                          ? SizedBox(
                                              height: dimensionLarge,
                                              width: dimensionLarge,
                                              child:
                                                  const CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text(
                                              labels.loginButtonLabel,
                                              style: TextStyle(
                                                  fontSize: dimensionLarge),
                                            ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
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
