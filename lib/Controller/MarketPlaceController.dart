import 'package:new_fixera/Model/MarketPageModel/VendorPageModel.dart';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class MarketPlaceController extends GetxController {
  final MyRepository repository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));
  var isLoading = true.obs;
  var marketPlaceList = VendorPageModel().obs;
  var page = 0.obs;
  var scrollController = ScrollController();
  List list = [];
  @override
  void onInit() {
    // TODO: implement onInit
    fetchMarketPlace(page);
    super.onInit();
     scrollController.addListener((){
         if(scrollController.position.pixels==scrollController.position.maxScrollExtent)
         {
           print("get more data");
         fetchMarketPlace(page);
         }
    });
  }

  void fetchMarketPlace(var page) async {
    page.value=page.value+1;
    try {
      isLoading(true);
      var markets = await repository.getMarketPlaceRepo(page);
      if (markets != null) {
        marketPlaceList(markets);
        list.addAll(markets.results.users.data);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
