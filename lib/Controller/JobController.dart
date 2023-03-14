import 'package:new_fixera/Model/JobModel/JobDialogModel.dart';
import 'package:new_fixera/Model/JobModel/JobPageModel.dart';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class JobController extends GetxController {
  final MyRepository repository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));
  var isLoading = true.obs;
  var jobList = JobPageModel().obs;
  var jobDialogModel=JobDialogModel().obs;
  var page = 0.obs;
  var scrollController =ScrollController();
  List list=[];


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   fetchJob(page);
    scrollController.addListener((){
         if(scrollController.position.pixels==scrollController.position.maxScrollExtent)
         {
           print("get more data");
           fetchJob(page);
         }
    });
  }
  

  void fetchJob(var page) async {
    page.value=page.value+1;
    try {
      isLoading(true);
      var jobs = await repository.getjobsRepo(page);
      print(jobs);
      if (jobs != null) {
       jobList(jobs);
       list.addAll(jobs.results.jobs.data);
      
       
      }
    } finally {
      isLoading(false);
    }
  }
}
