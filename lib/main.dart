import 'package:SkillSell/auth.dart';
import 'package:SkillSell/firebase_options.dart';
import 'package:SkillSell/routes/routes.dart';
import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final user = Auth().currentUser;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Directionality(
              textDirection: TextDirection.ltr, child: Text('Error'));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            routes: AppRoutes,
            initialRoute: "/",
            themeMode: ThemeMode.system,
          );
        }

        return const Directionality(
            textDirection: TextDirection.ltr, child: Text('Loading'));
      },
    );
  }
}
