import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:new_fixera/Model/PostAJobAndLeadModel/PostALead.dart';

class PostALeadController extends GetxController {
  final MyRepository repository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));
  var isLoading = true.obs;
  var postALeadList = PostALead().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   fetchPostALeadData();
   
  }

  void fetchPostALeadData() async {
    try {
      isLoading(true);
      var postALeads = await repository.getPostALead();
      print(postALeads);
      if (postALeads != null) {
       postALeadList(postALeads); 
    
      }
    } finally {
      isLoading(false);
    }
  }
}
