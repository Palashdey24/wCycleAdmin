import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:wcycle_admin_panel/core/page_config.dart';
import 'package:wcycle_admin_panel/helper/dialogs_helper.dart';
import 'package:wcycle_admin_panel/helper/firebase_helper.dart';
import 'package:wcycle_admin_panel/helper/font_helper.dart';
import 'package:wcycle_admin_panel/utlits/style.dart';
import 'package:wcycle_admin_panel/widgets/form_text_texts.dart';
import 'package:wcycle_admin_panel/widgets/time_date_collector.dart';
import 'package:wcycle_admin_panel/widgets/upload_image.dart';

final api = Apis();
final dialogHelper = DialogsHelper();
final firebaseHelper = FirebaseHelper();
final fontHelper = FontHelper();

class AddEventsItems extends StatelessWidget {
  const AddEventsItems({super.key});

  static const pageConfig =
      PageConfig(pageName: "addEventsItem", child: AddEventsItems());
  @override
  Widget build(BuildContext context) {
    late String eventTittle;
    late String eventDescription;
    const int eventInterest = 0;
    String? eventDate;
    String? eventTime;

    final formKey = GlobalKey<FormState>();
    String? ltImage;
    String userID = FirebaseHelper.firebaseAuth.currentUser?.uid ?? "null";

    void onSave() {
      if (formKey.currentState!.validate()) {
        //Check upload image and level are null or added
        if (ltImage == null || eventDate == null || eventTime == null) {
          DialogsHelper.showMessage(context,
              "Please check you may not upload Image/ Select Time / Date");
          return;
        } else {
          //Sent Littered data by Map to FirebaseHelper class where the function upload the data
          final upData = firebaseHelper.upFirestoreData({
            "userId": userID,
            "eventsTittle": eventTittle,
            "eventsDescription": eventDescription,
            "eventsInterested": eventInterest,
            "eventsDate": eventDate,
            "eventsTime": eventTime,
            "ltSrc": ltImage,
            "eventsOnline": true,
          }, "Events", context);

          //Check the data successfully Up or Not
          formKey.currentState!.reset();

          DialogsHelper.showMessage(context, "Data Added Successfully");
        }
      }
    }

    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.9,
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
                      storageRef: "Events",
                      downloadUriFn: (uri) => ltImage = uri,
                    ),
                    const Gap(csGap),
                    FormTextTexts(
                        iconData: FontAwesomeIcons.recycle,
                        fieldlabel: "Events Tittle",
                        fieldHint: "Please add event Tittle like we save tree",
                        fieldType: TextInputType.text,
                        vaildator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.trim().length < 3) {
                            return "Please add A event Tittle";
                          }
                          eventTittle = value;
                          return null;
                        }),
                    const Gap(csGap + 20),
                    FormTextTexts(
                        iconData: FontAwesomeIcons.prescriptionBottleMedical,
                        fieldlabel: "Descriptions",
                        fieldHint: "Please add Descriptions",
                        fieldType: TextInputType.text,
                        maxLen: 256,
                        maxLines: 7,
                        vaildator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.trim().length < 3) {
                            return "Please add A Descriptions";
                          }
                          eventDescription = value;
                          return null;
                        }),
                    const Gap(csGap + 20),
                    TimeDateCollector(
                      onSelDate: (date) {
                        eventDate = date;
                      },
                      onSelTime: (time) {
                        eventTime = time;
                      },
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
    );
  }
}
