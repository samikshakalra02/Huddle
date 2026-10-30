import 'package:flutter/material.dart';
import 'client.dart';
import 'router.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  runApp(const HuddleApp());
}

class HuddleApp extends StatelessWidget {
  const HuddleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Huddle',
      debugShowCheckedModeBanner: false,
      theme: HuddleTheme.themeData,
      routerConfig: appRouter,
    );
  }
}
