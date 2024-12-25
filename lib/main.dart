import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wcycle_admin_panel/core/routes.dart';
import 'package:wcycle_admin_panel/screen/home_screen.dart';
import 'package:wcycle_admin_panel/utlits/string.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(208, 10, 14, 21)),
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.sairaCondensedTextTheme()
            .copyWith(bodyLarge: const TextStyle(fontSize: 30)),
        useMaterial3: true,
      ),
      routerConfig: routes,
    );
  }
}
