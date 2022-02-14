import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? user;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
    storeUserDetailsinSharedPreferences();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}

void storeUserDetailsinSharedPreferences() async {
  final user = FirebaseAuth.instance.currentUser!;
  print('USER CREDENTIALS IS ${user.email!}');
  SharedPreferences loginDetails = await SharedPreferences.getInstance();
  loginDetails.setString('email', user.email!);
  loginDetails.setString('userName', user.displayName!);
  loginDetails.setString('photoURL', user.photoURL!);
}

void getUserDetailsinSharedPreferences() async {
  SharedPreferences loginDetails = await SharedPreferences.getInstance();
  loginDetails.getString('email');
  loginDetails.getString('userName');
  loginDetails.getString('photoURL');
}
