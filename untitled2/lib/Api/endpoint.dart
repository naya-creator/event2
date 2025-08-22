class Endpoint {
  static String baseUrl = "http://192.168.1.106:8000/api/";
  static const String imageUrl = 'http://192.168.1.106:8000';
  static const String imageUrlevent = 'http://192.168.1.106:8000/';
 // static const String imageUrl22 = 'http://10.65.11.20:8000/storage/hall_images/';

  // Auth
  static String login = 'login';
  static String signup = "register";
  static String logout = "logout";
  static String profile = "user/profile";
  static String updateProfile = "user/profile";
  static String uploadImage = "user/profile/image";

  // Events & Places
  static String get_all_events = "events/";
  static String search_events = "search/Events";
  static String search_history = 'event-types';
  static String get_all_places = "place-types";
  static String getHallsDataEndPoint(int id) => 'place-types/$id/halls';
  static String get_HallDetails(int hallId) => 'halls/$hallId';
  static String get_HallServices(int hallId) => 'halls/services/$hallId';
  static String get_availabletimes(int hallId) => 'halls/$hallId/available-times';

  // Reservations
  static String post_reservehall = "reservations/select-hall";
  static String get_current_reservation = "reservations/summary";
  static String confirm_reservation = "reservations/confirmm";
  static String getall_reservation = "reservations";
  static String addfoodreservation = "reservations/food";
  static String adddecorereservation = "reservations/flowers";
  static String reservPhotohrapher = "reservations/photographer";
  static String reservSinger = "reservations/dj";
  static String DeleteandputReservation(int id) => 'reservations/$id';
static String post_addfav = "favorites/";
static String post_deletefav = "favorites/";
  // Services
  static String get_FoodTypes(int typeId) => 'services/category/$typeId/variants';
  static String get_FoodCategories(int categoriesId) => 'services/service/$categoriesId/categories';
  static String get_Fooddetails(int foodDetails) => 'services/variant/$foodDetails/types';
  static String get_decorationtypes(int decorationTypeId) => 'services/decorations/types';
  static String get_detailsofdecorationtypes(int detailsDecorationTypeId) =>
      'services/decorations/$detailsDecorationTypeId/flowers';
  static String getMusicDataEndPoint(int id) => "services/3/music";
  static String getPhotoDataEndPoint(int id) => "services/3/photographers";
  static String addsongg = "services/music/custom-song";

  // Coordinator
  static String pendingTasks = "coordinator/assignments/pending";
  static String nonPendingTasks = "coordinator/assignments/non-pending";
  static String acceptTask(int id) => "coordinator/assignments/$id/accept";
  static String rejectTask(int id) => "coordinator/assignments/$id/reject";
  static String postTaskToCoordinator(int id) => "hall-owner/coordinators/assign/$id";
}

class ApiKey {
  static String status = "status";
  static String errormessage = "message";
  static String errorMassage = "ErrorMassage"; // احتفظت بالاثنين إذا بتحتاجهم
  static String message = "message";

  // Auth
  static String email = "email";
  static String password = "password";
  static String password_confirmation = "password_confirmation";
  static String token = "token";
  static String location = "location";
  static String phone = "phone";
  static String profilePic = "profilePic";

  // Event & Hall
  static String id = "id";
  static String name = "name";
  static String nameA = "name_ar";
  static String nameE = "name_en";
  static String eventType = "event_type_id";
  static String locationA = "location_ar";
  static String locationE = "location_en";
  static String capacity = "capacity";
  static String price = "price";
  static String imageUrl = "image_url";

  // Music
  static String title = "title";
  static String artist = "artist";
  static String language = "language";
  static String created_at = "created_at";
  static String updated_at = "updated_at";

  // Coordinator / Tasks
  static String assignment_id = "assignment_id";
  static String service = "service";
  static String coordinator = "coordinator";
  static String statuss = "status";
  static String reservation_id = "reservation_id";
}
