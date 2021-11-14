import '../../../exports.dart';
import 'package:intl/intl.dart';

class WalletsList extends StatefulWidget {
  @override
  _WalletsListState createState() => _WalletsListState();
}

class _WalletsListState extends State<WalletsList> {
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  //WalletsController _walletsController = Get.find<WalletsController>();
  WalletsController _walletsController = Get.find<WalletsController>();
  @override
  void initState() {
    super.initState();
    _walletsController.getWallets();
    //_withdrawalController
    //.getMethodsForCurrency(_walletsController.currenctWallet.currencyId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletsController>(
      builder: (controller) {
        if (controller.userWallets.length > 0) {
          return SizedBox(
            height: 182,
            child: Container(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.userWallets.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < controller.userWallets.length) {
                    return Container(
                      margin: const EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, top: 20, bottom: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff3160d6),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.userWallets[index]
                                                  ?.currency?.name ??
                                              '',
                                          style: TextStyle(
                                            color: Colors
                                                .white, //Color(0xff749ad9),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),

                                        // ElevatedButton(
                                        //   style: ButtonStyle(
                                        //     backgroundColor:
                                        //         MaterialStateProperty.all(
                                        //       Color(0xfff5a623),
                                        //     ),
                                        //     elevation: MaterialStateProperty.all(0),
                                        //     shape: MaterialStateProperty.all(
                                        //       RoundedRectangleBorder(
                                        //         borderRadius:
                                        //             BorderRadius.circular(20),
                                        //       ),
                                        //     ),
                                        //   ),
                                        //   child: Text(
                                        //     'Withdraw',
                                        //     style: TextStyle(
                                        //         color: Color(
                                        //             0xff3160d6), //Color(0xfff5a623),
                                        //         fontWeight: FontWeight.normal,
                                        //         fontSize: 14),
                                        //   ),
                                        //   onPressed: () async {
                                        //     controller.setCurrentWallet(
                                        //         controller.userWallets[index].id);
                                        //     //
                                        //     Get.bottomSheet(WithdrawalAmountForm());
                                        //   },
                                        // )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Balance',
                                              style: TextStyle(
                                                color: Color(0xff749ad9),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Container(
                                              margin: EdgeInsets.only(top: 23),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  controller
                                                              .userWallets[
                                                                  index]
                                                              ?.currency
                                                              ?.isCrypto ==
                                                          '1'
                                                      ? Text(
                                                          double.parse(controller
                                                                      .userWallets[
                                                                          index]
                                                                      ?.amount ??
                                                                  '0')
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )
                                                      : Text(
                                                          oCcy.format(double
                                                              .parse(controller
                                                                      .userWallets[
                                                                          index]
                                                                      ?.amount ??
                                                                  '0')),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    controller
                                                            .userWallets[index]
                                                            ?.currency
                                                            ?.symbol ??
                                                        '',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff749ad9),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 24),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 20, color: Colors.white),
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Container(
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.5,
                                              color: (Colors.grey[100])!),
                                          shape: BoxShape.circle,
                                          color: Theme.of(context).primaryColor,
                                          image: DecorationImage(
                                            image: NetworkImage((controller
                                                    .userWallets[index]
                                                    ?.transferMethod
                                                    ?.thumbnail ??
                                                'NetworkImage_wallets_list.dart')),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.only(
                        left: 0.0,
                        right: 20.0,
                      ),
                      height: 50,
                      //width: MediaQuery.of(context).size.width * 0.4,
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 0, bottom: 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white //Color(0xff3160d6),
                          ),
                      child: InkWell(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Icon(
                                Icons.add_circle,
                                size: 64,
                                color: Color(0xfff5a623), //Color(0xff0b1c26)
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 10.0),
                            //   child: Text(
                            //     'Add Credit',
                            //     style: TextStyle(
                            //       color: Colors.white,
                            //       fontSize: 24,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        onTap: () {
                          Get.to(TransferMethodsScreen());
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          );
        } else if (controller.userWallets.length <= 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                height: 181,
                child: Center(
                  child: SizedBox(
                    child: RefreshProgressIndicator(),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                height: 50,
                //width: MediaQuery.of(context).size.width * 0.4,

                child: ElevatedButton(
                  onPressed: () {
                    Get.to(TransferMethodsScreen());
                  },
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Icon(Icons.add)),
                      Text('Create a new wallet'),
                    ],
                  ),
                ),
              )
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
//  final oCcy = new NumberFormat("#,##0.00", "en_US");

//   print("Eg. 1: ${oCcy.format(123456789.75)}");
//   print("Eg. 2: ${oCcy.format(.7)}");
//   print("Eg. 3: ${oCcy.format(12345678975/100)}");
//   print("Eg. 4: ${oCcy.format(int.parse('12345678975')/100)}");
//   print("Eg. 5: ${oCcy.format(double.parse('123456789.75'))}");
