import 'package:http/http.dart' as http;
import '../../../exports.dart';

class OtpRepository {
  Future activation(token, otp) async {
    print(otp);
    Uri endpoint = Uri.parse(Constants.restApiBaseUrl + '/auth/otp');

    try {
      var resp = await http.post(
        endpoint,
        headers: <String, String>{'Authorization': 'Bearer ' + token},
        body: {
          'otp': otp,
        },
      );
      if (resp.statusCode == 200) {
        var jsonData = jsonDecode(resp.body);

        if (jsonData['error'].toString() == 'false') {
          return true;
        } else {
          //Snack bar error message
        }

        return false;
      } else if (resp.statusCode == 401) {
        return null;
      } else {
        print(resp.statusCode);
        return null;
      }
    } catch (e) {
      String errorType = e.runtimeType.toString();
      if (errorType == 'SocketException') {
        Get.to(NotConnectedScreen());
      }
    }
  }
}
