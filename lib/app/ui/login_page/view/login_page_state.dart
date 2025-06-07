import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../app.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/core.dart';

class LoginPageState extends State<LoginPage> {
  //GoogleSignInAccount? _currentUser;
  //bool _isAuthorized = false; // has granted permissions?

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    widget.googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      bool isAuthorized = account != null;

      if (kIsWeb && account != null) {
        isAuthorized =
            await widget.googleSignIn.canAccessScopes(googleSignInScopes);
      }

      setState(() {
        //_currentUser = account;
        //_isAuthorized = isAuthorized;
      });

      if (isAuthorized) {
        // TODO: call the API
        //unawaited();
      }
    });

    // In the web, _googleSignIn.signInSilently() triggers the One Tap UX.
    //
    // It is recommended by Google Identity Services to render both the One Tap UX
    // and the Google Sign In button together to "reduce friction and improve
    // sign-in rates" ([docs](https://developers.google.com/identity/gsi/web/guides/display-button#html)).
    widget.googleSignIn.signInSilently();

    setCredentials().then((_) => _onLoginPressed(fromUser: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            const Text(
              'Вітаємо у\nTriolingo',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            _buildTextField(
                label: labelEmail,
                hintText: hintEmail,
                textEditingController: emailController),
            const SizedBox(height: 20),
            _buildTextField(
                label: labelPassword,
                hintText: labelEmail,
                obscureText: true,
                textEditingController: passwordController),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {_onLoginPressed(fromUser: true);},
                child: const Text(
                  textEnter,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(child: Text(textOr)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  widget.handleGoogleSignIn();
                },
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset(
                        'assets/icons/ic_google_logo.svg',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: const Text(
                        textSignInWithGoogle,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: RichText(
                text: TextSpan(
                  text: textQuestionNoAccount,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    TextSpan(
                      text: textRegister,
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamed('/registration');
                        },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    bool obscureText = false,
    required TextEditingController textEditingController,
  }) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      controller: textEditingController,
    );
  }

  void _onLoginPressed({required bool fromUser}) {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      coreApi
          .loginRequest(
              email: emailController.text, password: passwordController.text)
          .then((response) {
        if (response is Success<LoginResponse>) {
          appSettings.setUserEmail(email: emailController.text);
          appSettings.setUserPassword(password: passwordController.text);
          if (context.mounted) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/home', (Route<dynamic> route) => false);
          }
        } else if (response is Error) {
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(response.meta.message ?? textLoginError),
              ),
            );
          }
        }
      });
    } else {
      if (fromUser) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(textPleaseEnterCredentials),
          ),
        );
      }
    }
  }

  Future setCredentials() async {
    emailController.text = (await appSettings.getUserEmail()) ?? '';
    passwordController.text = (await appSettings.getUserPassword()) ?? '';
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
