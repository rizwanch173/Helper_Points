import '../../../exports.dart';

class SecondItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10, left: 40, right: 40),
          width: double.infinity,
          child: Text(
            'Send payments quicly to almost anyone.',
            style: TextStyle(
              ///color: Colors.grey,
              fontSize: 28,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 50, left: 40, right: 40),
          child: Text(
            'All you need is their email adress to send it to their ${Constants.appName} account.',
            style: TextStyle(
              ///color: Colors.grey,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
