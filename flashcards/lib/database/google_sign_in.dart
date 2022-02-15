// import 'dart:ffi';
// import 'dart:typed_data';

// import 'package:dio/dio.dart';
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
  // Uint8 u = user.photoURL!;
  // var response = await Dio()
  //     .get(user.photoURL!, options: Options(responseType: ResponseType.bytes));
  // Uint8List a = Uint8List.fromList(response.data);
  // String s = String.fromCharCodes(a); // ÿØÿà

  // print('USER CREDENTIALS ${s} and ${a}');
  SharedPreferences loginDetails = await SharedPreferences.getInstance();
  loginDetails.setString('email', user.email!);
  loginDetails.setString('displayName', user.displayName!);
  loginDetails.setString('photoURL', user.photoURL!);
}
