import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wcycle_admin_panel/helper/dialogs_helper.dart';

class FirebaseHelper {
  static final firebaseAuth = FirebaseAuth.instance;
  static final storageRefs = FirebaseStorage.instance;
  static final fireStore = FirebaseFirestore.instance;

  Future<String> uploadImage(String folder, String subFolder,
      PickedFile pickImgFile, File pickfile) async {
    final extension = subFolder.split(".").last;
    Reference storageRefImg = storageRefs.ref().child(folder).child(subFolder);

    await storageRefImg.putData(await pickImgFile.readAsBytes(),
        SettableMetadata(contentType: 'image/$extension'));
    String uploadUri = await storageRefImg.getDownloadURL();
    return uploadUri;
  }

  //This is canbe reusable helper for added data on firebase

  Future<String?> upFirestoreData(Map<String, dynamic> recycleData,
      String fsString, BuildContext context) async {
    DialogsHelper().showProgressBar(context);
    final reference = fireStore.collection(fsString);

    try {
      final upRecycleData = await reference.add(recycleData).then(
        (value) {
          if (context.mounted) {
            Navigator.pop(context);
            DialogsHelper.showMessage(context, "Added Successfully");
            return value.id;
          }
        },
      );

      return upRecycleData;
    } on FirebaseException catch (error) {
      if (!context.mounted) return null;

      Navigator.pop(context);
      DialogsHelper.showMessage(context, "Something Wrong: ${error.message}");
      return null;
    }
  }
}
