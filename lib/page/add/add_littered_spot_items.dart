import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:wcycle_admin_panel/helper/dialogs_helper.dart';
import 'package:wcycle_admin_panel/helper/firebase_helper.dart';
import 'package:wcycle_admin_panel/utlits/style.dart';
import 'package:wcycle_admin_panel/widgets/division_dropdown.dart';
import 'package:wcycle_admin_panel/widgets/form_text_texts.dart';
import 'package:wcycle_admin_panel/widgets/firebase_dropdown_helper.dart';
import 'package:wcycle_admin_panel/widgets/upload_image.dart';
import 'package:wcycle_admin_panel/widgets/waste_material_chip.dart';

final api = Apis();
final dialogHelper = DialogsHelper();
final firebaseHelper = FirebaseHelper();

class AddLitteredSpotItems extends StatelessWidget {
  const AddLitteredSpotItems({super.key});

  @override
  Widget build(BuildContext context) {
    late String ltTittle;
    late String ltAddress;
    late String ltDivision;
    late String ltVillMet;
    late String ltThana;
    late String ltWard;

    final formKey = GlobalKey<FormState>();
    String? impactLevel;
    String? ltImage;
    List<String> wasteMaterial = [];
    String userID = firebaseHelper.firebaseAuth.currentUser?.uid ?? "null";

    void onSave() {
      if (formKey.currentState!.validate()) {
        //Check upload image and level are null or added
        if (impactLevel == null || ltImage == null || wasteMaterial.isEmpty) {
          dialogHelper.removeMessage(context);
          dialogHelper.showMessage(context,
              "Please upload Image and Select Impact Level and Select at last one Waste Materials");
          return;
        } else {
          //Sent Littered data by Map to FirebaseHelper class where the function upload the data
          firebaseHelper.upFirestoreData({
            "userId": userID,
            "createAdd": Timestamp.now().toString(),
            "litteredTittle": ltTittle,
            "litteredAddress": ltAddress,
            "litteredVillMet": ltVillMet,
            "litteredThana": ltThana,
            "litteredDivision": ltDivision,
            "litteredImpactLevel": impactLevel,
            "litteredWard": ltWard,
            "litteredWasteMat": wasteMaterial,
            "ltSrc": ltImage,
            "productOnline": true,
          }, "litteredSpot", context);

          //Check the data successfully Up or Not
          formKey.currentState!.reset();
          dialogHelper.removeMessage(context);
          dialogHelper.showMessage(context, "Data Added Successfully");
        }
      }
    }

    return Scaffold(
        backgroundColor: Colors.indigo.withOpacity(0.7),
        body: Center(
          child: SizedBox(
            width: api.deviceWidth(context) / 2,
            child: Card(
              elevation: 10,
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.orange, width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(45))),
              color: Colors.blueGrey,
              child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Gap(largeGap),
                        UploadImage(
                          storageRef: "LitteredSpot",
                          downloadUriFn: (uri) => ltImage = uri,
                        ),
                        const Gap(csGap),
                        FormTextTexts(
                            iconData: FontAwesomeIcons.recycle,
                            fieldlabel: "littered Tittle",
                            fieldHint:
                                "Please add Littered Spot like waste on Pond etc",
                            fieldType: TextInputType.text,
                            vaildator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.trim().length < 3) {
                                return "Please add A Littered Spot ";
                              }
                              ltTittle = value;
                              return null;
                            }),
                        const Gap(csGap + 20),
                        FormTextTexts(
                            iconData: FontAwesomeIcons.recycle,
                            fieldlabel: "Address",
                            fieldHint: "Please add Littered Spot Address",
                            fieldType: TextInputType.text,
                            maxLen: 72,
                            vaildator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.trim().length < 3) {
                                return "Please add A valid address";
                              }
                              ltAddress = value;
                              return null;
                            }),
                        const Gap(csGap + 20),
                        Row(
                          children: [
                            Expanded(
                              child: DivisionDropdown(
                                  onDropdownFn: (value) {},
                                  formFieldValidator: (value) {
                                    if (value == null ||
                                        value.trim().isEmpty ||
                                        value.trim() == "") {
                                      return "Please select Impact Level";
                                    }
                                    ltDivision = value;
                                    return null;
                                  },
                                  dropLevel: "Division",
                                  dropHint: "select one Division"),
                            ),
                            const Gap(csGap),
                            Expanded(
                              child: FirebaseDropdownHelper(
                                onDropdownFn: (value) {
                                  impactLevel = value;
                                },
                                dropHint: "Select Impact Level",
                                dropLevel: "Impact Level",
                                fsCollection: "imapctLevel",
                                fsField: "level",
                              ),
                            ),
                          ],
                        ),
                        const Gap(largeGap),
                        Row(
                          children: [
                            Expanded(
                              child: FormTextTexts(
                                  iconData: FontAwesomeIcons.recycle,
                                  fieldlabel: "Village/Metro",
                                  fieldHint: "Please add Village or Metro name",
                                  fieldType: TextInputType.text,
                                  maxLen: 18,
                                  vaildator: (value) {
                                    if (value == null ||
                                        value.trim().isEmpty ||
                                        value.trim().length < 3) {
                                      return "Please add A valid Villag or Metro";
                                    }
                                    ltVillMet = value;
                                    return null;
                                  }),
                            ),
                            const Gap(csGap),
                            Expanded(
                              child: FormTextTexts(
                                  iconData: FontAwesomeIcons.recycle,
                                  fieldlabel: "Thana",
                                  fieldHint: "Please add Thana",
                                  fieldType: TextInputType.text,
                                  maxLen: 18,
                                  vaildator: (value) {
                                    if (value == null ||
                                        value.trim().isEmpty ||
                                        value.trim().length < 3) {
                                      return "Please add A valid thana";
                                    }
                                    ltThana = value;
                                    return null;
                                  }),
                            ),
                          ],
                        ),
                        const Gap(csGap),
                        FormTextTexts(
                            iconData: FontAwesomeIcons.recycle,
                            fieldlabel: "Ward",
                            fieldHint: "Please add a Ward",
                            fieldType: TextInputType.number,
                            vaildator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  int.tryParse(value) == null ||
                                  int.tryParse(value)! < 1) {
                                return "Please add A ward Number only like 3 and more than 0";
                              }
                              ltWard = value;
                              return null;
                            }),
                        const Gap(csGap),
                        Row(
                          children: [
                            const Expanded(
                              child: ListTile(
                                title: Text("Select Material:"),
                                leading: FaIcon(
                                  FontAwesomeIcons.circleCheck,
                                  size: 15,
                                  color: Colors.lime,
                                ),
                              ),
                            ),
                            Expanded(
                                child: WasteMaterialChip(
                              wasteMatFn: (waste) {
                                wasteMaterial = waste;
                                log(wasteMaterial.toList().toString());
                              },
                              fsCollection: "wasteMaterial",
                              fsField: "category",
                            )),
                          ],
                        ),
                        const Gap(largeGap),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                                onPressed: () => formKey.currentState!.reset(),
                                icon: const Icon(Icons.refresh),
                                label: const Text("Reset")),
                            const Spacer(),
                            ElevatedButton.icon(
                                onPressed: onSave,
                                icon: const Icon(Icons.data_saver_on_rounded),
                                label: const Text("Save")),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ));
  }
}
