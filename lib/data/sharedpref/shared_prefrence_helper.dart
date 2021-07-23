// Project imports:
import 'package:alanis/export.dart';

class PrefManger {
  static SharedPreferences _sharedPreference;

  /*======================================================== Save Login Data ===========================================*/

  static Future<bool> getFirstTime() async {
    _sharedPreference = await SharedPreferences.getInstance();
    return Future.value(_sharedPreference.getBool(LocalStorage.isFirstTime));
  }

  /*=================================================== get login data================================================= */

  static isFirstTime(bool isFirst) async {
    _sharedPreference = await SharedPreferences.getInstance();
    _sharedPreference.setBool(LocalStorage.isFirstTime, isFirst);
  }

  static saveAccessToken(String token) async {
    _sharedPreference = await SharedPreferences.getInstance();
    _sharedPreference.setString(LocalStorage.accessToken, token);
  }

  static Future<String> getAcessToken() async {
    _sharedPreference = await SharedPreferences.getInstance();
    return Future.value(_sharedPreference.getString(LocalStorage.accessToken));
  }

  static saveRoleID(String roleid) async {
    _sharedPreference = await SharedPreferences.getInstance();
    _sharedPreference.setString(LocalStorage.professional, roleid);
  }

  static Future<String> getRoleID() async {
    _sharedPreference = await SharedPreferences.getInstance();
    return Future.value(_sharedPreference.getString(LocalStorage.professional));
  }

  static saveRegisterData(LoginDataModel loginRepsonseModel) async {
    _sharedPreference = await SharedPreferences.getInstance();
    _sharedPreference.setString(
        LocalStorage.loginRepsonseModel, jsonEncode(loginRepsonseModel));
  }

  static Future<LoginDataModel> getRegisterData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> userMap;
    final String userStr = prefs.getString(LocalStorage.loginRepsonseModel);
    if (userStr != null) userMap = jsonDecode(userStr) as Map<String, dynamic>;
    if (userMap != null) {
      LoginDataModel user = LoginDataModel.fromJson(userMap);
      return user;
    }
    return null;
  }

  static saveRemberMeData({String email, String password}) async {
    _sharedPreference = await SharedPreferences.getInstance();
    _sharedPreference.setString(LocalStorage.email, email);
    _sharedPreference.setString(LocalStorage.password, password);
  }

  static Future<Map<String, String>> getRemberData() async {
    Map<String, String> data = Map<String, String>();
    _sharedPreference = await SharedPreferences.getInstance();
    data[LocalStorage.email] = _sharedPreference.getString(LocalStorage.email);
    data[LocalStorage.password] =
        _sharedPreference.getString(LocalStorage.password);
    return Future.value(data);
  }
}
