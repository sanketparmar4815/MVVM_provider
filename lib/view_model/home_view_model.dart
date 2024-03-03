import 'package:flutter/foundation.dart';
import 'package:mvvm_provider/data/response/api_response.dart';
import 'package:mvvm_provider/model/product_model.dart';
import 'package:mvvm_provider/respository/home_repository.dart';
import 'package:mvvm_provider/utils/utils.dart';

class HomeViewViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  ApiResponse<ProductListModel> productList = ApiResponse.loading();

  setProductList (ApiResponse<ProductListModel> response)
  {
    productList = response;
    notifyListeners();

  }

  Future<void> fetchProductListApi() async {
    setProductList(ApiResponse.loading());
    _myRepo.fetchProductList().then((value) {
      setProductList(ApiResponse.completed(value));


    }).onError((error, stackTrace) {
      setProductList(ApiResponse.error(error.toString()));

      Utils().toastMessage(error.toString());
    });
  }
}
