class ApiGetUrl {
  static String getResStatistics = "api/statistics/reservation";
  static String getPendingRequests =
      "api/statistics/pendingReservations?skip=0&limit=1&sortKey=createdAt&sortOrder=-1";
  static String getReservation = "api/reservation";
  static String getPost = "api/post";
  static String getCity = "api/city";
  static String getBedType = "api/bedType";
  static String getRoomType = "api/room-types";
  static String getPlaceType = "api/placeType";
  static String getUnitType = "api/unitType";
  static String getPostCategory = "api/postCategory";
  static String getReservationType = "api/reservation-type";
  static String getService = "api/service";
  static String getGift = "api/gift?searchKey";
  static String getPayment = "api/payment";
}

class ApiPostUrl {
  static String login = "api/email-auth/login";
  static String logout = "api/auth/logout";
  static String createReservation = "api/reservation";
  static String addPost = "api/post";
  static String addCity = "api/city";
  static String addBedType = "api/bedType";
  static String addRoomType = "api/room-types";
  static String addPlaceType = "api/placeType";
  static String addUnitType = "api/unitType";
  static String addPostCategory = "api/postCategory";
  static String addReservationType = "api/reservation-type";
  static String addService = "api/service";
  static String addGift = "api/gift";
  static String addPayment = "api/payment";
}

class ApiDeleteUrl {
  static String deletePost = "api/post/";
  static String deleteCity = "api/city/";
  static String deleteBedType = "api/bedType/";
  static String deleteRoomType = "api/room-types/";
  static String deletePlaceType = "api/placeType/";
  static String deleteUnitType = "api/unitType/";
  static String deletePostCategory = "api/postCategory/";
  static String deleteReservationType = "api/reservation-type/";
  static String deleteService = "api/service/";
  static String deleteGift = "api/gift/";
  static String deletePayment = "api/payment/";
}

class ApiPutUrl {}

class ApiPatchUrl {
  static String cancelReservation = "";
  static String updateReservation = "api/reservation/";
  static String editPost = "api/post/";
  static String editCity = "api/city/";
  static String editBedType = "api/bedType/";
  static String editRoomType = "api/room-types/";
  static String editPlaceType = "api/placeType/";
  static String editUnitType = "api/unitType/";
  static String editPostCategory = "api/postCategory/";
  static String editReservationType = "api/reservation-type/";
  static String editService = "api/service/";
  static String editGift = "api/gift/";
  static String editPayment = "api/payment/";
}
