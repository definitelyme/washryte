mixin EndPoints {
  static const String APP_DOMAIN = 'pyo2023.net';
  static const String API_ENDPOINT = '/api/v1';
  static const String BASE_URL = 'https://$APP_DOMAIN$API_ENDPOINT';
  static const String PUSHER_AUTH_URL = 'https://$APP_DOMAIN/broadcasting/auth';
  static const String SLEEP = '/sleep';

  //.....///.....// AUTHENTICATION ENDPOINTS ....////././//...//
  static const String LOGIN = '/auth/login';
  static const String REGISTER = '/auth/register';
  static const String LOGOUT = '/auth/logout';
  // UPDATE PHONE
  static const String RESEND_PHONE_VERIFICATION = '/auth/verify/phone/resend';
  static const String CONFIRM_PHONE_VERIFICATION = '/auth/verify/phone';
  // RESET ASSWORD
  static const String SEND_PASSWORD_RESET_MESSAGE = '/auth/forgot-password';
  static const String CONFIRM_PASSWORD_RESET = '/auth/reset-password';
  static const String UPDATE_PASSWORD = '/user/password'; // (POST)
  // SOCIALS AUTH
  static const String GOOGLE_SIGNIN = '/auth/social/google';
  static const String FACEBOOK_SIGNIN = '/auth/social/facebook';
  static const String APPLE_SIGNIN = '/auth/social/apple';
  static const String TWITTER_SIGNIN = '/auth/social/twitter';

  /// .......///////...// USER ENDPOINTS .......///////./....//
  static const String GET_USER = '/user';
  static const String UPDATE_PHONE = '/profile/phone'; // (POST)
  static const String CONFIRM_UPDATE_PHONE = '/profile/phone'; // (PATCH)

  /// .......///////...// PROFILE ENDPOINTS .......///////./....//
  static const String UPDATE_USER_PROFILE = '/user'; // (PATCH)
  static const String DELETE_USER_PROFILE = '/user/delete-account'; // (DELETE)
  static const String ADD_LINKED_ACCOUNT = '/user/linked-accounts'; // (POST)
  static const String GET_LINKED_ACCOUNTS = '/user/linked-accounts'; // (GET)
  static const String INITIATE_2FA = '/user/two-factor-authentication'; // (POST)
  static const String VERIFY_2FA = '/user/two-factor-authentication'; // (PATCH)
  static const String GET_NOTIFICATION_SETTINGS = '/user/notification-settings'; // (GET)
  static const String ADD_NOTIFICATION_SETTING = '/user/notification-settings'; // (POST)

  /// .......///////...// POST ENDPOINTS .......///////./....//
  static const String GET_POSTS = '/posts'; // (GET)
  static const String GET_SINGLE_POST = '/posts/{id}'; // (GET)
  static const String SUGGEST_TOPICS = '/topics/{query}'; // (GET)
  static const String GET_POST_COMMENTS = '/posts/{id}/comment'; // (GET)
  static const String ADD_POST_COMMENT = '/posts/{id}/comment'; // (POST)
  static const String ADD_POST = '/posts'; // (POST)
  static const String UPDATE_POST = '/posts/{id}'; // (PATCH)
  static const String DELETE_POST = '/posts/{id}'; // (DELETE)
  static const String SHARE_A_POST = '/posts/{id}/share'; // (POST)
  static const String LIKE_A_POST = '/posts/{id}/like'; // (PATCH)
  static const String UNLIKE_A_POST = '/posts/{id}/unlike'; // (PATCH)

  /// .......///////...// STORIES ENDPOINTS .......///////./....//
  static const String ADD_NEW_STORY = '/stories'; // (POST)
  static const String GET_FOLLOWERS_STORY = '/stories?user=all'; // (GET)
  static const String GET_SINGLE_STORY = '/stories?user={id}'; // (GET)

  //.....///.....// UTILITIES ENDPOINTS ....////././//...//
  static const String COUNTRIES = '/utilities/countries';
  static const String BANKS = '/banks';
  static const String CONTACT_SUPPORT = '/contact-support';
  static const String GET_FAQ = '/faq';
}
