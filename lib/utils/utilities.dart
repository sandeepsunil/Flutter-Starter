import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static final GlobalKey<NavigatorState> navigatorkey =
      new GlobalKey<NavigatorState>();

  static void showToast({
    required String msg,
    ToastGravity pos = ToastGravity.CENTER,
    Toast length = Toast.LENGTH_LONG,
  }) {
    print(Toast.LENGTH_LONG.runtimeType);
    Fluttertoast.showToast(
      msg: msg,
      toastLength: length,
      gravity: pos,
      timeInSecForIosWeb: 3,
    );
  }

  static showSnackBar({
    required BuildContext context,
    String text = '',
    String label = 'OK',
    required Function() onPress,
    SnackBarBehavior snackBarBehavior = SnackBarBehavior.fixed,
    Color color = Colors.black,
    Color labelColor = Colors.white,
  }) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(text),
        behavior: snackBarBehavior,
        backgroundColor: color,
        action: SnackBarAction(
          label: label,
          textColor: labelColor,
          onPressed: onPress,
        ),
      ));
}
