var this_year = DateTime.now().year.toString();

class AppConfig {
  static String copyright_text = "@JEEVANSATHIKENDRA " + this_year;
  static String app_name = "JEEVANSATHI KENDRA";

  // enter string purchase_code here
  static String purshase_code = 'xxxxx';

  // configure this
  static const bool HTTPS = true;

  static const DOMAIN_PATH = "matrimo.jeevansathikendra.com";

  //https://matrimo.jeevansathikendra.com/
  // do not configure these below
  static const String API_ENDPATH = "api";
  static const String PROTOCOL = HTTPS ? "https://" : "http://";
  static const String RAW_BASE_URL = "${PROTOCOL}${DOMAIN_PATH}";
  static const String BASE_URL = "${RAW_BASE_URL}/${API_ENDPATH}";
}
