import '../../../exports.dart';

class OverviewScreen extends StatefulWidget {
  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 30),
              //color: Color(0xff0b1c26),
              color: Theme.of(context).primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      bottom: 20,
                    ),
                    // child: Text(
                    //   'Wallet overview',
                    //   style: TextStyle(
                    //     color: Color(0xff3160d6),
                    //     fontWeight: FontWeight.normal,
                    //     fontSize: 14,
                    //   ),
                    // ), //Color(0xfff5a623)
                  ),
                  WalletsList(),
                ],
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
            //   child: SizedBox(
            //     width: double.infinity,
            //     child: ElevatedButton(
            //       style: ButtonStyle(
            //         backgroundColor:
            //             MaterialStateProperty.all(Color(0xfff5a623)),
            //         shape: MaterialStateProperty.all(
            //           RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //         ),
            //         elevation: MaterialStateProperty.all(0),
            //       ),
            //       child: Padding(
            //         padding: const EdgeInsets.all(20.0),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: <Widget>[
            //             Text(
            //               'Send money',
            //               style: TextStyle(
            //                   color: Colors.white, fontWeight: FontWeight.bold),
            //             ),
            //           ],
            //         ),
            //       ),
            //       onPressed: () {
            //         Get.to(SendScreen());
            //       },
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            // Container(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       SizedBox(
            //         width: 120,
            //         child: ElevatedButton(
            //           style: ButtonStyle(
            //             shape: MaterialStateProperty.all(
            //               RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.horizontal(
            //                   left: Radius.circular(20),
            //                   right: Radius.zero,
            //                 ),
            //               ),
            //             ),
            //             backgroundColor: MaterialStateProperty.all(
            //               Color(0xfff5a623),
            //             ),
            //             side: MaterialStateProperty.all(
            //               BorderSide(color: Color(0xfff5a623), width: 2),
            //             ),
            //             elevation: MaterialStateProperty.all(0),
            //           ),
            //           child: Text(
            //             'Deposits',
            //             style: TextStyle(
            //               color: Color(0xff3160d6),
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           onPressed: () {},
            //         ),
            //       ),
            //       SizedBox(
            //         width: 120,
            //         child: ElevatedButton(
            //           style: ButtonStyle(
            //             shape: MaterialStateProperty.all(
            //               RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.horizontal(
            //                   right: Radius.circular(20),
            //                   left: Radius.zero,
            //                 ),
            //               ),
            //             ),
            //             backgroundColor: MaterialStateProperty.all(
            //               Colors.white,
            //             ),
            //             side: MaterialStateProperty.all(
            //               BorderSide(color: Color(0xfff5a623), width: 2),
            //             ),
            //             elevation: MaterialStateProperty.all(0),
            //           ),
            //           child: Text(
            //             'Withdawals',
            //             style: TextStyle(
            //               color: Color(0xff3160d6),
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           onPressed: () {},
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            OverviewPages(),
          ],
        ),
      ),
    );
  }
}
