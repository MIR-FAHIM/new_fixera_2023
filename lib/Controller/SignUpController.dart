
import 'package:new_fixera/Model/SignUpModel/SignUpModel.dart';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class SignUpController extends GetxController {

final MyRepository repository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));
  var isLoading = true.obs;
  var signUpList = SignUpModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchSignUp();
    super.onInit();
  }

  void fetchSignUp() async {
    try {
      isLoading(true);
      var signUpData = await repository.getSignUpDataRepo();
      if (signUpData != null) {
            signUpList(signUpData);
      }
    } finally {
      isLoading(false);
    }
  }
}