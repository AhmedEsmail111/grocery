import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:grocery/core/utils/styles/theme.dart';
import 'package:grocery/providers/authentication/authenticaion_provider.dart';
import 'package:grocery/providers/authentication/password_visibility_provider.dart';
import 'package:grocery/providers/bottom_nav_provider.dart';
import 'package:grocery/providers/cart_provider.dart';
import 'package:grocery/providers/orders_provider.dart';
import 'package:grocery/providers/products_provider.dart';
import 'package:grocery/providers/profile_provider.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:grocery/providers/viewed_provider.dart';
import 'package:grocery/providers/wishlist_provider.dart';
import 'package:grocery/views/login/login_view.dart';
import 'package:grocery/views/splash/splash_screen.dart';
import 'package:provider/provider.dart';

import 'core/utils/api_keys.dart';
import 'core/utils/services/shared_prefers.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initMain();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BottomNavProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PasswordVisibilityProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViewedProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthenticationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrdersProvider(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final isDark = Provider.of<ThemeProvider>(context).isDark;
          // final provider = Provider.of<ProfileProvider>(context);

          // final user = FirebaseAuth.instance.currentUser;
          // if (provider.userInfo == null && user != null) {
          //   provider.getUserInfo();
          // }
          context.read<ProductsProvider>().fetchProducts(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Grocery',
            theme: Styles.themeData(isDark, context),
            home: FirebaseAuth.instance.currentUser != null
                ? const SplashScreen()
                : const LoginView(),
          );
        },
      ),
    );
    // }
    // );
  }
}

Future<void> initMain() async {
  Stripe.publishableKey = publishableKey;
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}
