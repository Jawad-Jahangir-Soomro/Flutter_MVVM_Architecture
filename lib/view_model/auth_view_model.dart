import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:practicing_mvvm_architecture/repository/auth_repository.dart';
import 'package:practicing_mvvm_architecture/utils/routes/routes_name.dart';
import 'package:practicing_mvvm_architecture/utils/utils.dart';

class AuthViewModel with ChangeNotifier{

  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value){
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async{
    setLoading(true);
    _myRepo.loginApi(data).then((value){
      setLoading(false);
      Utils.flushBarErrorMessages("LogIn Successfully", context);
      Navigator.pushNamed(context, RoutesName.home);
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setLoading(false);
      if(kDebugMode){
        Utils.flushBarErrorMessages(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<void> registerApi(dynamic data, BuildContext context) async{
    setSignUpLoading(true);
    _myRepo.registerApi(data).then((value){
      setSignUpLoading(false);
      Utils.flushBarErrorMessages("SignUp Successfully", context);
      Navigator.pushNamed(context, RoutesName.home);
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setSignUpLoading(false);
      if(kDebugMode){
        Utils.flushBarErrorMessages(error.toString(), context);
        print(error.toString());
      }
    });
  }

}