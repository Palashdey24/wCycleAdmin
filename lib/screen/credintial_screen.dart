import 'package:flutter/material.dart';
import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:wcycle_admin_panel/helper/dialogs_helper.dart';
import 'package:wcycle_admin_panel/helper/sign_helper.dart';
import 'package:wcycle_admin_panel/utlits/style.dart';
import 'package:wcycle_admin_panel/widgets/eliptical_btn.dart';
import 'package:wcycle_admin_panel/widgets/form_text_texts.dart';
import 'package:gap/gap.dart';

final signHelp = SignHelper();
final apis = Apis();
final dialog = DialogsHelper();
final _formKeyLogEmail = GlobalKey<FormState>();

class CredintialScreen extends StatefulWidget {
  const CredintialScreen({super.key});

  @override
  State<CredintialScreen> createState() => _CredintialScreenState();
}

class _CredintialScreenState extends State<CredintialScreen> {
  String? emailAddress;
  String? logPass;

  void onLogbyEmail() async {
    final vaildate = _formKeyLogEmail.currentState!.validate();

    if (vaildate) {
      dialog.showProgressBar(context);
      _formKeyLogEmail.currentState!.save();
      signHelp.signIn(context, emailAddress!, logPass!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deWidth = Apis().deviceWidth(context);
    return Form(
      key: _formKeyLogEmail,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: deWidth * 0.3),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(csGap),
                side: const BorderSide(strokeAlign: 10, color: Colors.orange)),
            color: forgroundColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormTextTexts(
                      vaildator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.trim().length < 4 ||
                            !value.trim().contains("@") ||
                            !value.trim().contains(".")) {
                          return "Please add A Valid Email Address which contains @ and .";
                        }
                        return null;
                      },
                      onSave: (inputTxt) {
                        emailAddress = inputTxt;
                      },
                      iconData: Icons.email_rounded,
                      fieldlabel: "Email",
                      fieldHint: "Please enter a Email which contain @ and .",
                      fieldType: TextInputType.text),
                  const Gap(csGap),
                  FormTextTexts(
                      vaildator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.trim().length < 8) {
                          return "Please add A Strong 8 char Pass";
                        }
                        return null;
                      },
                      onSave: (inputTxt) {
                        logPass = inputTxt;
                      },
                      obsecureTXt: true,
                      iconData: Icons.admin_panel_settings_sharp,
                      fieldlabel: "Password",
                      fieldHint: "Please enter a 8 character password at last",
                      fieldType: TextInputType.text),
                  const Gap(csGap),
                  ElipticalBtn(onLog: onLogbyEmail, btnTxt: "Login"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
