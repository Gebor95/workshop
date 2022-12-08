import 'package:flutter/material.dart';
import 'package:workshop/models/user_mode.dart';

class UserProvider with ChangeNotifier{
  var changeName ="";
  var tokensaved = "";
  void setUser(User name){
    changeName = name.user;
    tokensaved = name.token;
    notifyListeners();
  }
}