import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authservice {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //get user
  User? getUser() {
    return firebaseAuth.currentUser;
  }

  signInWithGoogle() async {
    //begin sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //user cancels google sign in pop up screen
    if(gUser == null) return;

    //obtain auth details from request 
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    //create new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken
    );

    //sign in
    return firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signOut() {
    return firebaseAuth.signOut();
  } 
}