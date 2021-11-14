import '../../../exports.dart';
import 'package:intl/intl.dart';

class DepositMethodsScreen extends StatefulWidget {
  @override
  _DepositMethodsScreenState createState() => _DepositMethodsScreenState();
}

class _DepositMethodsScreenState extends State<DepositMethodsScreen> {
  WalletsController _wlc = Get.find<WalletsController>();
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Add credit to your wallets',
            style: TextStyle(fontSize: 14),
          ),
        ),
        body: Container(
          child: GetBuilder<DepositMethodController>(builder: (controller) {
            return ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                for (Wallet? wallet in _wlc.userWallets)
                  ListTile(
                    leading: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 0.5, color: (Colors.grey[400])!),
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                        image: DecorationImage(
                          image: NetworkImage(
                              (wallet?.transferMethod?.thumbnail ?? '_')),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    title: Text(wallet?.transferMethod?.name ?? ''),
                    subtitle: Text(oCcy
                            .format(double.parse(wallet?.amount ?? '0'))
                            .toString() +
                        ' ' +
                        (wallet?.currency?.code ?? '').toString()),
                    onTap: () {
                      Get.off(UploadDepositScreen());
                    },
                  ),
              ],
            );

            // return Column(
            //   children: <Widget>[
            //     FutureBuilder(
            //         future: _dmc.getMethods(),
            //         builder:
            //             (BuildContext context, AsyncSnapshot snapshot) {
            //           if (snapshot.hasData == true ||
            //               controller.methodList.length > 0) {
            //             return SizedBox(
            //               height: 1,
            //             );
            //           }

            //           if (snapshot.hasData == false &&
            //               snapshot.connectionState ==
            //                   ConnectionState.waiting) {
            //             return Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: <Widget>[
            //                 SizedBox(
            //                   height:
            //                       MediaQuery.of(context).size.height /
            //                           3,
            //                   child: Center(
            //                     child: CircularProgressIndicator(),
            //                   ),
            //                 ),
            //               ],
            //             );
            //           }

            //           if (snapshot.hasData == false &&
            //               snapshot.connectionState ==
            //                   ConnectionState.done) {
            //             return Container(
            //               height:
            //                   MediaQuery.of(context).size.height * 0.85,
            //               padding: EdgeInsets.symmetric(),
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: <Widget>[
            //                   Center(
            //                     child: Icon(
            //                       Icons.tab_unselected,
            //                       color: Colors.grey,
            //                       size: 46,
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.all(20.0),
            //                     child: Text(
            //                       'Contact admin to release deposit methods data !',
            //                       style: TextStyle(
            //                         color: Colors.grey,
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             );
            //           }

            //           if (snapshot.hasError) {
            //             return Text('Something Went Wrong');
            //           }
            //           return Text('Something Went Wrong');
            //         }),
            //     for (DepositMethod method in controller.methodList)
            //       Container(
            //         width: double.infinity,
            //         margin: EdgeInsets.only(top: 10, bottom: 10),
            //         child: Card(
            //           color: Color(0xFFEEEEEE),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           child: Container(
            //             padding: EdgeInsets.all(10),
            //             child: ListTile(
            //               leading: Image.network(method.thumb),
            //               title: Text(
            //                 method.name,
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                     color: Colors.black45),
            //               ),
            //               onTap: () {
            //                 controller.setCurrentMethod(method);
            //                 Get.offAll(UploadDepositScreen());
            //               },
            //             ),
            //           ),
            //         ),
            //       ),
            //   ],
            // );
          }),
        ),
      ),
    );
  }
}
