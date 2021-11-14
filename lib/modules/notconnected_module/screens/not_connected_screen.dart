import '../../../exports.dart';
import 'dart:io';

class NotConnectedScreen extends StatefulWidget {
  NotConnectedScreen({Key? key}) : super(key: key);

  @override
  _NotConnectedScreenState createState() => _NotConnectedScreenState();
}

class _NotConnectedScreenState extends State<NotConnectedScreen> {
  checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //print('connected');
        Get.back();
      }
    } on SocketException catch (_) {
      //print('not connected');
      Get.snackbar('Error',
          'Not connected to the internet, check your wifi or data plan');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  Text('Not Connected'),
                  ElevatedButton(
                    onPressed: checkConnection,
                    child: Text('Check your internet connection'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
