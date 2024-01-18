import 'package:SkillSell/pages/auth/authCheck.dart';
import 'package:SkillSell/pages/auth/loginScreen.dart';
import 'package:SkillSell/pages/auth/registerScreen.dart';
import 'package:SkillSell/pages/home/home.dart';

var AppRoutes = {
  "/": (context) => const AuthCheckPage(),
  "/home": (context) => const HomePage(),
  "/login": (context) => const LoginPage(),
  "/signup": (context) => const RegisterPage(),
};
