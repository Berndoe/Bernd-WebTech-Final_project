import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:http/http.dart' as http;

Future<void> createPost(BuildContext context, final email, final content) async {

  final body = {
    "email": email,
    "content": content
  };

  const createUser = 'https://us-central1-social-media-api-383221.cloudfunctions.net/social-media-api/posts';
  final uri = Uri.parse(createUser);
  final response = await http.post(
    uri,
    body: jsonEncode(body),
    headers: {'Content-Type': 'application/json'},
  );
  if(response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Posting....'),
      ),

    );
  }
  else {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      width: 200,
      title: 'Oops...',
      text: 'Please fill in all the details',
    );
  }
}