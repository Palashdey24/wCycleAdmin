import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wcycle_admin_panel/helper/firebase_helper.dart';
import 'package:wcycle_admin_panel/helper/image_picker_helper.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:wcycle_admin_panel/widgets/loading_widget.dart';

final imagePickerHelper = ImagePickerHelper();
final firebaseHelper = FirebaseHelper();

class UploadImage extends StatefulWidget {
  const UploadImage(
      {super.key, required this.downloadUriFn, required this.storageRef});

  final void Function(String uri) downloadUriFn;
  final String storageRef;

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  String? pickOpt;
  File? pickImageFile;
  late Widget imageProvider;
  bool loadImage = false;
  String? uploadUri;

  void _pickImage(String imgOption) async {
    setState(() {
      loadImage = true;
    });
    final imagePicker = ImagePicker();

    final pickFile = await imagePicker.pickImage(
        source:
            imgOption == "Camera" ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 100,
        maxWidth: 150,
        maxHeight: 150);

    if (pickFile == null) {
      setState(() {
        loadImage = false;
      });

      return;
    }
    if (!context.mounted) return;

    Navigator.pop(context);

    setState(() {
      pickImageFile = File(pickFile.path);
    });

    //The below PickedFile are use for web
    PickedFile pfile = PickedFile(pickImageFile!.path);
    uploadUri = await firebaseHelper.uploadImage(widget.storageRef,
        pickFile.name.split("_").last, pfile, pickImageFile!);

    if (uploadUri != null) {
      //The below line for sent the downloadable uri back to add Recycle item
      widget.downloadUriFn(uploadUri!);

      setState(() {
        loadImage = false;
      });
      if (kIsWeb) {
        imageProvider = Image.network(
          pickImageFile!.path,
          fit: BoxFit.contain,
        );
        return;
      }
      imageProvider = Image.file(
        pickImageFile!,
        width: 90,
        height: 90,
        fit: BoxFit.contain,
      );
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        imagePickerHelper.showImgPickOptDia(
          context,
          (pickOption) {
            _pickImage(pickOption);
          },
        );
      },
      child: loadImage
          ? const CircleAvatar(
              maxRadius: 70,
              child: LoadingWidgets(),
            )
          : CircleAvatar(
              radius: 70,
              backgroundColor: Colors.black,
              child: uploadUri == null
                  ? const FaIcon(
                      FontAwesomeIcons.cloudArrowUp,
                      color: Colors.redAccent,
                      size: 65,
                    )
                  : imageProvider,
            ),
    );
  }
}
