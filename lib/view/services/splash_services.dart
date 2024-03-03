


import 'package:flutter/material.dart';
import 'package:mvvm_provider/model/user_model.dart';
import 'package:mvvm_provider/utils/routes/routes_name.dart';
import 'package:mvvm_provider/utils/utils.dart';
import 'package:mvvm_provider/view_model/user_view_model.dart';

class SplashServices
{
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async
  {
    getUserData().then((value) async {

      if(value.token == null || value.token!.isEmpty )
        {
          await Future.delayed(const Duration(seconds: 3));
          Navigator.pushNamed(context, RoutesName.login);

        }
      else{
        await Future.delayed(const Duration(seconds: 3));

        Navigator.pushNamed(context, RoutesName.home);

      }
    }).onError((error, stackTrace){
     Utils().toastMessage(error.toString());
    });
  }
 }