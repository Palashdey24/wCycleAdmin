import 'package:firebase_auth/firebase_auth.dart';
import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:wcycle_admin_panel/screen/home_screen.dart';
import 'package:flutter/material.dart';

import 'dialogs_helper.dart';

final apis = Apis();
final dialog = DialogsHelper();

class SignHelper {
  void signIn(BuildContext context, String emailAddress, String logPass) async {
    try {
      await apis.firebaseAuth
          .signInWithEmailAndPassword(email: emailAddress, password: logPass)
          .then(
        (value) async {
          final isAdmin = await apis.fireStore
              .collection("admin")
              .doc(value.user!.uid)
              .get();

          if (!context.mounted) {
            return;
          } else {
            if (isAdmin.exists) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                  ModalRoute.withName("/home"));
/*              Navigator.pushAndRemoveUntil(
                  context,

                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));*/
            } else {
              apis.firebaseAuth.signOut();
              Navigator.pop(context);
              dialog.showMessage(
                  context, "You are not Admin! Step back please");
            }
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      Navigator.pop(context);
      dialog.removeMessage(context);
      dialog.showMessage(context, "Issue: ${e.message}");
    }
  }
}
