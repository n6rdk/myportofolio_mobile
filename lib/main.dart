import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/google_text_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPortfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        textTheme: jetBrainsMonoTextTheme().apply(
          bodyColor: const Color(0xFFE6F1FF),
          displayColor: const Color(0xFFE6F1FF),
        ),
        scaffoldBackgroundColor: const Color(0xFF071122),
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFF7DD987),
          onPrimary: Color(0xFF071122),
          secondary: Color(0xFF335682),
          onSecondary: Color(0xFFE6F1FF),
          tertiary: Color(0xFFCC6B91),
          onTertiary: Color(0xFF071122),
          error: Color(0xFFE03426),
          onError: Color(0xFFE6F1FF),
          surface: Color(0xFF071122),
          onSurface: Color(0xFFE6F1FF),
          surfaceContainer: Color(0xFF121E3A),
          onSurfaceVariant: Color(0xFF6B7A8F),
          outline: Color(0xFF6B7A8F),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}
