import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grocery/core/widgets/go_back_icon.dart';
import 'package:grocery/core/widgets/loading_manager.dart';
import 'package:grocery/providers/authentication/authenticaion_provider.dart';
import 'package:provider/provider.dart';

import '../../core/utils/contants.dart';
import '../../core/widgets/authentication_welcome.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/forgot_password.dart';
import '../../core/widgets/redirect_authentication_row.dart';
import '../../core/widgets/swiper.dart';
import '../../providers/authentication/password_visibility_provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final formKey = GlobalKey<FormState>();
  String _enteredEmail = '';
  String _enteredPassword = '';
  String _enteredName = '';
  String _enteredAddress = '';
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final shippingFocusNode = FocusNode();
  @override
  void dispose() {
    super.dispose();

    shippingFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    // final _emailController = TextEditingController();
    // final _passwordController = TextEditingController();
    final authenticationProvider = Provider.of<AuthenticationProvider>(context);
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
                  top: height * 0.1,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GoBackIconButton(),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    const AuthenticationWelcome(
                      title: 'Welcome',
                      subTitle: 'Sign up to continue',
                    ),
                    SizedBox(
                      height: height * 0.035,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            autovalidateMode: autoValidateMode,
                            textInputType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            hintText: 'Full Name',
                            isObscured: false,
                            hidePassword: false,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                autoValidateMode = AutovalidateMode.always;
                                return 'please enter your full name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _enteredName = value!;
                              });
                            },
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CustomTextField(
                            autovalidateMode: autoValidateMode,
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
                                autoValidateMode = AutovalidateMode.always;
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
                            height: height * 0.02,
                          ),
                          CustomTextField(
                            autovalidateMode: autoValidateMode,
                            textInputType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            hidePassword: passwordProvider.hidePassword,
                            hintText: 'Password',
                            isObscured: true,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(shippingFocusNode),
                            onVisibilityTaped: () {
                              passwordProvider.changePasswordVisibility();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                autoValidateMode = AutovalidateMode.always;
                                return 'please enter a password';
                              } else if (value.length < 8) {
                                autoValidateMode = AutovalidateMode.always;
                                return 'please enter a strong password';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _enteredPassword = value!;
                              });
                            },
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CustomTextField(
                            autovalidateMode: autoValidateMode,
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            hintText: 'Shipping address',
                            maxLines: 2,
                            isObscured: false,
                            hidePassword: false,
                            focusNode: shippingFocusNode,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                autoValidateMode = AutovalidateMode.always;
                                return 'please enter your shipping address';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _enteredAddress = value!;
                              });
                            },
                            onEditingComplete: () {
                              submitForm(
                                context: context,
                                authenticationProvider: authenticationProvider,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    const ForgotPassword(),
                    SizedBox(
                      height: height * 0.012,
                    ),
                    CustomButton(
                      onTap: () {
                        submitForm(
                          context: context,
                          authenticationProvider: authenticationProvider,
                        );
                      },
                      width: double.infinity,
                      height: height * 0.05,
                      background: Colors.white38,
                      text: 'Sign up',
                      borderRadius: 4,
                      textColor: Colors.white,
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    RedirectAuthenticationRow(
                      contextText: 'Already a user?',
                      redirectText: 'Sign in',
                      onTap: () {
                        Navigator.pop(context);
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
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      formKey.currentState!.save();
      await authenticationProvider.register(
        email: _enteredEmail,
        password: _enteredPassword,
        context: context,
        name: _enteredName,
        address: _enteredAddress,
      );
    }
  }
}
