import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery/core/utils/contants.dart';

import '../core/models/user_info.dart';
import '../core/widgets/custom_snack_bar.dart';
import '../core/widgets/error_dialogue.dart';

class ProfileProvider with ChangeNotifier {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStore = FirebaseFirestore.instance;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  UserInfoModel? userInfo;
  Future<void> resetPassword(
      {required String email, required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    try {
      await firebaseAuth
          .sendPasswordResetEmail(
        email: email.trim().toLowerCase(),
      )
          .then((value) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            buildCustomSnackBar(
                backgroundColor: Colors.grey.shade600,
                message: 'An email has been sent to your email address',
                icon: Icons.info,
                context: context,
                margin:
                    const EdgeInsets.only(bottom: 120, right: 20, left: 20)),
          );
        }
      });
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => CustomErrorDialogue(
              contentText: e.message ?? 'firebase auth error'),
        );
      }

      print(e.message);
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
  }

  bool isGettingUserData = true;
  Future getUserInfo() async {
    try {
      final uid = firebaseAuth.currentUser?.uid;
      final doc =
          await firebaseStore.collection(usersCollection).doc(uid).get();

      if (doc.data() != null) {
        userInfo = UserInfoModel.fromJson(doc.data()!);
        print('got user info successfully');
        isGettingUserData = false;
        notifyListeners();
      }
    } catch (e) {
      isGettingUserData = false;
      notifyListeners();
      print(e.toString());
    }

    isGettingUserData = false;
    notifyListeners();
  }

  // updating the user shipping address
  Future<void> updateAddress(
      {required String newAddress, required BuildContext context}) async {
    final user = firebaseAuth.currentUser;
    try {
      _isLoading = true;
      notifyListeners();
      await firebaseStore.collection(usersCollection).doc(user?.uid).update(
        {'address': newAddress},
      );

      await getUserInfo();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            context: context,
            message: 'Something went wrong, try again later',
            backgroundColor: Colors.red,
            icon: Icons.error,
          ),
        );
      }
      print(e.toString());
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<int> logout() async {
    try {
      await firebaseAuth.signOut();
      userInfo = null;

      return 1;
    } catch (e) {
      print(e.toString());
      return 0;
    }
  }
}
