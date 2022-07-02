import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';


class AuthProvider with ChangeNotifier {
  final FirebaseAuth _fbauth = FirebaseAuth.instance;

  Future<User?> auth() async {
    try {
      await GoogleSignIn().signOut();
      // melakukan login google disimpan ke variabel gsign
      final gsign = await GoogleSignIn().signIn();
      // mendapatkan informasi autentifikas dari gsign
      final gauth = await gsign?.authentication;
      // mendapatkan informasi kredensial dari GoogleAuthProvider
      final kredensial = GoogleAuthProvider.credential(
        accessToken: gauth?.accessToken,
        idToken: gauth?.idToken,
      );
      // melakukan signin berdasarkan informasi kredensial
      await _fbauth.signInWithCredential(kredensial);
      notifyListeners();
    } catch (e) {
      print("error melakukan auth : $e");
    }
    return _fbauth.currentUser;
  }
}