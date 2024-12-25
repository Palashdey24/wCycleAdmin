import 'package:flutter/material.dart';
import 'package:wcycle_admin_panel/helper/font_helper.dart';
import 'package:wcycle_admin_panel/widgets/loading_widget.dart';

final fontHelper = FontHelper();

class DialogsHelper {
  void showMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: fontHelper.bodyMedium(context).copyWith(color: Colors.white),
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    ));
  }

  void removeMessage(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  void showProgressBar(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return const Center(child: LoadingWidgets());
      },
    );
  }
}
