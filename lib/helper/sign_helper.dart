import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:wcycle_admin_panel/screen/home_screen.dart';

import 'dialogs_helper.dart';

final apis = Apis();
final dialog = DialogsHelper();

class SignHelper {
  void signIn(BuildContext context, String emailAddress, String logPass) async {
    try {
      final cred = await apis.firebaseAuth
          .signInWithEmailAndPassword(email: emailAddress, password: logPass);

      if (cred.user != null) {
        final isAdmin =
            await apis.fireStore.collection("admin").doc(cred.user!.uid).get();
        if (!context.mounted) return;
        if (isAdmin.exists) {
          Navigator.pop(context);
          DialogsHelper.showMessage(context, "You are admin");
          context.pushReplacementNamed(HomeScreen.pageConfig.pageName);
        } else {
          apis.firebaseAuth.signOut();
          Navigator.pop(context);
          DialogsHelper.showMessage(
              context, "You are not Admin! Step back please");
        }
      }
/*          .then(
        (value) async {
          final isAdmin = await apis.fireStore
              .collection("admin")
              .doc(value.user!.uid)
              .get();

          if (!context.mounted) {
            return;
          } else {
            if (isAdmin['email'] == emailAddress) {
              context.replaceNamed(HomeScreen.pageConfig.pageName);
              Navigator.pop(context);
              dialog.showMessage(context, "You are Admin!");

*/ /*               Navigator.pushAndRemoveUntil(
                  context,

                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  )); */ /*
            } else {
              apis.firebaseAuth.signOut();
              Navigator.pop(context);
              dialog.showMessage(
                  context, "You are not Admin! Step back please");
            }
          }
        },
      );*/
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;

      DialogsHelper.showMessage(context, "Issue: ${e.message}");
      Navigator.pop(context);
    }
  }
}
