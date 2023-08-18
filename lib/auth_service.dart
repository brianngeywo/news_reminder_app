import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_reminder_app/project_constants.dart';
import 'package:news_reminder_app/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final authResult = await _auth.signInWithCredential(credential);
        return authResult.user;
      }

      return null;
    } catch (error) {
      print("Google Sign-In Error: $error");
      return null;
    }
  }

  // Sign in with Email and Password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final authResult =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
      return authResult.user;
    } catch (error) {
      print("Email/Password Sign-In Error: $error");
      return null;
    }
  }

  // Register with Email and Password
  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    // Authenticate user
    try {
      final authResult =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print("User registered: ${authResult.user}");

      getIt<UserModel>().email = authResult.user!.email!;
      getIt<UserModel>().username = authResult.user!.displayName!;

      return authResult.user;
    } catch (error) {
      print("Email/Password Registration Error: $error");
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
  }
}
