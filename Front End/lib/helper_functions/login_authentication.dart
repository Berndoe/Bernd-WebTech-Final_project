import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../feed_page.dart';

Future<void> login(BuildContext context, final iD, final passcode) async {
  final getUserDetails = 'https://us-central1-social-media-api-383221.cloudfunctions.net/social-media-api/users/$iD';
  final uri = Uri.parse(getUserDetails);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);

    if (iD == json['student_id'] && passcode == json['password']) {
      // look for a way for it to close so that when you go back to the page it doesn't still show
      QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          width: 200,
          text: 'Successfully logged in!',
          onConfirmBtnTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (
                  context) => const FeedPage(),
                  settings: RouteSettings(
                    arguments: iD,
                  )), // Navigate to the feed page on clicking okay
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
        text: 'Incorrect ID or password. Please try again',
      );
    }
  }
  else {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      width: 200,
      title: 'Oops...',
      text: 'Incorrect ID or password. Please try again',
    );
  }
}