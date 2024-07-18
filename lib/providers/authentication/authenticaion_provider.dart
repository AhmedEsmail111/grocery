import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery/core/models/user_info.dart';
import 'package:grocery/core/utils/contants.dart';
import 'package:grocery/core/widgets/error_dialogue.dart';
import 'package:grocery/main.dart';

class AuthenticationProvider with ChangeNotifier {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStore = FirebaseFirestore.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<({UserCredential? user, String error})> register(
      {required String email,
      required String password,
      required BuildContext context,
      required String address,
      required String name}) async {
    String error = '';
    UserCredential? userCredential;
    _isLoading = true;
    notifyListeners();
    try {
      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim().toLowerCase(),
        password: password.trim(),
      );

// if there is a user go to the home screen
      if (userCredential.user != null) {
        userCredential.user!.updateDisplayName(name);
        userCredential.user!.reload();
        final userInfo = UserInfoModel(
          uid: userCredential.user!.uid,
          name: name,
          email: email.trim().toLowerCase(),
          address: address,
          userWish: [],
          userCart: [],
          createdAt: Timestamp.now(),
        );
        await saveUserInfo(userInfo);

        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const MyApp(),
            ),
            (_) => false,
          );
        }
      }
    } on FirebaseException catch (e) {
      _isLoading = false;
      notifyListeners();

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => CustomErrorDialogue(
            contentText: e.message ?? 'firebase auth error',
          ),
        );
      }

      error = e.message ?? 'firebase auth error';
      print(e.message.toString());
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => CustomErrorDialogue(
            contentText: e.toString(),
          ),
        );
      }

      error = e.toString();
      print(e.toString());
    }
    //  finally {
    //   _isLoading = false;
    // }
    _isLoading = false;
    notifyListeners();
    return (user: userCredential, error: error);
  }

  Future<({UserCredential? user, String error})> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    String error = '';
    UserCredential? userCredential;
    _isLoading = true;
    notifyListeners();
    try {
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email.trim().toLowerCase(),
        password: password.trim(),
      );
// if there is a user go to the home screen
      if (userCredential.user != null) {
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const MyApp(),
            ),
            (p) => false,
          );
        }
      }

      print('sign in done');
    } on FirebaseException catch (e) {
      _isLoading = false;
      notifyListeners();
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => CustomErrorDialogue(
            contentText: e.message ?? 'firebase auth error',
          ),
        );
      }

      error = e.message ?? 'firebase auth error';
      print(e.message.toString());
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => CustomErrorDialogue(
            contentText: e.toString(),
          ),
        );
      }
      error = e.toString();
      print(e.toString());
    }
    // finally {
    //   _isLoading = false;
    // }
    _isLoading = false;
    notifyListeners();
    return (user: userCredential, error: error);
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    UserCredential? userCredential;
    _isLoading = true;
    notifyListeners();
    try {
      // trigger the sign in flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // obtain the authentication details
      final GoogleSignInAuthentication? googleAuthDetails =
          await googleUser?.authentication;

      // create the credentials
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuthDetails?.accessToken,
        idToken: googleAuthDetails?.idToken,
      );

      userCredential = await firebaseAuth.signInWithCredential(credentials);
// if there is a user go to the home screen
      if (userCredential.user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          final userInfo = UserInfoModel(
            uid: userCredential.user!.uid,
            name: userCredential.user!.displayName ?? '',
            email: userCredential.user!.email ?? '',
            address: '',
            userWish: [],
            userCart: [],
            createdAt: Timestamp.now(),
          );
          await saveUserInfo(userInfo);
        }

        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const MyApp(),
            ),
            (_) => false,
          );
        }
      }

      print('google sign in done');
    } on FirebaseException catch (e) {
      _isLoading = false;
      notifyListeners();

      print(e.message.toString());

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => CustomErrorDialogue(
              contentText: e.message ?? 'firebase auth error'),
        );
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => CustomErrorDialogue(
            contentText: e.toString(),
          ),
        );
      }

      print(e.toString());
    }

    _isLoading = false;
    notifyListeners();
    // return (user: userCredential, error: error);
  }

  // save the user info to the fireStore
  Future<void> saveUserInfo(UserInfoModel userInfo) async {
    await firebaseStore.collection(usersCollection).doc(userInfo.uid).set(
          userInfo.toJson(),
        );
  }
}
