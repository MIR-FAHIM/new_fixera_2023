import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:new_fixera/Model/PostAJobAndLeadModel/PostAJob.dart';

class PostAJobController extends GetxController {
  final MyRepository repository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));
  var isLoading = true.obs;
  var postAjobList = PostAJobModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   fetchPostAJobData();
   
  }

  void fetchPostAJobData() async {
    try {
      isLoading(true);
      var postAjobs = await repository.getPostAJob();
      print(postAjobs);
      if (postAjobs != null) {
       postAjobList(postAjobs); 
    
      }
    } finally {
      isLoading(false);
    }
  }
}
