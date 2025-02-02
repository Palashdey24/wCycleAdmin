import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:wcycle_admin_panel/config/theme/app_theme.dart';
import 'package:wcycle_admin_panel/core/routes.dart';
import 'package:wcycle_admin_panel/utlits/string.dart';

import 'firebase_options.dart';

final api = Apis();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appName,
      theme: AppTheme.appTheme.copyWith(
        textTheme: GoogleFonts.sairaCondensedTextTheme(),
      ),
      routerConfig: routes,
    );
  }
}
