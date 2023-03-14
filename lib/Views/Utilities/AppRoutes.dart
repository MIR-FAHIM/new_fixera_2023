import 'package:new_fixera/Views/InAppPurchase/in_app_purchase.dart';
import 'package:new_fixera/Views/Screens/BottomNavigationScreen/BottomNavigationPage.dart';
import 'package:new_fixera/Views/Screens/ContractorScreen/ContractorDetailsPage.dart';
import 'package:new_fixera/Views/Screens/EditJob/EditJob.dart';
import 'package:new_fixera/Views/Screens/Estimation/VendorEstimation.dart';
import 'package:new_fixera/Views/Screens/ExportScreens.dart';
import 'package:new_fixera/Views/Screens/ForgotScreen/ForgotMail.dart';
import 'package:new_fixera/Views/Screens/ForgotScreen/ForgotOtp.dart';
import 'package:new_fixera/Views/Screens/ForgotScreen/PasswordResetPage.dart';
import 'package:new_fixera/Views/Screens/JobScreen/JobDetailsScreen/JobDetailsPage.dart';
import 'package:new_fixera/Views/Screens/JobScreen/JobDetailsScreen/SendProposalPage.dart';
import 'package:new_fixera/Views/Screens/JobScreen/JobPage.dart';
import 'package:new_fixera/Views/Screens/MarketPlaceScreen/FullProfilePage.dart';
import 'package:new_fixera/Views/Screens/MarketPlaceScreen/openJobsPage.dart';
import 'package:new_fixera/Views/Screens/NavDrawerScreen/DashBoard.dart';
import 'package:new_fixera/Views/Screens/NavDrawerScreen/Invoice.dart';
import 'package:new_fixera/Views/Screens/NavDrawerScreen/NavJobDetailsExpandedScreen.dart';
import 'package:new_fixera/Views/Screens/NavDrawerScreen/NavJobDetailsScreen.dart';
import 'package:new_fixera/Views/Screens/NavDrawerScreen/NavJobsScreen.dart';
import 'package:new_fixera/Views/Screens/NavDrawerScreen/PackagesScreen.dart';
import 'package:new_fixera/Views/Screens/NavDrawerScreen/Wallet/credit_report.dart';
import 'package:new_fixera/Views/Screens/NavDrawerScreen/postAJobAndleadScreen/PostAJobAndLeadScreen.dart';
import 'package:new_fixera/Views/Screens/NavDrawerScreen/Wallet/WalletScreen.dart';
import 'package:new_fixera/Views/Screens/NavDrawerScreen/ProposalsScreen.dart';
import 'package:new_fixera/Views/Screens/SearchScreen/SearchPage.dart';
import 'package:new_fixera/Views/Screens/SettingsScreen/AccountSettings.dart';
import 'package:new_fixera/Views/Screens/SettingsScreen/DeactivateAccount.dart';
import 'package:new_fixera/Views/Screens/SettingsScreen/EmailAccount.dart';
import 'package:new_fixera/Views/Screens/SettingsScreen/ManageAccount.dart';
import 'package:new_fixera/Views/Screens/SettingsScreen/PaymnetSettings.dart';
import 'package:new_fixera/Views/Screens/SettingsScreen/ProfileSettings.dart';
import 'package:new_fixera/Views/Screens/SettingsScreen/SettingsPage.dart';
import 'package:new_fixera/Views/Screens/SettingsScreen/SettingsWeb.dart';
import 'package:new_fixera/Views/Screens/Signin/CarouselPage.dart';
import 'package:new_fixera/Views/Screens/Signin/SignInPage.dart';
import 'package:new_fixera/Views/Screens/Signin/SplashPage.dart';
import 'package:new_fixera/Views/Screens/Signup/SignUpPage.dart';
import 'package:new_fixera/Views/Screens/NavDrawerScreen/BuyCredit.dart';
import 'package:new_fixera/Views/Screens/NavDrawerScreen/ProjectsorLeads/ProjectsOrLeadsScreen.dart';
import 'package:new_fixera/Views/Screens/WorkOrderScreen/WorkOrderContractorPage.dart';
import 'package:new_fixera/Views/Screens/WorkOrderScreen/WorkOrderVendorPage.dart';
import 'package:new_fixera/Views/Screens/NavDrawerScreen/HowitWorks.dart';
import 'package:new_fixera/Views/Screens/NavDrawerScreen/PrivacyPolicy.dart';
import 'package:new_fixera/Views/Screens/NavDrawerScreen/TransferHistory.dart';
import 'package:new_fixera/Views/Screens/NavDrawerScreen/MessageCenter.dart';
import 'package:new_fixera/Views/Screens/JobScreen/JobDetailsScreen/dynamicRow.dart';
import 'package:get/get.dart';

class AppRoutes {
  static String INITIAL = "/splash";
  static String CAROUSELPAGE = "/CarouselPage";
  static String SIGNINPAGE = "/SignInPage";
  static String SIGNUPPAGE = "/SignUpPage";
  static String BOTTOMNAVIGATIONPAGE = "/BottomNavigationPage";
  static String CREDITREPOR = "/CreditReport";
  static String HOME = "/HomePage";
  static String JOB = "/JobPage";
  static String JOBDETAILSPAGE = "/JobDetailsPage";
  static String JOBDETAILSENDPROPOSAL = "/JobDetailsPage";
  static String FAVOURITE = "/Favourite";
  static String SEARCH = "/Search";
  static String WORKORDERCONTRACTOR = "/WorkOrderContractor";
  static String WORKORDERVENDOR = "/WorkOrderVendor";
  static String NAVPROPOSALS = "/Proposals";
  static String PACKAGES = "/Packages";
  static String INAPPPURCHASE = "/InAppPurchase";
  static String SETTINGS = "/Settings";
  static String EDITJOB = "/EditJob";
  static String VENDORESTIMATION = "/VendorEstimation";
  static String NAVJOBPAGE = "/NavJobPage";
  static String FULLPROFILEPAGE = "/VendorDetailsPage";
  static String NAVPOSTAJOBANDLEAD = "/NavPostAJobAndLead";
  static String FORGOTMAIL = "/ForgotMail";
  static String FORGOTOTP = "/ForgotOtp";
  static String PASSWORDRESET = "/PasswordReset";
  static String NAVJOBDETAILSPAGE = "/NavJobDetailsPage";
  static String NAVJOBDETAILSEXTENDEDPAGE = "/NavJobDetailsExtendedPage";
  static String CONTRACTORDETAILSPAGE = "/ContractorDetailsPage";
  static String OPENJOB = "/OpenJob";
  static String INVOICEPAGE = "/Invoice";
  static String BUYCREDITPAGE = "/BuyCredit";
  static String MANAGEPROJECTANDLEADS = "/ManageProjectsANdLeads";
  static String HOWITWORKS = "/HowItWorks";
  static String PRIVACYPOLICY = "/privacyPolicy";
  static String PROJECTS = "/projects";
  static String WALLET = "/Wallet";
  static String MESSAGECENTER = "/MessageCenter";
  static String TRANSFERHISTORY = "/TransferHistory";
  static String SENDPROPOSAL = "/SendProposal";
  static String DASHBOARD = "/DashBoard";
  static String DYNAMIC = "/Dynamic";
  static String SETTINGSWEB = "/Settingsweb";
  static String PROFILE_SETTINGS = "/profile_setings";

  static String PAYMENT_SETTINGS = "/payment_settings";
  static String DEACTIVATE_ACCOUNT = "/deactivate_account";
  static String EMAIL_ACCOUNT = "/email_account";
  static String MANAGE_ACCOUNT = "/manage_account";

  static List<GetPage> AppRoutesList() {
    return [
      GetPage(name: INITIAL, page: () => SplashPage()),
    //  GetPage(name: INITIAL, page: () => CreditReport()),
      GetPage(name: CAROUSELPAGE, page: () => CarouselPage()),
      GetPage(name: SIGNINPAGE, page: () => SignInPage()),
      GetPage(name: SIGNUPPAGE, page: () => SignUpPage()),
      GetPage(name: BOTTOMNAVIGATIONPAGE, page: () => BottomNavigationPage()),
      GetPage(name: HOME, page: () => HomePage()),
      GetPage(name: JOB, page: () => JobPage()),
      GetPage(name: OPENJOB, page: () => OpenJobs()),
      GetPage(name: JOBDETAILSPAGE, page: () => JobDetailsPage()),
      GetPage(name: JOBDETAILSENDPROPOSAL, page: () => SendProposalPage()),
      GetPage(name: FAVOURITE, page: () => Favourite()),
      GetPage(name: NAVPOSTAJOBANDLEAD, page: () => PostAJobAndLead()),
      GetPage(name: EDITJOB, page: () => EditJobPage()),
      GetPage(name: SEARCH, page: () => SearchPage()),
      GetPage(name: FULLPROFILEPAGE, page: () => FullProfilePage()),
      GetPage(name: SETTINGS, page: () => SettingsPage()),
      GetPage(name: PACKAGES, page: () => PackagesScreen()),
     // GetPage(name: INAPPPURCHASE, page: () => InAppPurchasePage()),
      GetPage(name: VENDORESTIMATION, page: () => VendorEstimation()),
      GetPage(name: WORKORDERCONTRACTOR, page: () => WorkOrderContractorPage()),
      GetPage(name: WORKORDERVENDOR, page: () => WorkOrderVendorPage()),
      GetPage(name: NAVJOBPAGE, page: () => NavJobPage()),
      GetPage(name: BUYCREDITPAGE, page: () => BuyCredit()),
      GetPage(name: NAVJOBDETAILSPAGE, page: () => NavJobDetailsPage()),
      GetPage(
          name: NAVJOBDETAILSEXTENDEDPAGE,
          page: () => NavJobDetailsExpandedPage()),
      GetPage(name: NAVPROPOSALS, page: () => ProposalsPage()),
      GetPage(name: FORGOTMAIL, page: () => ForgotMail()),
      GetPage(name: FORGOTOTP, page: () => ForgotOtp()),
      GetPage(name: PASSWORDRESET, page: () => PasswordResetPage()),
      GetPage(name: CONTRACTORDETAILSPAGE, page: () => ContratorDetailsPage()),
      GetPage(name: INVOICEPAGE, page: () => Invoices()),
      GetPage(name: HOWITWORKS, page: () => HowItworks()),
      GetPage(name: PRIVACYPOLICY, page: () => PrivacyPolicy()),
      GetPage(name: PROJECTS, page: () => Projects()),
      GetPage(name: WALLET, page: () => WalletScreen()),
      GetPage(name: MESSAGECENTER, page: () => MessageCenter()),
      GetPage(name: TRANSFERHISTORY, page: () => TransferHistory()),
      GetPage(name: SENDPROPOSAL, page: () => SendProposalPage()),
      GetPage(name: DASHBOARD, page: () => DashBoard()),
      GetPage(name: DYNAMIC, page: () => DymanicCard()),
      GetPage(name: SETTINGSWEB, page: () => SettingsWebPage()),
      GetPage(name: PROFILE_SETTINGS, page: () => ProfileSettings()),
      GetPage(name: PAYMENT_SETTINGS, page: () => PaymentSettings()),
      GetPage(name: DEACTIVATE_ACCOUNT, page: () => DeactivateAccount()),
      GetPage(name: MANAGE_ACCOUNT, page: () => ManageAccount()),
      GetPage(name: EMAIL_ACCOUNT, page: () => EmailAccount()),
    ];
  }
}
