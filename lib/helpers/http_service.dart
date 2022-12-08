
import 'package:flutter/material.dart';

class HttpService{
  static const String baseurl = "https://emmi-softwaretrack.online/api/";

  static const String register = "${baseurl}register";
  static const String login = "${baseurl}login";
  static const String blog = "${baseurl}blogs";

  void showMessage(String message, BuildContext context){
    var snackbar = SnackBar(content: Text(message));

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}