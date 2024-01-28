import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:recipes/screens/Tabs.dart';

final kTheme = ThemeData().copyWith(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: HexColor('#00DFA2'),
  ),
  useMaterial3: true,
  textTheme: GoogleFonts.exo2TextTheme(),
);

final kThemeDark = ThemeData.dark().copyWith(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: HexColor('#FF0060'),
  ),
  useMaterial3: true,
  textTheme: GoogleFonts.exo2TextTheme(),
);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kTheme,
      darkTheme: kThemeDark,
      home: const TabsScreen(),
    );
  }
}
