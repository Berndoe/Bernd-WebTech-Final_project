import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'create_profile.dart';
import 'helper_functions/login_authentication.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _CreateLoginFormState();
}

  class _CreateLoginFormState extends State<LoginForm> {

    // controllers for the login form details
    TextEditingController studentID = TextEditingController();
    TextEditingController password = TextEditingController();

    @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: const Color(0xFFAD3537),

        body: Column(

        children: [
          const SizedBox(height: 240),
          const Text(
          'TEATIME',
          style: TextStyle(
            fontSize: 40.0,

            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16.0),
        Center(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              // Set the border radius
            ),
            width: 500,
            height: 300,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24.0, // Set the font size of the title
                    fontWeight: FontWeight
                        .bold, // Set the font weight of the title
                  ),
                ),
                const SizedBox(height: 5.0),
                RichText(
                  text: TextSpan(
                    children: [

                      const TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 15.0, // Set the font size of the title

                        ),
                      ),
                      TextSpan(
                        text: "Sign up",
                        style: const TextStyle(
                          fontSize: 15.0,
                          // Set the font size of the hyperlink text
                          color: Colors
                              .blue, // Set the color of the hyperlink text
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (
                                  context) => const CreateProfileForm()), // Navigate to Create Profile Page
                            );
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: studentID,
                  decoration: const InputDecoration(
                    labelText: 'Enter Student ID',
                  ),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Enter password',
                  ),
                ),
                const SizedBox(height: 16.0),
                const SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: () {
                      login(context, studentID.text, password.text);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(
                          20.0, 15.0, 20.0, 20.0), // Set the button size
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18.0),
                    )
                ),
              ],
            ),
          ),
        ),
      ],
    )
  );
  }
}

