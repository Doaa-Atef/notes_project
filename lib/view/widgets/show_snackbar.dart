import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String title,

  String actionLabel = "Undo",
  required VoidCallback onPressed,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
      backgroundColor: Colors.black,
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: actionLabel,
        onPressed: onPressed,
        textColor: Colors.white,
      ),
    ),
  );
}
