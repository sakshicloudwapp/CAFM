


String main_base_url = "";
class AllApiServices{
  /// Base url....
  static const String DEV_Url  = "http://devcafm.rynasolutions.com/";
  static const String UAT_Url  = "http://uatcafm.rynasolutions.com/"; //New
  // http://uatcafm.rynasolutions.com/CoreAPI/api/Account/token
  /// old url
 static const String Prod_Url  = "https://apicafm.rynaifm.com/";
  /// New app url
  // static const String Prod_Url  = "https://dksaapi.rynaifm.com/";
  static  String main_base_url = "";

  /// Middile url.....
  static const String base_name_coreApi = "CoreApi/api/Resources";
  static const String base_coreApi = "CoreAPI/api/";
  static const String base_name_PPmApi = "PMAPI/api/";
  static const String scheduleapi = "SchduledApi/api/";
  static const String StockApi = "StockApi/api/";
  static const String AssetManagement = "AssetManagement/api/";
  static const String base_name_HrmsmgmtApi = "HrmsmgmtApi/api/";

  static const String signIn = "CoreApi/api/Account/token";
  static const String logout = "CoreApi/api/Account/logOut?isMobile=true";
  static const String deviceId = base_coreApi+"Account/deviceId";
  static const String GetMenu = base_coreApi+"Common/GetMenu";
  static const String ReGenerateToken = base_coreApi+"Account/ReGenerateToken?accountId=";

  static const String Gethomepage = base_name_PPmApi+"Mobile/GetWorkOrderCount";

  static const String GetWorkOrdersByTypeNStatus = "Mobile/GetWorkOrdersByTypeNStatus/";
 // static const String GetNotificationWorkOrders = "Mobile/GetNotificationWorkOrders";
  static const String GetNotificationWorkOrders = "Mobile/GetNotificationWorkOrders";
  static const String update_work_orders = "Mobile/UpdateTaskViewStatusByResource/";


  static const String GetTaskLogGeneralInfo = "TaskLog/GetTaskLogGeneralInfo/";
  /// This is for Task Logs -> PPM - 1, Reactive - 2, Corrective - 3
 // static const String task_log_info = taskLog_base_url+"/GetTaskLogGeneralInfo/";
  /// GetResource/........
  static const String get_resource = base_name_coreApi+"/GetResource/";
  static const String accept_reject = "TaskLogOperations/SaveTaskLogResourceInfo";
  static const String task_log_additionol_info = "TaskLog/GetTaskLogAdditionalInfo/";
  static const String SaveTaskLogOnHoldReason = "TaskLogOperations/SaveTaskLogOnHoldReason";
  static const String SaveTaskLogQuestionnaire = "TaskLogOperations/SaveTaskLogQuestionnaire";
  static const String UpdateTaskLogStatus = "TaskLogOperations/UpdateTaskLogStatus?taskLogId=";
  static const String AddOrUpdateTaskLog ="TaskLog/AddOrUpdateTaskLog";
  static const String UpdateTaskLog ="TaskLog/UpdateTaskLog";
  static const String AddOrUpdateScheduledTask ="TaskLog/AddOrUpdateScheduledTask";
  static const String CustomerEmailNotificarion = "Mobile/CustomerEmailNotificarion?taskLogId=";
  static const String GetResourcesByReporterType = "TaskLog/GetResourcesByReporterType/";
  static const String DeleteTaskLogDocuments = "TaskLogOperations/DeleteTaskLogDocuments";
  static const String DeleteTaskLogImages = "TaskLogOperations/DeleteTaskLogImages";
  static const String AddOrUpdateTaskLogImages = "TaskLogOperations/AddOrUpdateTaskLogImages";
  static const String AddOrUpdateTaskLogDocuments = "TaskLogOperations/AddOrUpdateTaskLogDocuments";
  static const String GetProjectsMasterData = "TaskLog/GetProjectsMasterData/";
  static const String GetLocationDetailsByAssetCode = "Mobile/GetLocationDetailsByAssetCode/";
  static const String GetLocationAndResourceMasterData = "TaskLog/GetLocationAndResourceMasterData/";
  static const String SaveTaskLogFeedBack = "TaskLogOperations/SaveTaskLogFeedBack";
  static const String GetUserInformation = base_name_PPmApi+"Mobile/GetUserInformation";
  static const String GetResourceProfile = base_name_coreApi+"/GetResourceProfile";
  static const String GetTermsAndCondtions = base_name_PPmApi+"Mobile/GetTermsAndConditions";
  static const String GetMRDetailsByTaskId = "MaterialRequest/GetMRDetailsByTaskId/";
  static const String Getassetlookup = "Activity/GetAllAssets";
  static const String Getassetlookupdetail = "Activity/GetAssetInformationById?assetId=";
  static const String CreateMaterialRequest = "MaterialRequest/CreateMaterialRequest";
  static const String GetPrivacyPolicy = base_name_PPmApi+"Mobile/GetPrivacyPolicy";
  static const String IssuingStockPrice = StockApi+"StockIssued/IssuingStockPrice/";
  static const String GetSupervisedResources = "Mobile/GetSupervisedResources";
  static const String TransferWorkOrders = "TaskLog/TransferWorkOrders";
  static const String Announcement_Announcements = "Announcement/Announcements";
  static const String Mobile_ValidateWorkOrderAsset = "Mobile/ValidateWorkOrderAsset";
  static const String Mobile_ReassignWorkOrder = "Mobile/ReassignWorkOrder";
  static const String GetAdditionalResourcesforWorkOrder = "TaskLog/GetAdditionalResourcesforWorkOrder";
  static const String isedit = "0";

}
