import 'package:new_fixera/Model/ContractorModel/ContractorPageModel.dart';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';



class ContractorController extends GetxController {

final MyRepository repository = MyRepository(apiClient: MyApiClient(httpClient: Client()));

  var isLoading=true.obs;
  var contractorList=ContractorPageModel().obs;
  var page = 0.obs;
  var scrollControllerContractor = ScrollController();
  List list=[];


  @override
  void onInit() {
    // TODO: implement onInit
   
    super.onInit();

     fetchContractor(page);

      scrollControllerContractor.addListener((){
         if(scrollControllerContractor.position.pixels == scrollControllerContractor.position.maxScrollExtent)
         {
           print("get more data");
          fetchContractor(page);
         }
    });
  }

  void fetchContractor(var page) async {
    page.value=page.value+1;
    try {
      isLoading(true);
      var contractors = await repository.getContractorRepo(page.value);
      print(contractors);
      if(contractors!=null)
      {
        contractorList(contractors); 
        list.addAll(contractors.results.users.data);   

      }
      else {
        print("what the hell is going on");
      }
  }
  catch (e) {
      print(e.toString());
    }
  finally
  {
      isLoading(false);
  }

  }
}