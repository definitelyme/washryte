mixin EndPoints {
  static const String APP_DEV_DOMAIN = 'api.waizytechengineering.com';
  static const String APP_PROD_DOMAIN = 'washryte.wtglaundrymgt.com';
  static const String API_ENDPOINT = '/api/v1/customer';
  static const String PUSHER_AUTH_URL = 'broadcasting/auth';
  static const String SLEEP = '/sleep';

  //.....///.....// AUTHENTICATION ENDPOINTS ....////././//...//
  static const String LOGIN = '/login';
  static const String REGISTER = '/register';
  static const String LOGOUT = '/logout';
  // RESET ASSWORD
  static const String SEND_PASSWORD_RESET_MESSAGE = '/forgot-password';
  static const String CONFIRM_PASSWORD_RESET = '/reset-password';
  static const String UPDATE_PASSWORD = '/user/update-password'; // (POST)
  // SOCIALS AUTH
  static const String GOOGLE_SIGNIN = '/auth/social/google';
  static const String APPLE_SIGNIN = '/auth/social/apple';

  /// .......///////...// USER ENDPOINTS .......///////./....//
  static const String GET_USER = '/';

  /// .......///////...// PROFILE ENDPOINTS .......///////./....//
  static const String UPDATE_USER_PROFILE = '/profile/update'; // (PATCH)
  static const String DELETE_USER_PROFILE = '/user/delete-account'; // (DELETE)

  /// .......///////...// SERVICE ENDPOINTS .......///////./....//
  static const String PLACE_AN_ORDER = '/orders'; // (DELETE)
  static const String FETCH_SINGLE_ORDER = '/orders/{id}'; // (DELETE)
  static const String TRACK_ORDER = '/orders/track'; // (DELETE)
  static const String FETCH_NOTIFICATIONS = '/notifications'; // (DELETE)
  static const String FETCH_ORDER_HISTORY = '/orders/history'; // (DELETE)
  static const String PAY_FOR_ORDER = '/orders/{id}/pay'; // (DELETE)
  static const String FUND_WALLET = '/wallet/deposit'; // (DELETE)
  static const String CANCEL_ORDER = '/orders/{id}/cancel'; // (DELETE)

  //.....///.....// UTILITIES ENDPOINTS ....////././//...//
  static const String COUNTRIES = '/utilities/countries';
  static const String BANKS = '/banks';
  static const String CONTACT_SUPPORT = '/contact-support';
  static const String GET_FAQ = '/faq';
}
