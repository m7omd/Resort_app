class EndPoints {
  /////////////// Auth User  ////////////////
  static const String login = "/api/MobileLogin";
  static const String registerUser = "/auth/register";
  static const String sendOtpUser = "/auth/send-otp";
  static const String verifyOtp = "/auth/verify-otp";
  static const String updateRegisterData = "/auth/update-user/";
  // static const String saveChanges = "/api/Transactions/save-changes";

  /////////////// Transactions  ////////////////
  static const String getAllTransactions = '/api/Mobile/MobileTransactions/GetAll';
  static const String getPersons = '/api/Employees/GetUsers';
  static const String getReports = '/api/Reports/GetReportsSelect';
  static const String getDashboard = '/api/Mobile/MobileTransactions/GetDashboardStatistics';
  static const String getFilterOptions = '/api/Filters/GetFilterOptions';
  static const String sendMessage = '/api/Messages/send-message';
  static const String getCites = '/api/LOV/TRI_CRI_ID';
  static const String getAreas = '/api/LOV/DTR_DISTRICT_ID';
  static const String getMaps = '/api/Mobile/MobileTransactions/GetMap';
  static const String uploadFile = '/api/Transactions/UploadFile';
  static String getAttachments(String id,int attachmentType) => '/api/Transactions/GetAttachments/$id?attachmentType=$attachmentType';
  static String getNotes(String id) => '/api/Transactions/GetNotesById/$id';
  static String addNote(String id) => '/api/Transactions/AddNote/$id';
  static String downloadPdf(String id) => '/api/Transactions/ExportPdf/$id';
  static String getMessagesForTransaction(String id) => "/api/Transactions/GetMessages/$id";
  static String removeImage({required String? imageId}) => '/api/Transactions/RemoveImage/$imageId';
  static const String getOutBox = '/api/Mobile/MobileMessages/Outbox';
  static const String getInbox = '/api/Mobile/MobileMessages/Inbox';
  static const String getFinishingDetails =
      '/api/Transactions/350d36d8-847d-4b4a-bacc-c84ad9394390/workflowblocks/RSM_FINSHING_DETAILS/fields';
  static String getEmailDetails({required String? id}) => '/api/Mobile/MobileMessages/GetById/$id';
  static String getSummary({required String? id}) => '/api/Transactions/GetSummary/$id';
  // static  String   getCustomer =  '/api/LOV/TRI_ATR_ID';
  static String populateTrx(String key) => "/api/Transactions/populate-trx/$key";
  static String saveChanges(String id) => "/api/Transactions/save-changes/$id";
  static String changeTransactionStatus = "/api/transactions/execute-action";
  static String getLov({required String internalName}) => "/api/LOV/$internalName";
  static String getTransactionByInternalName({required String id, required String internalName}) =>
      '/api/Transactions/$id/workflowblocks/$internalName/fields';

  /////////////// Contact Us  ////////////////
  static const String contactUs = "/contact-us";
  static const String getContactUs = "/app-settings";
  static const String getFAQ = "/faq-questions";

  /////////////// Profile User  ////////////////
  static const String userData = "/profile/me";
  static const String logOutUser = "/profile/logout";
  static const String updateUserData = "/profile/update";
  static const String sendOtpEditPhone = "/profile/send-otp";
  static const String verifyOtpEditPhone = "/profile/verify-otp";
  static const String deleteAccount = "/profile/delete-account";
  static const String getHomeProviderData = '/home';
  static const String plans = '/plans';
  static const String planSubscriptions = '/plan-subscriptions';
  static const String toggleLanguage = '/profile/update-language';

  /////////////// Notification  ////////////////
  static const String notification = '/notification';
  static const String markAllAsRead = '/mark-all-notifications-as-read';
  static const String toggleNotification = '/profile/update-notification';

  /////////////// Pages  ////////////////
  static const String getPrivacyPolicy = '/pages/3';
  static const String getTermsAndConditions = '/pages/2';
  static const String getAboutUs = '/pages/1';

  /////////////// public  ////////////////
  static const String getProblemTypes = '/problem-types';
  static const String getCarModels = '/car-models';
  static const String getCarFactories = '/car-factories';

  /////////////// Home ///////////////////
  static const String getClientHome = '/home';
  static const String getProviderHome = '/provider/home';
  static const String getProvider = '/providers/';
  static const String getProviders = '/providers?';
  static const String sendOffer = '/provider/offer';

  //////////////////////////Location/////////////////////////
  static const String suggestionsUrl = "/place/autocomplete/json";
  static const String placeLocationById = "/place/details/json";
  static const String getAddressNameByLocation = "/geocode/json";
  static const String updateUserLocation = "/user/profile/update-location";
  static const String cities = "/cities";
  static const String distracts = "/districts";

  /////////////// Addresses  ////////////////
  static const String getAddresses = '/client/addresses';
  static const String addAddress = '/client/addresses';
  static const String updateAddress = '/client/addresses/';
  static const String deleteAddress = '/client/addresses/';

  /////////////// Cars  ////////////////
  static const String getMyCars = '/client/cars';
  static const String addMyCar = '/client/cars';
  static const String updateMyCar = '/client/cars/';
  static const String deleteMyCar = '/client/cars/';

  ///////////// My Services //////////////
  static const String addMyServices = '/provider/orders';
  static const String deleteMyServices = '/provider/orders';
  static const String getMyServices = '/provider/orders';
  static const String updateMyServices = '/provider/orders';

  /////////////// Exhibits /////////////////
  static const String getExhibits = '/provider/services';
  static const String updateExhibits = '/provider/services/';
  static const String deleteExhibits = '/provider/services/';
  static const String addExhibits = '/provider/services';

  //////////////// Orders //////////////////
  static const String getProviderTimes = '/client/provider-times';
  static const String getMyOrders = '/client/orders';
  static const String addMyOrder = '/client/orders';
  static const String cancelMyOrder = '/client/orders/';
}
