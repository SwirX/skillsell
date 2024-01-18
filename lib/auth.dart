import 'package:SkillSell/db.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<bool> get loggedIn async {
    User? user = await _auth.authStateChanges().first;
    return user != null;
  }

  Future<bool> get isAdmin async {
    User? user = currentUser;
    String? uid = user!.uid;
    List<String> admins = await firestoreDB().getAdmins();
    return admins.contains(uid);
  }

  // Auth Functions

  //Signin
  Future<void> signinWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  //Create Account
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  //Signout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
