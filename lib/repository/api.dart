class ApiConstants {
  static const String baseUrl = "http://192.168.1.66:3000/";

  static const String login = "${baseUrl}admin/login";
  static const String uploadImage = "${baseUrl}image/uploadImage";
  static const String getUser = "${baseUrl}user/getUserProfile";
  static const String getUnverifiedUser = "${baseUrl}user/getUnverifiedUsers";
  static const String verifyUserUrl = "${baseUrl}user/verifyUser";
  static const String getAttachedFilesUrl =
      "${baseUrl}attach_files/getAttachFiles";
  static const String getVerifiedUserUrl = "${baseUrl}user/getAllVerifiedUsers";
  static const String deleteUser = "${baseUrl}user/deleteUser";
  static const getIncidentsUrl = "${baseUrl}incident/getIncidents";
  static const deleteIncidentsUrl = "${baseUrl}incident/deleteIncident";
}
