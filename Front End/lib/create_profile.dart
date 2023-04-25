import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorials/login.dart';
import 'helper_functions/create_profile_processing.dart';

class CreateProfileForm extends StatefulWidget {
  const CreateProfileForm({super.key});

  @override
  State<CreateProfileForm> createState() => _CreateProfileFormState();
}

class _CreateProfileFormState extends State<CreateProfileForm> {
  // adding text editing controllers for each field
  TextEditingController idController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController majorController = TextEditingController();

  TextEditingController yearGroupController = TextEditingController();

  TextEditingController dateOfBirthController = TextEditingController();

  TextEditingController campusResidenceController = TextEditingController();

  TextEditingController bestMovieController = TextEditingController();

  TextEditingController bestFoodController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAD3537),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          width:500,
          height: 810,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Create Profile',
                style: TextStyle(
                  fontSize: 24.0, // Set the font size of the title
                  fontWeight: FontWeight.bold, // Set the font weight of the title
                ),
              ),
              const SizedBox(height: 8.0),
              RichText(
                text: TextSpan(
                  children: [

                    const TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        fontSize: 15.0, // Set the font size of the title

                      ),
                    ),
                    TextSpan(
                      text: "Sign in",
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
                                context) => const LoginForm()), // Navigate to Create Profile Page
                          );
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2.0),
              TextFormField(
                controller: idController,
                decoration: const InputDecoration(
                  labelText: 'Enter Student ID',
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Enter name',
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller:emailController,
                decoration: const InputDecoration(
                  labelText: 'Enter email'
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: majorController,
                decoration: const InputDecoration(
                  labelText: 'Enter major',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller:yearGroupController,
                decoration: const InputDecoration(
                  labelText: 'Enter year group',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: dateOfBirthController,
                decoration: const InputDecoration(
                  labelText: 'Enter date of birth (dd/MM/yyyy)',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: campusResidenceController,
                decoration: const InputDecoration(
                  labelText: 'Enter campus residence (On-campus/Off-campus)',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: bestFoodController,
                decoration: const InputDecoration(
                  labelText: 'Enter best food',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: bestMovieController,
                decoration: const InputDecoration(
                  labelText: 'Enter best movie',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Enter password',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  createUser(context, idController.text, nameController.text,
                  majorController.text,dateOfBirthController.text,yearGroupController.text,
                  campusResidenceController.text, bestFoodController.text,
                  bestMovieController.text, passwordController.text,emailController.text
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(25.0), // Set the button size
                ),
                child: const Text(
                    'Create Profile',
                    style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
