class ApiPaths {
  ApiPaths._();

  static String baseUrl = "https://ii-h.com/api/client/";
  static String baseHCPUrl = "https://ii-h.com/api/hcp/";

  static const String signup = 'register';
  static const String login = 'login';
  static const String getUserData = 'profile';

  static const String updateProfile = 'profile/update';

  static const String updateAnswerQuestion = 'answer_question';
  static const String doesEmailExist = 'email-existance';
  static const String validateUser = 'validate-user';

  // medical network:

  static const String medicalNetwork = 'medical_network';
  static const String fetchFavorite = 'medical_network/favorite';
  static const String addToFavorite = 'medical_network/add_to_favorite';

  //events
  static const String fetchPolicy = 'policy';
  static const String fetchPrivacyPolicy = 'privacy_policy';
  static const String fetchTermsOfUse = 'terms';

  static const String fetchCities = 'city';
  static const String medicalTypes = 'medicalTypes';
  static const String medicalSpecializations = 'medicalSpecializations';
  static const String fetchCategories = 'categories';
  static const String degreeOfInsurance = 'degreeOfInsurance';
  static const String chronicDiseases = 'chronicDiseases';
  static const String fetchSubscriptionStatus = 'subscriptionStatus';
  static const String fetchDegreesOfInsurance = 'degreeOfInsurance';
  static const String fetchRelationships = 'relationship';

  // Prescription
  static const String fetchPrescriptions = 'prescription';

  // Promotions
  static const String fetchPromotions = 'promotion';
  static const String fetchFeaturedPromotions = 'promotion/is_featured';

  // Medical-forms
  static const String fetchMedicalForm = 'medical_form';
  static const String getAlternativeDrugs = 'get-alternative-drugs';
  static const String saveAlternativeDrugs = 'save-alternative-drug';
  static const String fetchBenefit = 'benefit';
  static const String storeMedicalForm = 'store';
  static const String updateMedicalForm = 'update';
  static const String getBillNo = 'get-form';
  static const String getIcdSearch = 'get-icd';
  static const String getCptSearch = 'get-doctor-cpts';
  static const String getRadiologySearch = 'get-radiology-cpts';
  static const String getLaboratorySearch = 'get-laboratory-cpts';
  static const String getDrugNameSearch = 'get-drug-name';
  static const String getMemberMedicalForm = 'get-medical';

  // Ceilings
  static const String fetchCeiling = 'ceiling';

  // createComplaint
  static const String createComplaint = 'complaint/create';

  // HCP Complaints
  static const String getHcpComplaint = 'complaint';
  static const String createHcpComplaint = 'complaint/create';

  // family members api paths:
  static const String fetchFamilyMembers = 'family';
  static const String addMember = 'family/create';

  // Contact us
  static const String aboutUs = 'about_us';
  static const String supportAndAssistance = 'support_assistance';
  static const String termsConditions = 'terms_conditions';
  static const String getAppComplaint = 'app_complaint';
  static const String createAppComplaint = 'app_complaint/create';
  static const String fetchSocialMedia = 'social_media';

  // Dashboard
  static const String dashboard = 'dashboard';

  // Notifications
  static const String fetchNotifications = 'notification';

// CPT
  static const String fetchAllCPT = 'cpt_medical/create';
  static const String fetchMedicalCPT = 'cpt_medical';
  static const String storeMedicalCPT = 'cpt_medical/store';

  // General Setting
  static const String privacyPolicy = '/general-settings/privacy-policy';
  static const String getGeneralSettings = '/general-settings/get-all-settings';

  // HCP Profile
  static const String hcpProfile = 'profile';
  static const String hcpProfileUpdate = 'profile';

  // HCP Dropdown Services
  static const String hcpGetCities = 'get-cities';
  static const String hcpGetMedicalSpecializations = 'get-medical-specializations';
  static const String hcpGetMedicalTypes = 'get-medical-types';

  // HCP Reports
  static const String hcpReports = 'report/search';

  // HCP Beneficiaries
  static const String hcpBeneficiaries = 'client';
  static const String hcpBeneficiaryDetails = 'client/details';
  static const String hcpHealthQa = 'health-qa';

  // HCP Batch
  static const String hcpBatch = 'batch';
  static const String hcpBatchPostTpa = 'batch/post-tpa';
  static const String hcpBatchClaim = 'batch/claim';

  // HCP Promotions
  static const String hcpPromotion = 'promotion';
  static const String hcpPromotionCreate = 'promotion/create';
  static const String hcpPromotionEdit = 'promotion';
  static const String hcpPromotionDelete = 'promotion';

  // HCP Drugs
  static const String hcpDrugs = 'drug_name';
  static const String hcpDrugsCreate = 'drug_name/create';
  static const String hcpDrugsEdit = 'drug_name';
  static const String hcpDrugsDelete = 'drug_name';
  static const String hcpDrugsSearch = 'drug_name/search';
  static const String hcpAlternativeDrugs = 'drug_name/alternative';
  static const String hcpAlternativeCreate = 'drug_name/alternative/create';
}
