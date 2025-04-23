import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/config/theme/app_font.dart';
import 'package:wcycle_admin_panel/helper/dialogs_helper.dart';
import 'package:wcycle_admin_panel/helper/firebase_helper.dart';
import 'package:wcycle_admin_panel/widgets/loading_widget.dart';

const List<String> statusList = ["Verified", "Under Review", "Terminated"];

class UpdateStoreStatus extends StatefulWidget {
  const UpdateStoreStatus({
    super.key,
    required this.storeStatus,
    required this.storeId,
  });

  final String storeStatus;
  final String storeId;

  @override
  State<UpdateStoreStatus> createState() => _UpdateStoreStatusState();
}

class _UpdateStoreStatusState extends State<UpdateStoreStatus> {
  String? selectStatus;
  final reference = FirebaseHelper.fireStore.collection("store");
  bool isLoaded = false;
  String? vaildetForms(String? value, String errorMsg) {
    if (value == null ||
        value.trim().isEmpty ||
        value.trim().length < 3 ||
        value.trim() == "") {
      return "Please add A valid $errorMsg";
    }
    return null;
  }

  void updatedStatus() async {
    setState(() {
      isLoaded = true;
    });
    if (selectStatus != widget.storeStatus && selectStatus != null) {
      final checkReference = await reference.doc(widget.storeId).get();

      if (!mounted) return;
      if (!checkReference.exists) {
        setState(() {
          isLoaded = false;
        });
        Navigator.pop(context);
        DialogsHelper.showMessage(context, "Store Not found");
        return;
      }
      FirebaseFirestore.instance.collection("checking").add({
        "storeData": reference.doc(widget.storeId),
        "status": "Updated Status ${widget.storeId}"
      });

      reference.doc(widget.storeId).update({'storeStatus': selectStatus!}).then(
        (value) {
          if (!mounted) return;
          Navigator.pop(context);
          DialogsHelper.showMessage(context, "Status Updated Successfully");
        },
      ).catchError((error) {
        if (!mounted) return;
        Navigator.pop(context);
        DialogsHelper.showMessage(context, "Something Wrong: ${error.message}");
      });
      setState(() {
        isLoaded = false;
      });
      return;
    }
    if (!mounted) return;
    Navigator.pop(context);
    DialogsHelper.showMessage(context, "Status Not Changed");
    return;
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? const Center(
            child: LoadingWidgets(),
          )
        : AlertDialog(
            title: Text(
              "Status",
              style: AppFont.textLarge(context),
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                validator: (value) => vaildetForms(value as String, "Status"),
                value: selectStatus,
                style: const TextStyle(color: Colors.orangeAccent),
                //this line for DropDown Dialog background color or Radius
                dropdownColor: AppColor.kDarkColor,
                borderRadius: BorderRadius.circular(30),
                hint: Text(
                  widget.storeStatus,
                  style: const TextStyle(color: AppColor.kSixthColor),
                ),
                //Decoration refer for hint and other outer
                decoration: InputDecoration(
                    label: const Text(
                      "Status",
                      style: TextStyle(color: AppColor.kSixthColor),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
                items: [
                  for (var status in statusList)
                    DropdownMenuItem(
                      value: status,
                      child: Text(
                        status,
                        style: const TextStyle(color: AppColor.kSixthColor),
                      ),
                    )
                ],
                onChanged: (value) {
                  setState(() {
                    selectStatus = value as String;
                  });
                },
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                  )),
              TextButton(
                  onPressed: updatedStatus,
                  child: const Text(
                    "Save",
                  )),
            ],
          );
  }
}
