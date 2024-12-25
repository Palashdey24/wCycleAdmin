import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_admin_panel/helper/font_helper.dart';
import 'package:wcycle_admin_panel/utlits/string.dart';
import 'package:wcycle_admin_panel/utlits/style.dart';

final fontHelper = FontHelper();

class TimeDateCollector extends StatefulWidget {
  const TimeDateCollector(
      {super.key,
      required this.onSelDate,
      required this.onSelTime,
      this.timeTricker});
  final void Function(String Date) onSelDate;
  final void Function(String time) onSelTime;
  final bool? timeTricker;

  @override
  State<TimeDateCollector> createState() => _TimeDateCollectorState();
}

class _TimeDateCollectorState extends State<TimeDateCollector> {
  String selectDate = "Select Date : ";
  String selectTime = "Select Time : ";
  void _datePicker() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      setState(() {
        selectDate = formatedDate(date);
      });
      widget.onSelDate(selectDate);
    }
  }

  void _timePicker() async {
    final time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        selectTime = time.format(context);
      });
      widget.onSelTime(selectTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectDate,
              style:
                  fontHelper.bodyMedium(context).copyWith(color: Colors.white),
            ),
            const Gap(largeGap),
            ElevatedButton(
                onPressed: _datePicker,
                child: const FaIcon(
                  FontAwesomeIcons.solidCalendar,
                  color: Colors.orange,
                )),
          ],
        )),
        Visibility(
          visible: widget.timeTricker ?? true,
          child: Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                selectTime,
                style: fontHelper
                    .bodyMedium(context)
                    .copyWith(color: Colors.white),
              ),
              const Gap(largeGap),
              ElevatedButton(
                  onPressed: _timePicker,
                  child: const FaIcon(
                    FontAwesomeIcons.solidClock,
                    color: Colors.greenAccent,
                  )),
            ],
          )),
        ),
      ],
    );
  }
}
