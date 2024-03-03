import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_provider/respository/auth_repository.dart';
import 'package:mvvm_provider/utils/routes/routes_name.dart';
import 'package:mvvm_provider/utils/utils.dart';
import 'package:mvvm_provider/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  bool _isLoding = false;

  bool get isLoding => _isLoding;

  setisLoding(bool value) {
    _isLoding = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setisLoding(true);
final userPrefrence = Provider.of<UserViewModel>(context,listen:false);
    _myRepo.loginAPi(data).then((value) {
userPrefrence.saveUser(value);
      Utils().flushBarErrorMessage("login Successfully", context);
      setisLoding(false);
      Navigator.pushNamed(context, RoutesName.home);

      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setisLoding(false);

      Utils().toastMessage(error.toString());
    });
  }
  Future<void> registerApi(dynamic data, BuildContext context) async {
    setisLoding(true);
    _myRepo.registerAPi(data).then((value) {
      Utils().flushBarErrorMessage("SignUp Successfully", context);
      setisLoding(false);
      Navigator.pushNamed(context, RoutesName.home);

      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setisLoding(false);

      Utils().toastMessage(error.toString());
    });
  }
}
