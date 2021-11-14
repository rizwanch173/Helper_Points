import '../../../exports.dart';

class ForthItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10, left: 40, right: 40),
          width: double.infinity,
          child: Text(
            'And simply manage it all in one place.',
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
            'Send, spend and receive using your ${Constants.appName} and keep track of it all, wherever you are.',
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
