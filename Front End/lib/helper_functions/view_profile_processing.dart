import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

Future<List<dynamic>> getUserInfo(BuildContext context, final iD) async {
  final getUserDetails = 'https://us-central1-social-media-api-383221.cloudfunctions.net/social-media-api/users/$iD';
  final uri = Uri.parse(getUserDetails);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    final user = jsonDecode(response.body);
    List<String> userDetails = [
      user['student_id'],
      user['name'],
      user['email'],
      user['major'],
      user['year_group'],
      user['date_of_birth'],
      user['campus_residence'],
      user['best_food'],
      user['best_movie'],
    ];
    return userDetails;
  }
  else {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Oops...',
      text: 'The user could not be found',
    );
    return [];
  }
}
