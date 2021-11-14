import '../../../exports.dart';

class FirstItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10, left: 40, right: 40),
          width: double.infinity,
          child: Text(
            '${Constants.appName}, the smart choice for your business payments.',
            style: TextStyle(
              ///color: Colors.grey,
              fontSize: 28,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
