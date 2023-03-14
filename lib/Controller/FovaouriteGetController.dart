import 'package:new_fixera/Model/FavouriteModel/FavouriteGetModel.dart';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class FavouriteGetController extends GetxController {
  final MyRepository repository = MyRepository(apiClient: MyApiClient(httpClient: Client()));
  var isLoading = true.obs;
  var favouriteList = FavouriteGetModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchFavourite();
    super.onInit();
  }

  void fetchFavourite() async {
    try {
      isLoading(true);
      var favourite = await repository.getfavouriteRepo();
      print("what happend");
      print(favourite);
      if (favourite != null) {
         favouriteList(favourite);
         print("favourite Controller");
         print(favouriteList);
      }
    } finally {
      isLoading(false);
    }
  }
}
