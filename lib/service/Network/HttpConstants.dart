class HttpConstants {
  // PRODUCTION
  static String baseUrl = 'barter-app.progbiz.io';
  static String imageUrl = 'https://barter-app.progbiz.io';
  //API KEYS
  static String login = '/api/auth/app-login';

  //General
  static String initialData = '/api/App/get-initial-data';
  static String itemsList = '/api/App/search-items';
  static String singleItemsList = '/api/App/get-item-single';
  static String myProduct = '/api/App/my-products';
  static String register = '/api/App/customer-registration';
  static String otpCheck = '/api/App/verify-otp';
  static String getImagePath = '/api/media/get-image';
  static String uploadImage = '/api/media/upload-image';
  static String addFavourate = '/api/App/toggle-favourites';
  static String addEditProduct = '/api/App/add-item';
  static String editProfile = '/api/App/edit-profile';
  static String saveProfileData = '/api/App/save-profile';
  static String getDestricte = '/api/App/get-districts';
  static String getDesSub = '/api/App/get-sections';
  static String getDesSubSec = '/api/App/get-subsections';
  static String getState = '/api/App/get-states';
  static String getProfile = '/api/App/view-profile';
  static String getFavProduct = '/api/App/show-favourites';
  static String getNewCategory = '/api/App/get-news-category';
  static String getNewsList = '/api/App/get-news-list';
  static String getNewsOfDay = '/api/App/get-news-of-the-day';
  static String getNewsSingle = '/api/App/get-news-single';
  static String getChatList = '/api/Chat/get-chat-list';
  static String getChatHistory = '/api/Chat/get-chat-history';
  static String deletepro = '/api/App/item-sold-out';
  static String senchat = '/api/Chat/sent';
  static String getNotification = '/api/Entity/get-all-notifications';
  static String reportAdmin = '/api/App/report-user';
//Bookings
}
