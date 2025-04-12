import 'package:flutter/material.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portal/core/utils/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// void main() {
//   runApp(MultiProvider(
//     providers: [
//       ChangeNotifierProvider(create: (_) => UserProvider()),
//     ],
//     child: const MyApp()));
// }

Future<void> main() async {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          scaffoldBackgroundColor: background1,
          textTheme: GoogleFonts.dmSansTextTheme(
            Theme.of(context).textTheme,
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
