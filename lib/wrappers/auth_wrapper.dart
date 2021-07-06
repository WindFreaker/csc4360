import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

String getUserID() {
  return FirebaseAuth.instance.currentUser!.uid;
}

bool signedInCheck() {
  return FirebaseAuth.instance.currentUser == null;
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}

Future<void> signUpEmail({required email, required password}) async {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
}

Future<void> signInEmail({required email, required password}) async {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
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

