class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeOut = Duration(seconds: 1000);
  static const Duration receiveTimeOut = Duration(seconds: 1000);
  // for android
  static const String baseUrl = "http://10.0.2.2:3000/api/v1/";
  // for iphone
  // static const String baseUrl = "http://localhost:3000/api/v1/";
  // for physical device
  // static const String baseUrl = "http://192.168.0.105:3000/api/v1/";

  // static const String baseUrl = "http://127.0.0.1:3000/api/v1/";

  // ======== Auth ===============
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String uploadImage = "auth/uploadImage/";
  static const String getAllOwners = "auth/getAllOwners";
  static const String updateOwner = "auth/update/";
  static const String getOwner = "auth/";
  static const String sitterlogin = "sitter/login";
  static const String sitterregister = "sitter/register";
  static const String sitteruploadImage = "sitter/uploadIMage/";
  static const String getAllSitters = "sitter/getAllSitters";
  static const String updateSitter = "sitter/update/";
  static const String getSitter = "sitter/";

  static const String createBooking = "booking/create";
  static const String getAllBookings = "booking";
  static const String updateBooking = "booking/dates/";
  static const String deleteBooking = "booking/";

  static const String createPet = "auth/";
  static const String updatePet = "auth/";
  static const String deletePet = "auth/";
}
