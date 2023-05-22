import 'package:practicing_mvvm_architecture/data/network/BaseApiService.dart';
import 'package:practicing_mvvm_architecture/data/network/NetworkApiService.dart';
import 'package:practicing_mvvm_architecture/res/app_url.dart';

class AuthRepository{
  BaseApiServices _apiService = NetworkApiService();

  Future<dynamic> loginApi(dynamic data)async{
    try{
      dynamic response = await _apiService.getPostApiResponse(AppUrl.loginEndPoint, data);
      return response;
    }
    catch(e){
      throw e;
    }
  }

  Future<dynamic> registerApi(dynamic data)async{
    try{
      dynamic response = await _apiService.getPostApiResponse(AppUrl.registerApiEndPoint, data);
      return response;
    }
    catch(e){
      throw e;
    }
  }

}