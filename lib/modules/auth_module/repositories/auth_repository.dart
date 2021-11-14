import '../../../exports.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<String?> register(
    name,
    email,
    password,
    repeatPassword,
    contryCode,
    phoneNumber,
  ) async {
    Uri endpoint = Uri.parse(Constants.restApiBaseUrl + '/auth/register');
    try {
      var resp = await http.post(endpoint, body: {
        'name': name,
        'email': email.trim(),
        'password': password,
        'password_confirmation': repeatPassword,
        'phone': phoneNumber,
        'country_code': contryCode,
      } /*, headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',} */);
      //print('register repo');
      print(resp.statusCode);
      print(resp.body);
      if (resp.statusCode == 200) {
        var response = jsonDecode(resp.body);
        print(response['data']);
        if (response['error'].toString() == 'true') {
          Get.snackbar('Error', response['message'],
              margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900]);
          return null;
        }
        return response['data']['access_token'];
      } else if (resp.statusCode == 401) {
        Get.snackbar('Error', '404',
            margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900]);
        return null;
      } else {
        Get.snackbar('Error', resp.statusCode.toString(),
            margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900]);
        print(resp.statusCode);
        return null;
      }
    } catch (e) {
      String errorType = e.runtimeType.toString();
      if (errorType == 'SocketException') {
        //Make a connected / not connected state true / false ;
        Get.to(NotConnectedScreen());
      }
    }
    return null;
  }

  Future<String?> login(email, password) async {
    Uri endpoint = Uri.parse(Constants.restApiBaseUrl + '/auth/login');

    try {
      var resp = await http.post(endpoint, body: {
        'email': email.trim(),
        'password': password
      } /*, headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',} */);
      if (resp.statusCode == 200) {
        var response = jsonDecode(resp.body);
        return response['data']['access_token'];
      } else if (resp.statusCode == 401) {
        return null;
      } else {
        print(resp.statusCode);
      }
    } catch (e) {
      String errorType = e.runtimeType.toString();
      if (errorType == 'SocketException') {
        //Make a connected / not connected state true / false ;
        Get.to(NotConnectedScreen());
      }
    }
    return null;
  }
}
