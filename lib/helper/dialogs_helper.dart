import 'package:flutter/material.dart';
import 'package:wcycle_admin_panel/helper/font_helper.dart';
import 'package:wcycle_admin_panel/widgets/loading_widget.dart';

final fontHelper = FontHelper();

class DialogsHelper {
  static void showMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: fontHelper.bodyMedium(context).copyWith(color: Colors.white),
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    ));
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
