import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

/// TextTheme JetBrains Mono (versi material_ui) berbasis tipografi Material 3 gelap.
TextTheme jetBrainsMonoTextTheme() {
  final base = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
  ).textTheme;

  TextStyle? f(TextStyle? s) =>
      s == null ? null : GoogleFonts.jetBrainsMono(textStyle: s);

  return TextTheme(
    displayLarge: f(base.displayLarge),
    displayMedium: f(base.displayMedium),
    displaySmall: f(base.displaySmall),
    headlineLarge: f(base.headlineLarge),
    headlineMedium: f(base.headlineMedium),
    headlineSmall: f(base.headlineSmall),
    titleLarge: f(base.titleLarge),
    titleMedium: f(base.titleMedium),
    titleSmall: f(base.titleSmall),
    bodyLarge: f(base.bodyLarge),
    bodyMedium: f(base.bodyMedium),
    bodySmall: f(base.bodySmall),
    labelLarge: f(base.labelLarge),
    labelMedium: f(base.labelMedium),
    labelSmall: f(base.labelSmall),
  );
}