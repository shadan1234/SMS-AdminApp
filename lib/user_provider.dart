
import 'package:flutter/material.dart';
import 'package:sms_admin/models/user.dart';


class UserProvider extends ChangeNotifier{
  User _user=User(id:'' ,name: '', password: '', role: '', token: '') ;
  User get user=>_user;

  void setUser(String user){
    _user=User.fromJson(user);
    notifyListeners();
  }
  void setUserFromModel(User user){
    _user=user;
    notifyListeners();
  }
}