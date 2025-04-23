import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/config/theme/app_font.dart';
import 'package:wcycle_admin_panel/core/page_config.dart';
import 'package:wcycle_admin_panel/helper/dialogs_helper.dart';
import 'package:wcycle_admin_panel/helper/firebase_helper.dart';
import 'package:wcycle_admin_panel/helper/font_helper.dart';
import 'package:wcycle_admin_panel/utlits/style.dart';
import 'package:wcycle_admin_panel/widgets/form_text_texts.dart';
import 'package:wcycle_admin_panel/widgets/upload_image.dart';

final api = Apis();
final dialogHelper = DialogsHelper();
final firebaseHelper = FirebaseHelper();
final fontHelper = FontHelper();

class AddNews extends StatelessWidget {
  const AddNews({super.key});

  String? valueVaild(String? value, String errorMsg) {
    if (value == null || value.trim().isEmpty || value.trim().length < 3) {
      return errorMsg;
    }
    return null;
  }

  static const pageConfig = PageConfig(pageName: "addNews", child: AddNews());
  @override
  Widget build(BuildContext context) {
    late String newsTittle;
    late String newsDescription;
    late String newsLink;

    ValueNotifier<int> isLinkVideo = ValueNotifier(0);
    String linkType = "Link";

    final formKey = GlobalKey<FormState>();
    String? ltImage;
    String userID = FirebaseHelper.firebaseAuth.currentUser?.uid ?? "null";

    void onLinkType(int i) {
      isLinkVideo.value = i;
      i == 1 ? linkType = "Video" : linkType = "Link";
      DialogsHelper.showMessage(context, "Link type: $linkType");
    }

    void onSave() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        //Check upload image and level are null or added
        if (ltImage == null) {
          DialogsHelper.showMessage(context,
              "Please check you may not upload Image/ Select Time / Date");
          return;
        } else {
          //Sent Littered data by Map to FirebaseHelper class where the function upload the data
          final upData = firebaseHelper.upFirestoreData({
            "userId": userID,
            "newsTittle": newsTittle,
            "newsDescription": newsDescription,
            "newsLink": newsLink,
            "ltSrc": ltImage,
            "linkType": linkType,
            "newsStatus": true,
          }, "News", context);

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
                      storageRef: "News",
                      downloadUriFn: (uri) => ltImage = uri,
                    ),
                    const Gap(csGap),
                    FormTextTexts(
                      iconData: FontAwesomeIcons.recycle,
                      fieldlabel: "News Tittle",
                      fieldHint:
                          "Please add news Tittle like 10 Steps of Waste Management Planning",
                      fieldType: TextInputType.text,
                      vaildator: (value) =>
                          valueVaild(value, "Please add A Tittle"),
                      onSave: (value) => newsTittle = value,
                    ),
                    const Gap(csGap + 20),
                    FormTextTexts(
                      iconData: FontAwesomeIcons.prescriptionBottleMedical,
                      fieldlabel: "News Shorts Note",
                      fieldHint: "Please add Short Note",
                      fieldType: TextInputType.text,
                      maxLen: 120,
                      maxLines: 3,
                      vaildator: (value) =>
                          valueVaild(value, "Please add A Short Note"),
                      onSave: (value) => newsDescription = value,
                    ),
                    const Gap(csGap),
                    ValueListenableBuilder(
                      builder: (context, value, child) {
                        return Flex(
                          direction: Axis.horizontal,
                          children: [
                            Text(
                              "Type : ",
                              style: AppFont.textMedium(context)
                                  .copyWith(color: AppColor.kLightColor),
                            ),
                            const Gap(csGap),
                            for (int i = 0; i <= 1; i++)
                              TextButton(
                                  onPressed: () => onLinkType(i),
                                  style: TextButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero),
                                      backgroundColor: isLinkVideo.value == i
                                          ? AppColor.kDarkColor
                                          : AppColor.kSixthColor),
                                  child: Text(
                                    i == 0 ? "Link" : "Video",
                                    style: AppFont.textSmall(context),
                                  ))
                          ],
                        );
                      },
                      valueListenable: isLinkVideo,
                    ),
                    const Gap(csGap),
                    FormTextTexts(
                      iconData: FontAwesomeIcons.recycle,
                      fieldlabel: "News Link",
                      fieldHint: "Please add news Link",
                      fieldType: TextInputType.text,
                      vaildator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.trim().contains(".") ||
                            value.trim().length < 3) {
                          return "Please add A news link which contain (.)";
                        }
                        newsLink = value;
                        return null;
                      },
                      onSave: (value) => newsLink = value,
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
