import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:triolingo/app/app.dart';
import 'package:triolingo/core/core.dart';

class RegistrationPageState extends State<RegistrationPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

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
              textQuestionNewOne,
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
                hintText: hintPassword,
                obscureText: true,
                textEditingController: passwordController),
            const SizedBox(height: 20),
            _buildTextField(
                label: labelRepeatPassword,
                hintText: hintRepeatPassword,
                obscureText: true,
                textEditingController: repeatPasswordController),
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
                onPressed: () {
                  if (passwordController.text ==
                      repeatPasswordController.text) {
                    coreApi
                        .registrationRequest(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((response) => {
                              if (response is Success<RegistrationResponse>)
                                {
                                  if (context.mounted) Navigator.of(context).pushNamed('/home')
                                }
                              else if (response is Error)
                                if (context.mounted)
                                  {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: Text(response.meta.message ??
                                            textRegistrationError),
                                      ),
                                    )
                                  }
                            });
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text(textPasswordsAreDifferent),
                      ),
                    );
                  }
                },
                child: const Text(
                  textRegister,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: RichText(
                text: TextSpan(
                  text: textQuestionHaveAccount,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    TextSpan(
                      text: textEnter,
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pop();
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

  Widget _buildTextField(
      {required String label,
      required String hintText,
      bool obscureText = false,
      required TextEditingController textEditingController}) {
    return TextField(
      controller: textEditingController,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
