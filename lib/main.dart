import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/google_text_theme.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp(apiClient: ApiClient()));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.apiClient, super.key});

  final ApiClient apiClient;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiClient>.value(value: apiClient),
        ChangeNotifierProvider<AuthState>(create: (_) => AuthState(apiClient)),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
