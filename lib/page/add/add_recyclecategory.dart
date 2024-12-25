import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:wcycle_admin_panel/helper/dialogs_helper.dart';
import 'package:wcycle_admin_panel/helper/firebase_helper.dart';
import 'package:wcycle_admin_panel/utlits/style.dart';
import 'package:wcycle_admin_panel/widgets/form_text_texts.dart';
import 'package:wcycle_admin_panel/widgets/firebase_dropdown_helper.dart';
import 'package:wcycle_admin_panel/widgets/upload_image.dart';

final api = Apis();
final dialogHelper = DialogsHelper();
final firebaseHelper = FirebaseHelper();

class AddRecycableCategory extends StatelessWidget {
  const AddRecycableCategory({super.key});

  @override
  Widget build(BuildContext context) {
    late String recycleName;
    //late int? recyclePrice;
    String userID = firebaseHelper.firebaseAuth.currentUser?.uid ?? "null";

    final formKey = GlobalKey<FormState>();
    String? impactLevel;
    String? recycleImage;

    void onSave() {
      if (formKey.currentState!.validate()) {
        //Check upload image and level are null or added
        if (impactLevel == null || recycleImage == null) {
          dialogHelper.removeMessage(context);
          dialogHelper.showMessage(
              context, "Please upload Image and Select Impact Level");
          return;
        } else {
          //Sent recycle data by Map to FirebaseHelper class where the function upload the data

          final upData = firebaseHelper.upFirestoreData({
            //"userId": userID,
            "productName": recycleName,
            //"ProductPrice": recyclePrice,
            "productImage": recycleImage,
            "impactLevel": impactLevel,
            // "ProductOnline": true,
          }, "recycleCategory", context);

          formKey.currentState!.reset();
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
                          storageRef: "RecycleCategory",
                          downloadUriFn: (uri) => recycleImage = uri,
                        ),
                        const Gap(csGap),
                        FormTextTexts(
                            onSave: (value) {},
                            iconData: FontAwesomeIcons.recycle,
                            fieldlabel: "Recycle Product",
                            fieldHint:
                                "Please add Recycle Product like plastic, metal etc",
                            fieldType: TextInputType.text,
                            vaildator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.trim().length < 3) {
                                return "Please add A Valid Full Form of Recycle Product";
                              }
                              recycleName = value;
                              return null;
                            }),
                        const Gap(csGap),
                        const Gap(20),
                        Row(
                          children: [
/*                            Expanded(
                              child: FormTextTexts(
                                onSave: (value) {},
                                iconData: FontAwesomeIcons.moneyBill1,
                                fieldlabel: "Prices",
                                fieldHint: "Please add a Price",
                                fieldType: TextInputType.number,
                                vaildator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      int.tryParse(value)! <= 5) {
                                    return "Please add Price more than 5 at last";
                                  }
                                  recyclePrice = int.tryParse(value);
                                  return null;
                                },
                              ),
                            ),
                            const Gap(csGap),*/
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
