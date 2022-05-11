class ApiUrl {
  static const String BASEURL = "https://trashit.ng/api/";
  static const String LOGIN = BASEURL + "login";
  static const String REGISTER = BASEURL + "register";
  static const String SEND_OTP = BASEURL + "resend-user-otp";
  static const String VERIFY_OTP = BASEURL + "verify-user-otp";
  static const String VALIDATE_CUSTOMER = BASEURL + "validate-customer-info";
  static const String OPERATORS_LIST = BASEURL + "operators";
  static const String WARDS = BASEURL + "wards";
  static const String LGA = BASEURL + "lga";
  static const String PROFILE = BASEURL + "my-profile?email=";
  static const String BILLS = BASEURL + "bills?email=";
  static const String GET_PAYMENTS = BASEURL + "payments";
  static const String BILL_DETAILS = BASEURL + "bill-breakdown?bill_id=";
  static const String FEEDBACK = BASEURL + "send-feedback";
  static const String GET_INFO = BASEURL + "get-official-information";
  static const String GET_SOCIAL_MEDIA_LINKS = BASEURL + "get-social-media-links";
  static const String FAQ = BASEURL + "get-faq";
  static const String GET_TOLL_LINE = BASEURL + "get-toll-line";
  static const String SIGN_OUT = BASEURL + "sign-out";

}
