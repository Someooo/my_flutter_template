class UserModelConstants {
  static const String id = "id";
  static const String name = "name";
  static const String arabicName = "name_ar";
  static const String englishName = "name_en";
  static const String email = "email";
  static const String imageUrl = "profile_image";
  static const String password = "password";
  static const String birthday = "date_of_birth";
  static const String gender = "gender";
  static const String type = "type";
  static const String token = "token";
  static const String phoneNumber = "mobile";
  static const String city = "city";
  static const String subscriptionDate = "subscription_date";
  static const String exceptions = "exceptions";
  static const String address = "address";
  static const String verificationNumber = "verification_number";
  static const String nationalId = "national_id";
  static const String chronicDiseases = "chronicDisease";
  static const String policyHolder = "policy_holder";
  static const String degreeOfInsurance = "degreeOfInsurance";
  static const String subscriptionStatus = "subscriptionStatus";
  static const String subscriptionStatusId = "subscription_status_id";
  static const String chronicDiseasesId = "chronic_diseases_id";
  static const String degreeInsuranceId = "degree_insurance_id";
  static const String cityId = "city_id";
  static const String status = "status";
  static const String relationship = "relationship";
  static const String insuranceCompany = "insurance_company";
  static const String healthQuestions = "health_questions";
  static const String insuranceNumber = "member_id";
}

class CityModelConstants {
  static const String id = "id";
  static const String name = "name";
  static const String imageUrl = "icon";
}

class SectionEventModelConstants {
  static const String id = "id";
  static const String title = "title";
  static const String events = "events";
}

class EventsModelConstants {
  static const String id = "id";
  static const String title = "eventTitle";
  static const String description = "description";
  static const String topLevelLocation = "topLevelLocation";
  static const String detailedLocation = "detailedLocation";
  static const String latitude = "latitude";
  static const String longitude = "longitude";
  static const String price = "price";
  static const String joinedUsers = "joinedUsers";
  static const String date = "date";
  static const String time = "time";
  static const String images = "images";
  static const String videos = "videos";
  static const String sponsors = "sponsors";
  static const String speakers = "speakers";
  static const String category = "category";
}

class CategoryModelConstants {
  static const String id = "id";
  static const String title = "name";
  static const String image = "icon";
}

class SpeakerModelConstants {
  static const String id = "id";
  static const String name = "name";
  static const String bio = "bio";
  static const String images = "images";
  static const String videos = "videos";
}

class SponsorModelConstants {
  static const String id = "id";
  static const String name = "name";
  static const String images = "images";
  static const String videos = "videos";
  static const String bio = "bio";
}

class MedicalNetworkJsonConstants {
  static const String id = "id";
  static const String medicalNetworkId = "medical_network_id";
  static const String name = "name";
  static const String email = "email";
  static const String phone = "phone";
  static const String address = "address";
  static const String latitude = "latitude";
  static const String longitude = "longitude";
  static const String typeMedical = "type_medical";
  static const String specialization = "specialization";
  static const String city = "city";
  static const String promotion = "promotion";
  static const String isFavorite = "is_favorite";
}

class MedicalTypeJsonConstants {
  static const String id = "id";
  static const String name = "name";
  static const String description = "description";
  static const String icon = "image";
}

class SpecializationJsonConstants {
  static const String id = "id";
  static const String name = "name";
}

class HealthQuestionJsonConstants {
  static const String id = "id";
  static const String question = "question";
  static const String type = "type";
  static const String answer = "answer";
  static const String questionId = "question_id";
}

class ComplaintJsonConstants {
  static const String id = "id";
  static const String name = "name";
  static const String password = "password";
  static const String email = "email";
  static const String phone = "phone";
  static const String message = "message";
  static const String details = "details";
  static const String date = "date";
  static const String medicalFormId = "medical_form_id";
  static const String attachment = "attachment";
  static const String resolution = "resolution";
}
