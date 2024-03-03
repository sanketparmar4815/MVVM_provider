import 'package:mvvm_provider/data/network/BaseApiServices.dart';
import 'package:mvvm_provider/data/network/NetworkApiServices.dart';
import 'package:mvvm_provider/model/product_model.dart';
import 'package:mvvm_provider/res/app_url.dart';

class HomeRepository
{
  BaseApiServices _apiServices = NetworkApiServices();

  Future<ProductListModel> fetchProductList() async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(AppUrl.productlist);
      return response = ProductListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}