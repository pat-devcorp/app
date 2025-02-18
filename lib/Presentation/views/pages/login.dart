import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../Application/State/authentication_state.dart';
import '../../language/ui_labels.dart';
import '../../provider/authentication_provider.dart';
import '../../router/pages.dart';
import '../../router/router.dart';
import '../style/dimension.dart';
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

    final radiusLayout = context.dimensions[Dimension.xlarge] ?? 30;
    final radiusButton = context.dimensions[Dimension.medium] ?? 20;
    final dimensionLarge = context.dimensions[Dimension.large] ?? 16;
    final spaceLarge = context.dimensions[Dimension.xlarge] ?? 25;

    ref.listen(authenticationProvider, (previous, next) {
      if (next == AuthenticationState.authenticated) {
        NotificationSnackBar.show(
            context, labels.operationSuccess, SnackBarType.success);
        PageRouter.goToPage(context, ref, page: Pages.home);
      } else if (next == AuthenticationState.error) {
        NotificationSnackBar.show(
            context, labels.operationError, SnackBarType.error);
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
                  ),
                ),
              ),

              SingleChildScrollView(
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
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                            ),
                            Text(
                              labels.tittleLoginForm,
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

                    Flexible(
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight:
                          MediaQuery.of(context).size.height * 0.4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusLayout),
                            topRight: Radius.circular(radiusLayout),
                          ),
                          color: Colors.white,
                        ),

                        padding: EdgeInsets.all(24.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: spaceLarge,
                              ),
                              TextField(
                                controller: _usernameController,
                                decoration: InputDecoration(border: OutlineInputBorder(), labelText: labels.inputUserLabel),
                              ),

                              SizedBox(
                                height: spaceLarge,
                              ),
                              TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(border: OutlineInputBorder(), labelText: labels.inputPasswordLabel),
                              ),

                              SizedBox(
                                height: spaceLarge,
                              ),
                              FilledButton(
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
                                        horizontal: dimensionLarge
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(radiusButton)
                                    ),
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
                            ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
    );
  }
}
