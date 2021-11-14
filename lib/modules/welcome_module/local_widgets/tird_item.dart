import '../../../exports.dart';

class TirdItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10, left: 40, right: 40),
          width: double.infinity,
          child: Text(
            'Shop more securely on sites and apps ',
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
            'Skip entering your account details when you pay with ${Constants.appName} by just scanning QrCodes',
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
