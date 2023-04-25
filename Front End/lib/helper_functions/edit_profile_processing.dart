import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tutorials/my_profile.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:http/http.dart' as http;

Future<void> editUserProfile(BuildContext context, final studentID, final major,
    final dateOfBirth, final yearGroup, final campusResidence,
    final bestFood,final bestMovie) async {

  final body = {
    "major":major,
    "date_of_birth":dateOfBirth,
    "year_group":yearGroup,
    "campus_residence":campusResidence,
    "best_food":bestFood,
    "best_movie": bestMovie,
  };

  final editUser = 'https://us-central1-social-media-api-383221.cloudfunctions.net/social-media-api/users/$studentID';
  final uri = Uri.parse(editUser);
  final response = await http.patch(
    uri,
    body: jsonEncode(body),
    headers: {'Content-Type': 'application/json'},
  );

  if(response.statusCode == 200) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        width: 200,
        text: 'Successfully edited profile!',
        onConfirmBtnTap: () async {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (
                  context) => const MyProfileForm(),
                settings: RouteSettings(
                  arguments: studentID,
                ), // Navigate to the profile page on clicking okay
              ));
        }
    );
  }
  else {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      width: 200,
      title: 'Oops...',
      text: 'An error occurred. Please try again later',
    );
  }
}