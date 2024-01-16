import 'package:SkillSell/pages/auth/authCheck.dart';
import 'package:SkillSell/pages/auth/loginScreen.dart';
import 'package:SkillSell/pages/auth/registerScreen.dart';
import 'package:SkillSell/pages/home/home.dart';
import 'package:SkillSell/pages/info/property_info_page.dart';

var AppRoutes = {
  "/": (context) => const AuthCheckPage(),
  "/home": (context) => const HomePage(),
  "/property": (context) => const PropertyInfoPage(),
  "/login": (context) => const LoginPage(),
  "/signup": (context) => const RegisterPage(),
};
