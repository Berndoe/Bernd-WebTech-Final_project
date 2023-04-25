import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:http/http.dart' as http;
import '../login.dart';

Future<void> createUser(BuildContext context, final studentID, final name, final major,
                        final dateOfBirth, final yearGroup, final campusResidence,
                        final bestFood,final bestMovie,final password, final email) async {


  final body = {
    "student_id":studentID,
    "name":name,
    "major":major,
    "date_of_birth":dateOfBirth,
    "year_group":yearGroup,
    "campus_residence":campusResidence,
    "best_food":bestFood,
    "best_movie": bestMovie,
    "password": password,
    "email": email,
  };

  const createUser = 'https://us-central1-social-media-api-383221.cloudfunctions.net/social-media-api/users';
  final uri = Uri.parse(createUser);
  final response = await http.post(
    uri,
    body: jsonEncode(body),
    headers: {'Content-Type': 'application/json'},
  );
  if(response.statusCode == 201) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        width: 200,
        text: 'Successfully created user!',
        onConfirmBtnTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginForm()), // Navigate to Login page on clicking okay
          );
        }
    );

  }
  else {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      width: 200,
      title: 'Oops...',
      text: 'The user already exists',
    );

  }



}