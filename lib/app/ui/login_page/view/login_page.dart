import 'package:flutter/material.dart';
import 'login_page_state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:triolingo/app/extensions/constants.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  final GoogleSignIn googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: 'your-client_id.apps.googleusercontent.com',
    scopes: googleSignInScopes,
  );

  Future<void> handleGoogleSignIn() async {
    try {
      await googleSignIn.signIn();
    } catch (error) {
      debugPrint(error.toString());
    }
    
  }

  @override
  State<LoginPage> createState() => LoginPageState();
}
