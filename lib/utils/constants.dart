class Constants {
  //app
  static String appName = 'Helper Points'; // change 'phpWallet'
  static String restApiBaseUrl =
      'https://rst.helperpay.io/api'; // change 'https://developer.bitmetical.com/api'
  static String restApiProtocol = 'https'; // https or http
  static String webDashboardBaseUrl =
      'https://rst.helperpay.io/api'; // change 'https://developer.bitmetical.com/api'

  //minimum amount for fiat currency transactions
  static int minimumFiatTransfer = 10; // change 10

  //support
  static bool whatsAppSupport = true;
  static String whatsAppNumber = "+258850586843"; // change "+258850586843"
  static String whatsAppChatlink =
      Uri.encodeFull("https://wa.me/$whatsAppNumber?text=Hello, i need help");
  // static bool telegramSupport = false;
  // static String telegramChatlink = "";
}
