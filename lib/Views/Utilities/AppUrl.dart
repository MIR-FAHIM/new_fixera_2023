import 'package:new_fixera/main.dart';

String baseUrl = "https://www.fix-era.com/api/v1";
//String baseUrl = "https://www.fix-era.com/api/v1";

//http://18.217.130.75

class AppUrl {
  static String aboutUs = "$baseUrl/page/about-us";
  static String purchasePackageFromAppStore =
      "$baseUrl/page/purchaseFromAppStore?";
  static String purchaseCreditFromAppStore =
      "$baseUrl/page/creditPurchaseFromAppStore";
  static String contactSupport = "$baseUrl/page/privacy-policy";
  static String rateThisApp = "https://play.google.com/store/apps";
  static String jobByCategories = "$baseUrl/list/get-categories";
  static String loginUrl = "$baseUrl/login";
  static String logOutUrl = "$baseUrl/logout";
  static String forgotEmail = "$baseUrl/reset-email";
  static String forgotVerifyOtp = "$baseUrl/verify-otp";
  static String forgotResetPass = "$baseUrl/reset-password";
  static String jobPageUrl = "$baseUrl/search-results?type=job";
  static String vendorPageUrl = "$baseUrl/search-results?type=vendor";
  static String contractorPageUrl = "$baseUrl/search-results?type=contractor";
  static String homePageUrl = "$baseUrl/contractor/home";
  static String signUpGetUrl = "$baseUrl/registration/data";
  static String emailExistUrl = "$baseUrl/email/check";
  static String signUpPostUrl = "$baseUrl/register";
  static String favouriteUrl = "$baseUrl/user-favourite";
  static String favouritGetUrl = "$baseUrl/user-favourite-lists";
  static String openJobsUrl = "$baseUrl/jobListsByUser";
  static String fullProfileUrl = "$baseUrl/vendor/profile";
  static String contractorDetailsUrl = "$baseUrl/contractor/profile";
  static String searchUrl = "$baseUrl/search-results";
  static String jobDialogUrl = "$baseUrl/check-job-payment-status";
  static String privatePublicJobsUrl = "$baseUrl/lead-details-payment-process";
  static String getPostaJobUrl = "$baseUrl/post-job";
  static String postaJobUrl = "$baseUrl/post-job?";
  static String changePassword = "$baseUrl/profile/settings/change-password";

  ///webView
  static String contractorInvoiceUrl =
      "$baseUrl/webview/contractor/package/invoice?token=";
  static String vendorInvoiceUrl =
      "$baseUrl/webview/vendor/package/invoice?token=";

  static String contractorPackagesUrl =
      "$baseUrl/webview/package-lists/contractor?token=";
  static String vendorPackagesUrl =
      "$baseUrl/webview/package-lists/vendor?token=";
  static String contractorProposalsUrl = "$baseUrl/webview/proposals?token=";
  static String buyCreditUrl = "$baseUrl/webview/credit-purchase?token=";
  static String creditReport =
      "$baseUrl/webview/creditPurchaseHistoryApple?token=";

  static String privacyPolicyUrl =
      "https://fix-era.com/page/privacy-policy?token=";
  static String howItWorksUrl = "https://fix-era.com/page/how-it-works?token=";
  static String messageCenterUrl = "$baseUrl/webview/message-center?token=";
  static String transferHistoryUrl =
      "$baseUrl/webview/${userMap!["user_info"]["role_name"]}/job/tranfer_payment/summary?token=";
  static String incomeHistoryUrl =
      "$baseUrl/webview/contractor/income/history?token=";
  static String withdrawUrl = "$baseUrl/webview/contractor/withdraw?token=";
  static String leadOngoingUrl = "$baseUrl/webview/vendor/jobs/hired?token=";
  static String projectsOngoingUrl =
      "$baseUrl/webview/contractor/jobs/hired?token=";
  static String projectsCompletedUrl =
      "$baseUrl/webview/contractor/jobs/completed?token=";
  static String leadCompletedUrl =
      "$baseUrl/webview/vendor/jobs/completed?token=";
  static String leadManageJobsUrl =
      "$baseUrl/webview/vendor/dashboard/manage-jobs?token=";
  static String contractorManageJobsUrl =
      "$baseUrl/webview/contractor/dashboard/manage-jobs?token=";
  // static String contractorDashBoardUrl =
  //     "$baseUrl/webview/contractor/dashboard";
  static String contractorDashBoardUrl =
      "$baseUrl/webview/contractor/dashboard?token=";
  static String vendorDashBoardUrl = "$baseUrl/webview/vendor/dashboard?token=";

  static var invoiceStore = '$baseUrl/invoice/store';
  static var estimationStore = '$baseUrl/estimation/store';
  static var workorderStore = '$baseUrl/work-order/store';
  static var SEND_EMAIL = '$baseUrl/send-mail';
}
