import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:csc4360/wrappers/firestore_wrapper.dart';

class AuthWrapper {

  static String get selfUID {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    }
    throw Exception('You cannot get the user\'s UID when not signed in!');
  }

  static bool get signedIn {
    return FirebaseAuth.instance.currentUser != null;
  }

  static bool get anonymous {
    if (signedIn) {
      return FirebaseAuth.instance.currentUser!.isAnonymous;
    }
    return true;  // return true if nobody is logged in?
  }

}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}

Future<void> googleAuth() async {

  // trigger the auth flow?
  final googleAccount = await GoogleSignIn().signIn();

  // obtain the auth details
  final googleAuth = await googleAccount!.authentication;

  // create a new credential set
  final credentials = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // put those credentials into firebase
  await FirebaseAuth.instance.signInWithCredential(credentials);

}

Future<void> anonymousAuth() async {
  await FirebaseAuth.instance.signInAnonymously();
}

