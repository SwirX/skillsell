import 'package:SkillSell/auth.dart';
import 'package:SkillSell/pages/auth/loginScreen.dart';
import 'package:SkillSell/pages/home/home.dart';
import 'package:flutter/material.dart';

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({super.key});

  @override
  State<AuthCheckPage> createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
