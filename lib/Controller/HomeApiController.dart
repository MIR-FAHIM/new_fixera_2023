import 'package:new_fixera/Model/HomePageModel/HomeModel.dart';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../main.dart';


class HomeApiController extends GetxController {

 final MyRepository repository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));
  var isLoading = true.obs;
  var homeApiList = HomeModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit


    fetchHomeApi();
    super.onInit();
  }

  void fetchHomeApi() async {
    SharedPref.to.prefss!.getString("token");
    SharedPref.to.prefss!.getString("token_type");
    token = SharedPref.to.prefss!.getString("token");
    tokenType = SharedPref.to.prefss!.getString("token_type");
    try {
      isLoading(true);
      var homeApi = await repository.getHomeRepo();
      if (homeApi != null) {
        homeApiList(homeApi);
      }
    } finally {
      isLoading(false);
    }
  }
}