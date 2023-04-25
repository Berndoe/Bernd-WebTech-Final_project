import 'package:flutter/material.dart';
import 'package:flutter_tutorials/feed_page.dart';
import 'package:flutter_tutorials/helper_functions/view_profile_processing.dart';
import 'edit_profile.dart';


class MyProfileForm extends StatefulWidget {
  const MyProfileForm({super.key});

  @override
  State<MyProfileForm> createState() => _MyProfileFormState();
}

class _MyProfileFormState extends State<MyProfileForm> {
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
    final viewUserDetails = getUserInfo(context, userID);

    return Scaffold(
      backgroundColor: const Color(0xFFAD3537),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          width:500,
          height: 800,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 24.0, // Set the font size of the title
                  fontWeight: FontWeight.bold, // Set the font weight of the title
                ),
              ),
              const SizedBox(height: 8.0),
              FutureBuilder<dynamic>(
                future: viewUserDetails,
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
                future: viewUserDetails,
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
                future: viewUserDetails,
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
                future: viewUserDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final viewProfile = snapshot.data!;
                    _dateOfBirthController.text = viewProfile[5];
                    return  TextFormField(
                      enabled: false,
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
                future: viewUserDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final viewProfile = snapshot.data!;
                    _yearGroupController.text = viewProfile[4];
                    return TextFormField(
                      enabled: false,
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
                future: viewUserDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final viewProfile = snapshot.data!;
                    _majorController.text = viewProfile[3];
                    return TextFormField(
                      enabled: false,
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
                future: viewUserDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final viewProfile = snapshot.data!;
                    _campusResidenceController.text = viewProfile[6];
                    return TextFormField(
                      enabled: false,
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
                future: viewUserDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final viewProfile = snapshot.data!;
                    _bestFoodController.text = viewProfile[7];
                    return TextFormField(
                      enabled: false,
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
                future: viewUserDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final viewProfile = snapshot.data!;
                    _bestMovieController.text = viewProfile[8];
                    return TextFormField(
                      enabled: false,
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
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      child: const Text('Back'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (
                                context) => const FeedPage(),
                              settings: RouteSettings(
                                arguments: userID,
                              ), // Navigate to the profile page on clicking okay
                            ));
                      },
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      child: const Text('Edit Profile'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileForm(),
                            settings: RouteSettings(
                              arguments: userID,
                            ), // Navigate to the edit profile page on clicking edit
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
