import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery/core/widgets/loading_manager.dart';
import 'package:grocery/providers/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../core/utils/contants.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/go_back_icon.dart';
import '../../core/widgets/swiper.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  String _enteredEmail = "";
  final _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      body: CustomLoadingManager(
        isLoading: profileProvider.isLoading,
        child: Stack(
          children: [
            CustomSwiper(
              images: authSwiperImages,
              height: height,
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
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Forgot Password',
                            style: const TextStyle()
                                .copyWith(color: Colors.white, fontSize: 30),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          CustomTextField(
                            initialValue: _user?.email,
                            autovalidateMode: _autoValidateMode,
                            textInputType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            onEditingComplete: () {
                              resetPassword(
                                context: context,
                                profileProvider: profileProvider,
                              );
                            },
                            hintText: 'Email address',
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
                            height: height * 0.03,
                          ),
                          CustomButton(
                            onTap: () {
                              resetPassword(
                                context: context,
                                profileProvider: profileProvider,
                              );
                            },
                            width: double.infinity,
                            height: height * 0.05,
                            background: Colors.white38,
                            text: 'Reset now',
                            borderRadius: 4,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> resetPassword(
      {required BuildContext context,
      required ProfileProvider profileProvider}) async {
    final isValid = _formKey.currentState!.validate();

    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      await profileProvider.resetPassword(
        email: _enteredEmail,
        context: context,
      );
    }
  }
}
