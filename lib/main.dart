import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen/splash_screen.dart';
import 'controller/settings_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsController>(context);

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light, 
        scaffoldBackgroundColor: settings.backgroundColor,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: settings.fontSize,
            color: settings.fontColor,
          ),
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
