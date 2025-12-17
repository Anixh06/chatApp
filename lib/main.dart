import 'package:chat_app/services/auth/auth_gate.dart';
import 'package:chat_app/services/theme_provider.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'services/auth/login_or_register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AuthGate(),
          theme: themeProvider.currentTheme,
        );  
      },
    );
  }
}
