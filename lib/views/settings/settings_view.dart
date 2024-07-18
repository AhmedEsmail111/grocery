import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/core/widgets/error_dialogue.dart';
import 'package:grocery/core/widgets/loading_manager.dart';
import 'package:grocery/providers/profile_provider.dart';
import 'package:grocery/views/forgot_password/forgot_password_view.dart';
import 'package:grocery/views/login/login_view.dart';
import 'package:grocery/views/orders/orders_view.dart';
import 'package:grocery/views/settings/widgets/address_dialogue_widget.dart';
import 'package:grocery/views/viewed/viewed_view.dart';
import 'package:grocery/views/wishlist/wishlist_view.dart';
import 'package:provider/provider.dart';

import '../../core/utils/functions.dart';
import 'widgets/settings_tile.dart';
import 'widgets/user_settings__info.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    // final authenticationProvider = Provider.of<AuthenticationProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);

    final user = FirebaseAuth.instance.currentUser;
    if (user != null && profileProvider.userInfo == null) {
      profileProvider.getUserInfo();
    }
    return Scaffold(
        body: CustomLoadingManager(
      isLoading: profileProvider.isLoading,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 30,
                  bottom: 8,
                ),
                child: UserSettingsInfo(
                  userName: profileProvider.userInfo != null
                      ? profileProvider.userInfo!.name
                      : 'No user',
                  userEmail: profileProvider.userInfo != null
                      ? profileProvider.userInfo!.email
                      : 'No user',
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 8,
              ),
              SettingsTile(
                icon: IconlyLight.profile,
                title: 'Address',
                subTitle: profileProvider.userInfo != null
                    ? profileProvider.userInfo!.address
                    : '',
                onTap: () async {
                  await showDialog(
                      context: context,
                      builder: (_) => const AddressDialogueWidget());
                },
              ),
              SettingsTile(
                icon: IconlyLight.wallet,
                title: 'Orders',
                subTitle: '',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const OrdersView(),
                    ),
                  );
                },
              ),
              SettingsTile(
                icon: IconlyLight.show,
                title: 'Viewed',
                subTitle: '',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ViewedView(),
                    ),
                  );
                },
              ),
              SettingsTile(
                icon: IconlyLight.heart,
                title: 'Wishlist',
                subTitle: '',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WishlistView(),
                    ),
                  );
                },
              ),
              const SettingsTile(
                icon: Icons.brightness_4_outlined,
                title: 'Theme',
                subTitle: '',
                withSwitch: true,
              ),
              SettingsTile(
                icon: IconlyLight.lock,
                title: 'Forgot Password',
                subTitle: '',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ForgotPasswordView(),
                    ),
                  );
                },
              ),
              SettingsTile(
                icon: IconlyLight.logout,
                title: user != null ? 'Logout' : 'Login',
                subTitle: '',
                onTap: user != null
                    ? () {
                        showAlertDialogue(
                          context: context,
                          title: 'Log out',
                          content: 'Do you wanna log out?',
                          onPressed: () async {
                            final response = await profileProvider.logout();
                            if (context.mounted && response == 1) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginView(),
                                ),
                                (p) => false,
                              );
                            } else if (context.mounted && response == 0) {
                              showDialog(
                                context: context,
                                builder: (_) => const CustomErrorDialogue(
                                    contentText:
                                        'An error while signing you out'),
                              );
                            }
                          },
                        );
                      }
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginView(),
                          ),
                        );
                      },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
