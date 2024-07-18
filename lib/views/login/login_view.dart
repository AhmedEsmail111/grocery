import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grocery/core/utils/contants.dart';
import 'package:grocery/core/widgets/authentication_welcome.dart';
import 'package:grocery/core/widgets/custom_button.dart';
import 'package:grocery/core/widgets/custom_text_field.dart';
import 'package:grocery/core/widgets/forgot_password.dart';
import 'package:grocery/core/widgets/google_authentication_button.dart';
import 'package:grocery/core/widgets/loading_manager.dart';
import 'package:grocery/core/widgets/redirect_authentication_row.dart';
import 'package:grocery/core/widgets/swiper.dart';
import 'package:grocery/providers/authentication/password_visibility_provider.dart';
import 'package:grocery/views/login/widgets/or_divider.dart';
import 'package:grocery/views/register/sign_up_view.dart';
import 'package:grocery/views/splash/splash_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/authentication/authenticaion_provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String _enteredEmail = '';
  String _enteredPassword = '';
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context);
    final height = MediaQuery.sizeOf(context).height;
    final passwordProvider = Provider.of<PasswordVisibilityProvider>(context);
    return Scaffold(
      body: CustomLoadingManager(
        isLoading: authenticationProvider.isLoading,
        child: Stack(
          children: [
            CustomSwiper(
              images: authSwiperImages,
              height: height * 0.94,
              isWholePage: true,
              autoDelayDuration: 8000,
              duration: 1500,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: Container(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: height * 0.17,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AuthenticationWelcome(
                      title: 'Welcome Back',
                      subTitle: 'Sign in to continue',
                    ),
                    SizedBox(
                      height: height * 0.035,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            autovalidateMode: _autoValidateMode,
                            textInputType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            hintText: 'Email',
                            isObscured: false,
                            hidePassword: false,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('@') ||
                                  !value.contains('.com')) {
                                _autoValidateMode = AutovalidateMode.always;
                                return 'please enter a valid email address';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _enteredEmail = value!;
                              });
                            },
                          ),
                          SizedBox(
                            height: height * 0.025,
                          ),
                          CustomTextField(
                            autovalidateMode: _autoValidateMode,
                            textInputType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            hidePassword: passwordProvider.hidePassword,
                            hintText: 'Password',
                            isObscured: true,
                            onVisibilityTaped: () {
                              passwordProvider.changePasswordVisibility();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                _autoValidateMode = AutovalidateMode.always;
                                return 'please enter a password';
                              } else if (value.length < 8) {
                                _autoValidateMode = AutovalidateMode.always;
                                return 'please enter a strong password';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _enteredPassword = value!;
                              });
                            },
                            onEditingComplete: () {
                              submitForm(
                                authenticationProvider: authenticationProvider,
                                context: context,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    const ForgotPassword(),
                    SizedBox(
                      height: height * 0.035,
                    ),
                    CustomButton(
                      onTap: () {
                        submitForm(
                          authenticationProvider: authenticationProvider,
                          context: context,
                        );
                      },
                      width: double.infinity,
                      height: height * 0.05,
                      background: Colors.white38,
                      text: 'Sign in',
                      borderRadius: 4,
                      textColor: Colors.white,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    const GoogleAuthenticationButton(
                      text: 'Sign in with Google',
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    const OrDivider(),
                    SizedBox(
                      height: height * 0.012,
                    ),
                    CustomButton(
                        width: double.infinity,
                        height: height * 0.05,
                        background: Colors.black,
                        text: 'Continue as a guest',
                        borderRadius: 4,
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SplashScreen(),
                            ),
                            (p) => false,
                          );
                        }),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    RedirectAuthenticationRow(
                      contextText: 'Don\'t have an account?',
                      redirectText: 'Sign up',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignUpView(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> submitForm({
    required BuildContext context,
    required AuthenticationProvider authenticationProvider,
  }) async {
    final isValid = _formKey.currentState!.validate();

    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      await authenticationProvider.signIn(
        email: _enteredEmail,
        password: _enteredPassword,
        context: context,
      );
    }
  }
}
