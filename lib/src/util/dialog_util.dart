
import 'package:cinema_mobile/src/custom/progress_hud.dart';
import 'package:flutter/material.dart';

ProgressHUD2 initializeLoading(String message) {
  return  ProgressHUD2(
    backgroundColor: Colors.black12,
    color: Colors.white,
    containerColor: Colors.black87,
    borderRadius: 5.0,
    text: message,
    loading: false,
  );
}

///
/// Function to show a snackbar with a specified message
///
showSnackbarWithMessage(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class DialogUtils {
  static void showAlert(BuildContext context, String message, List<Widget> actions) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
              title: const Text('The Big Screen'),
              content: Text(message),
              actions: actions
          ),
    );
  }
}
