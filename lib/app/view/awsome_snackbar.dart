import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void awsomeSnackbar(
    BuildContext context, String? title, String message, ContentType type) {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.fixed,
    duration: const Duration(milliseconds: 1800),
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title ?? '',
      message: message,
      contentType: type,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      snackBar,
    );
}
