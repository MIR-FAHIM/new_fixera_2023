import 'package:new_fixera/Model/ContractorModel/ContractorSearchModel.dart';
import 'package:new_fixera/Model/JobModel/jobSearchModel.dart';
import 'package:new_fixera/Model/MarketPageModel/vendorSearchModel.dart';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:new_fixera/main.dart';

class SearchController extends GetxController {
  final MyRepository repository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));
  var isLoading1 = true.obs;
  var isLoading2 = true.obs;
  var isLoadign3 = true.obs;
  var vendorSearchList = VendorSearchModel().obs;
  var contractorSearchList = ContractorSearchModel().obs;
  var jobSearchList = JobSearchModel().obs;
  var isData = true.obs;
  var page = 0.obs;
  List list = [];
  var scrollControllerjobs = ScrollController();
  var scrollControllerMarketPlace = ScrollController();
  var scrollControllerContractor = ScrollController();

  @override
  void onInit() {
    // TODO: implement onInit
    // fetchMarketPlace();
    super.onInit();
    scrollControllerjobs.addListener(() {
      if (scrollControllerjobs.position.pixels ==
          scrollControllerjobs.position.maxScrollExtent) {
        print("get more data");
        String jobSearchurl = prefs!.getString("jobPageUrl")!;
        fetchJobSearch(jobSearchurl);
      }
    });

    scrollControllerMarketPlace.addListener(() {
      if (scrollControllerMarketPlace.position.pixels ==
          scrollControllerMarketPlace.position.maxScrollExtent) {
        print("get more data");
        String marketPlaceSearchurl = prefs!.getString("marketPlaceSearchUrl")!;
        fetchVendorSearch(marketPlaceSearchurl);
      }
    });
    scrollControllerContractor.addListener(() {
      if (scrollControllerContractor.position.pixels ==
          scrollControllerContractor.position.maxScrollExtent) {
        print("get more data");
        String contractorSearchUrl = prefs!.getString("contractorSearchUrl")!;
        fetchContractorSearch(contractorSearchUrl);
      }
    });
  }

  //vendorSearach Controller
  void fetchVendorSearch(String vendorSearchurl) async {
    try {
      page.value = page.value + 1;
      isLoading1(true);
      String url = vendorSearchurl + "&page=${page.value}";
      var vendors = await repository.getVendorSearch(url);
      if (vendors != null) {
        // vendorSearchList(vendors);
        isData.value = true;
        list.addAll(vendors.results.users.data);
      } else {
        isData.value = false;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading1(false);
    }
  }

  //controllerSearch Controller
  void fetchContractorSearch(String contractorSearchurl) async {
    try {
      page.value = page.value + 1;
      isLoading2(true);
      String url = contractorSearchurl + "&page=${page.value}";
      var contractors = await repository.getContractorSearch(url);
      if (contractors != null) {
        print("data");
        isData.value = true;
        //contractorSearchList(contractors);
        list.addAll(contractors.results.users.data);
      } else {
        isData.value = false;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading2(false);
    }
  }

  //jobSearch Controller
  void fetchJobSearch(String jobSearchurl) async {
    try {
      page.value = page.value + 1;
      isLoadign3(true);
      print("searchJobPage");
      print(page.value);
      String url = jobSearchurl + "&page=${page.value}";
      var jobs = await repository.getJobSearch(url);
      if (jobs != null) {
        // jobSearchList(jobs);
        print("data");
        isData.value = true;
        list.addAll(jobs.results.jobs.data);
        //update();
      } else {
        print("no Data");
        isData.value = false;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoadign3(false);
    }
  }
}
