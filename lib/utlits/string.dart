import 'package:intl/intl.dart';

const String appName = "WcycleBD Admin";
const String appLogo = "assets/wcycle-bd-hd-logo.png";

final dateFormtter = DateFormat.yMMMEd();

String formatedDate(DateTime date) {
  return dateFormtter.format(date);
}
