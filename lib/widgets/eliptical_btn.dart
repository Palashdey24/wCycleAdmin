import 'package:flutter/material.dart';
import 'package:wcycle_admin_panel/utlits/style.dart';

class ElipticalBtn extends StatelessWidget {
  const ElipticalBtn({super.key, required this.onLog, required this.btnTxt});

  final void Function() onLog;
  final String btnTxt;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(10, 10))),
              backgroundColor: backgroundColor,
              foregroundColor: forgroundColor),
          onPressed: onLog,
          child: Text(btnTxt)),
    );
  }
}
