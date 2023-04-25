import 'package:flutter/material.dart';
import 'package:flutter_tutorials/helper_functions/edit_profile_processing.dart';
import 'package:flutter_tutorials/helper_functions/view_profile_processing.dart';


class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  // text editing controllers to display values for each field
  final TextEditingController _idController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _majorController = TextEditingController();

  final TextEditingController _yearGroupController = TextEditingController();

  final TextEditingController _dateOfBirthController = TextEditingController();

  final TextEditingController _campusResidenceController = TextEditingController();

  final TextEditingController _bestMovieController = TextEditingController();

  final TextEditingController _bestFoodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userID = ModalRoute.of(context)!.settings.arguments as String;
    final editUserDetails = getUserInfo(context, userID);
    
    return Scaffold(
      backgroundColor: const Color(0xFFAD3537),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          width:500,
          height: 750,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 24.0, // Set the font size of the title
                  fontWeight: FontWeight.bold, // Set the font weight of the title
                ),
              ),
              const SizedBox(height: 8.0),
              FutureBuilder<dynamic>(
                future: editUserDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final viewProfile = snapshot.data!;
                    _idController.text = viewProfile[0];
                    return TextFormField(
                      enabled: false,
                      controller: _idController,
                      decoration: const InputDecoration(
                        labelText: 'Student ID',
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 8.0),
              FutureBuilder<dynamic>(
                future: editUserDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final viewProfile = snapshot.data!;
                    _nameController.text = viewProfile[1];
                    return TextFormField(
                      enabled: false,
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 8.0),
              FutureBuilder<dynamic>(
                future: editUserDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final viewProfile = snapshot.data!;
                    _emailController.text = viewProfile[2];
                    return  TextFormField(
                      enabled: false,
                      controller:_emailController,
                      decoration: const InputDecoration(
                          labelText: 'Email'
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),

              const SizedBox(height: 8.0),
              FutureBuilder<dynamic>(
                future: editUserDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final viewProfile = snapshot.data!;
                    _dateOfBirthController.text = viewProfile[5];
                    return  TextFormField(
                      controller: _dateOfBirthController,
                      decoration: const InputDecoration(
                        labelText: 'Date of birth',
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 8.0),
              FutureBuilder<dynamic>(
                future: editUserDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final viewProfile = snapshot.data!;
                    _yearGroupController.text = viewProfile[4];
                    return TextFormField(
                      controller: _yearGroupController,
                      decoration: const InputDecoration(
                        labelText: 'Year Group',
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 8.0),
              FutureBuilder<dynamic>(
                future: editUserDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final viewProfile = snapshot.data!;
                    _majorController.text = viewProfile[3];
                    return TextFormField(
                      controller: _majorController,
                      decoration: const InputDecoration(
                        labelText: 'Major',
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 8.0),
              FutureBuilder<dynamic>(
                future: editUserDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final viewProfile = snapshot.data!;
                    _campusResidenceController.text = viewProfile[6];
                    return TextFormField(

                      controller: _campusResidenceController,
                      decoration: const InputDecoration(
                        labelText: 'Campus Residence',
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 8.0),
              FutureBuilder<dynamic>(
                future: editUserDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final viewProfile = snapshot.data!;
                    _bestFoodController.text = viewProfile[7];
                    return TextFormField(
                      controller: _bestFoodController,
                      decoration: const InputDecoration(
                        labelText: 'Best food',
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 8.0),
              FutureBuilder<dynamic>(
                future: editUserDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final viewProfile = snapshot.data!;
                    _bestMovieController.text = viewProfile[8];
                    return TextFormField(
                      controller: _bestMovieController,
                      decoration: const InputDecoration(
                        labelText: 'Best movie',
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  editUserProfile(context, _idController.text,
                 _majorController.text, _dateOfBirthController.text,
                 _yearGroupController.text, _campusResidenceController.text,
                 _bestFoodController.text, _bestMovieController.text
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20.0), // Set the button size
                ),
                child: const Text(
                  'Edit Profile',
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
