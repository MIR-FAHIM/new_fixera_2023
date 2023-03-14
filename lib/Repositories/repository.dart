import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'dart:io';

import '../main.dart';

class MyRepository {
  final MyApiClient? apiClient;

  MyRepository({@required this.apiClient}) : assert(apiClient != null);

  getSignUpDataRepo() {
    return apiClient!.getSignUpData();
  }

  getHomeRepo() {
    SharedPref.to.prefss!.getString("token");
    SharedPref.to.prefss!.getString("token_type");
    token = SharedPref.to.prefss!.getString("token");
    tokenType = SharedPref.to.prefss!.getString("token_type");
    return apiClient!.getHome();
  }

  getjobsRepo(var page) {
    return apiClient!.getJobs(page);
  }

  getfavouriteRepo() {
    return apiClient!.getFavourite();
  }

  getMarketPlaceRepo(var page) {
    return apiClient!.getMarketPlace(page);
  }

  getContractorRepo(var page) {
    return apiClient!.getContractor(page);
  }

  getVendorSearch(String vendorSearchUrl) {
    return apiClient!.getVendorSearch(vendorSearchUrl);
  }

  getContractorSearch(String contractorSearchUrl) {
    return apiClient!.getContractorSearch(contractorSearchUrl);
  }

  getJobSearch(String jobSearchUrl) {
    return apiClient!.getJobSearch(jobSearchUrl);
  }

  getPostAJob() {
    return apiClient!.getPostAJobData();
  }

  getPostALead() {
    return apiClient!.getPostALeadData();
  }

  Future<Object> postAjob(
      {String? postAjobAndLeadUrl,
      List<File>? fileList,
      Map<String, String>? body}) {
    return apiClient!.postAjob(
        postAjobAndLeadUrl: postAjobAndLeadUrl, fileList: fileList, body: body);
  }

  postPublicPrivateJob(String slug, var jobId, String status) {
    return apiClient!.postPublicPrivateJob(slug, jobId, status);
  }

  postJobDialog(var jobId) {
    return apiClient!.jobDialogPost(jobId);
  }

  postContactorDetailsRepo(var id) {
    return apiClient!.postContractorDetailsJob(id);
  }

  postSignInData(
      String fname,
      String lname,
      String email,
      String phone,
      var locations,
      var role,
      var employees,
      var department,
      var categories,
      var password,
      var initialSignature) {
    return apiClient!.signUpPost(fname, lname, email, phone, locations, role,
        employees, department, categories, password, initialSignature);
  }

  postLoginData(String email, String password) {
    return apiClient!.postLoginData(email, password);
  }

  postOpenJobs(var id) {
    return apiClient!.postOpenJobs(id);
  }

  postFullProfile(var id) {
    return apiClient!.postFullProfile(id);
  }

  postLogOut() {
    return apiClient!.postLogOut();
  }

  forgotEmail(String forgotEmail) {
    return apiClient!.forgotEmail(forgotEmail);
  }

  postEmailExist(String email) {
    return apiClient!.emaiExist(email);
  }

  postFavourite(var id, var fav_id, String saved_employee) {
    return apiClient!.postFavourite(id, fav_id, saved_employee);
  }

  verification(
      {String? forgotVerification,
      int? userId,
      String? type,
      String? email,
      String? phone,
      String? password}) {
    // return apiClient!.verification(
    //     forgotVerification, userId, type, email,phone, password);
    return apiClient!.verification(
        verification: forgotVerification,
        userId: userId,
        type: type,
        email: email,
        phone: phone,
        password: password);
  }

  forgotResetPassword(int userId, String password, String confirmPassword) {
    return apiClient!.forgotResetPassword(userId, password, confirmPassword);
  }

  changeUserPassword(
      String old_password, String password, String password_confirmation) {
    return apiClient!.changePassword(
        old_password, password, password_confirmation);
  }
// getId(id){
//   return apiClient!.getId(id);
// }
// delete(id){
//   return apiClient!.delete(id);
// }
// edit(obj){
//   return apiClient!.edit( obj );
// }
// add(obj){
//     return apiClient!.add( obj );
// }

}
