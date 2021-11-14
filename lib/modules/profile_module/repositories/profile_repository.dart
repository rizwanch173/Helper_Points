import '../../../exports.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:io';

class ProfileRepository {
  Future<User?> getLogedUser(token) async {
    LoginController _loginController = LoginController();
    Uri endpoint = Uri.parse(Constants.restApiBaseUrl + '/me');

    try {
      var resp = await http.post(endpoint, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      });
      if (resp.statusCode == 200) {
        var jsonData = jsonDecode(resp.body);
        if (jsonData['error'].toString() == 'true') {
          Get.snackbar('Error', jsonData['message'],
              margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900]);
          return null;
        }
        var user = User(
          jsonData['id'].toString(),
          jsonData['email'].toString(),
          jsonData['name'].toString(),
          jsonData['first_name'].toString(),
          jsonData['last_name'].toString(),
          jsonData['avatar'].toString(),
          jsonData['verified'].toString(),
          jsonData['phonenumber'].toString(),
        );

        return user;
      } else if (resp.statusCode == 401) {
        _loginController.logout();
        print('error 401 from profile_repo GLU');
        return null;
      } else {
        print('unknown response code');
        print(resp.body);
        print(resp.statusCode);
        _loginController.logout();
        return null;
      }
    } catch (e) {
      String errorType = e.runtimeType.toString();
      if (errorType == 'SocketException') {
        Get.to(NotConnectedScreen());
      }
    }
    return null;
  }

  Future<User?> getUser(String token, String id) async {
    LoginController _loginController = Get.find<LoginController>();
    Uri endpoint = Uri.parse(Constants.restApiBaseUrl + '/user');
    try {
      var resp = await http.post(
        endpoint,
        body: {
          'uid': id.trim(),
        },
        headers: <String, String>{'Authorization': 'Bearer ' + token},
      );
      if (resp.statusCode == 200) {
        var jsonData = jsonDecode(resp.body);
        if (jsonData['error'].toString() == 'true') {
          Get.snackbar('Error', jsonData['message'],
              margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900]);
          return null;
        }
        var user = User(
          jsonData['data']['id'].toString(),
          jsonData['data']['email'].toString(),
          jsonData['data']['name'].toString(),
          jsonData['data']['first_name'].toString(),
          jsonData['data']['last_name'].toString(),
          jsonData['data']['avatar'].toString(),
          jsonData['data']['verified'].toString(),
          jsonData['data']['phonenumber'].toString(),
        );

        return user;
      } else if (resp.statusCode == 401) {
        _loginController.logout();
        return null;
      } else {
        print('unknown response code');
        print(resp.statusCode);
      }
    } catch (e) {
      String errorType = e.runtimeType.toString();
      if (errorType == 'SocketException') {
        Get.to(NotConnectedScreen());
      }
    }
    return null;
  }

  Future<String?> updateAvatar(
      {required File file,
      required String filename,
      required String token}) async {
    String endpoint = Constants.restApiBaseUrl + '/user/update/avatar';
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(endpoint),
      );
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
        "Content-type": "multipart/form-data"
      };
      request.files.add(
        http.MultipartFile(
          'avatar',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: filename,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
      request.headers.addAll(headers);

      final res = await request.send();
      final respStr = await res.stream.bytesToString();

      if (res.statusCode == 200) {
        final json = jsonDecode(respStr);
        final resp = json['data'];
        //print(json);
        if (json['error'].toString() == 'true') {
          Get.snackbar('Error', json['message'],
              margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900]);
          return null;
        } else {
          Get.snackbar('Success', json['message'],
              margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900]);
        }
        return resp['avatar_link'];
      }

      print(res.statusCode.toString());
      return null;
    } catch (e) {
      String errorType = e.runtimeType.toString();
      if (errorType == 'SocketException') {
        Get.to(NotConnectedScreen());
      }
      print(e.toString());
    }
    return null;
  }

  Future<User?> updateName({
    id,
    firstname,
    lastname,
    token,
  }) async {
    LoginController _loginController = Get.find<LoginController>();
    Uri endpoint = Uri.parse(Constants.restApiBaseUrl + '/user/update');
    try {
      var resp = await http.post(
        endpoint,
        body: {
          'id': id,
          'first_name': firstname,
          'last_name': lastname,
        },
        headers: <String, String>{'Authorization': 'Bearer ' + token},
      );
      if (resp.statusCode == 200) {
        var jsonData = jsonDecode(resp.body);
        if (jsonData['error'].toString() == 'true') {
          Get.snackbar('Error', jsonData['message'],
              margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900]);
          return null;
        }
        var user = User(
          jsonData['data']['id'].toString(),
          jsonData['data']['email'].toString(),
          jsonData['data']['name'].toString(),
          jsonData['data']['first_name'].toString(),
          jsonData['data']['last_name'].toString(),
          jsonData['data']['avatar'].toString(),
          jsonData['data']['verified'].toString(),
          jsonData['data']['identity_verified'].toString(),
        );

        return user;
      } else if (resp.statusCode == 401) {
        _loginController.logout();
        return null;
      } else {
        print('unknown response code');
        print(resp.statusCode);
      }
    } catch (e) {
      String errorType = e.runtimeType.toString();
      if (errorType == 'SocketException') {
        Get.to(NotConnectedScreen());
      }
    }
    return null;
  }

  Future<bool?> changePassword(
      String newPassword, String currentPassword) async {
    LoginController _loginController = Get.find<LoginController>();
    Uri endpoint = Uri.parse(Constants.restApiBaseUrl + '/auth/changepassword');
    try {
      var resp = await http.post(
        endpoint,
        body: {
          'password': newPassword,
          'current_password': currentPassword,
        },
        headers: <String, String>{
          'Authorization': 'Bearer ' + _loginController.token!
        },
      );
      if (resp.statusCode == 200) {
        var jsonData = jsonDecode(resp.body);
        if (jsonData['error'].toString() == 'true') {
          Get.snackbar('Error', jsonData['message'],
              margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900]);
          return false;
        }

        Get.snackbar('Success', jsonData['message'],
            margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900]);

        return true;
      } else if (resp.statusCode == 401) {
        _loginController.logout();
        return null;
      } else {
        print('unknown response code');
        print(resp.statusCode);
      }
    } catch (e) {
      String errorType = e.runtimeType.toString();
      if (errorType == 'SocketException') {
        Get.to(NotConnectedScreen());
      }
    }
    return false;
  }

  Future<IdentityVerification?> getVerification(String token) async {
    LoginController _loginController = Get.find<LoginController>();
    Uri endpoint = Uri.parse(Constants.restApiBaseUrl + '/kyc/get');
    try {
      var resp = await http.post(
        endpoint,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (resp.statusCode == 200) {
        var jsonData = jsonDecode(resp.body);

        if (jsonData['error'].toString() == 'true') {
          Get.snackbar('Error', jsonData['message'],
              margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900]);
          return null;
        }
        var verification = IdentityVerification(
          jsonData['data']['id'].toString(),
          jsonData['data']['user_id'].toString(),
          jsonData['data']['front'].toString(),
          jsonData['data']['back'].toString(),
          jsonData['data']['is_done'].toString(),
          jsonData['data']['message'].toString(),
          jsonData['data']['is_aproved'].toString(),
        );

        return verification;
      } else if (resp.statusCode == 401) {
        _loginController.logout();
        return null;
      } else {
        print('unknown response code');
        print(resp.body);
        print(resp.statusCode);
      }
    } catch (e) {
      String errorType = e.runtimeType.toString();
      if (errorType == 'SocketException') {
        Get.to(NotConnectedScreen());
      }
    }

    return null;
  }

  Future<IdentityVerification?> front(
      {required File file,
      required String filename,
      required String token}) async {
    Uri endpoint = Uri.parse(Constants.restApiBaseUrl + '/kyc/front');
    try {
      var request = http.MultipartRequest(
        'POST',
        endpoint,
      );
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
        "Content-type": "multipart/form-data"
      };
      request.files.add(
        http.MultipartFile(
          'front',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: filename,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
      request.headers.addAll(headers);

      final res = await request.send();
      final respStr = await res.stream.bytesToString();

      if (res.statusCode == 200) {
        final json = jsonDecode(respStr);
        final resp = json['data'];
        //print(json);
        if (json['error'].toString() == 'true') {
          Get.snackbar('Error', json['message'],
              margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900]);
          return null;
        } else {
          Get.snackbar('Success', json['message'],
              margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900]);
        }
        var verification = IdentityVerification(
          resp['id'].toString(),
          resp['user_id'].toString(),
          resp['front'].toString(),
          resp['back'].toString(),
          resp['is_done'].toString(),
          resp['message'].toString(),
          resp['is_aproved'].toString(),
        );

        return verification;
      }

      print(res.statusCode.toString());
      return null;
    } catch (e) {
      String errorType = e.runtimeType.toString();
      if (errorType == 'SocketException') {
        Get.to(NotConnectedScreen());
      }
      print(e.toString());
    }
    return null;
  }

  Future<IdentityVerification?> back(
      {required File file,
      required String filename,
      required String token}) async {
    Uri endpoint = Uri.parse(Constants.restApiBaseUrl + '/kyc/back');
    try {
      var request = http.MultipartRequest(
        'POST',
        endpoint,
      );
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
        "Content-type": "multipart/form-data"
      };
      request.files.add(
        http.MultipartFile(
          'back',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: filename,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
      request.headers.addAll(headers);

      final res = await request.send();
      final respStr = await res.stream.bytesToString();

      if (res.statusCode == 200) {
        final json = jsonDecode(respStr);
        final resp = json['data'];
        //print(json);
        if (json['error'].toString() == 'true') {
          Get.snackbar('Error', json['message'],
              margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900]);
          return null;
        } else {
          Get.snackbar('Success', json['message'],
              margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900]);
        }
        var verification = IdentityVerification(
          resp['id'].toString(),
          resp['user_id'].toString(),
          resp['front'].toString(),
          resp['back'].toString(),
          resp['is_done'].toString(),
          resp['message'].toString(),
          resp['is_aproved'].toString(),
        );

        return verification;
      }

      print(res.statusCode.toString());
      return null;
    } catch (e) {
      String errorType = e.runtimeType.toString();
      if (errorType == 'SocketException') {
        Get.to(NotConnectedScreen());
      }
      print(e.toString());
    }

    return null;
  }
}
