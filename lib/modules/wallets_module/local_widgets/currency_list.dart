import '../../../exports.dart';

class CurrencyList extends StatefulWidget {
  @override
  _CurrencyListState createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList> {
  //WalletsController _walletController = Get.find<WalletsController>();
  WalletsController _walletController = Get.put(WalletsController());
  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            EdgeInsets.only(left: 20.0, top: 5.0, right: 20.0, bottom: 5.0),
        height: 70,
        color: Colors.white,
        child: GetBuilder<WalletsController>(builder: (controller) {
          return ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              for (Wallet? wallet in _walletController.userWallets)
                Container(
                  margin:
                      EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      _walletController.setCurrentWallet((wallet?.id ?? '0'));
                    },
                    child: Row(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text(
                          wallet?.currency?.code ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _walletController.currentWallet?.id ==
                                    wallet?.id
                                ? Colors.white
                                : Colors.blue,
                          ),
                        ),
                      ),
                      Text(
                        wallet?.currency?.isCrypto == '0'
                            ? oCcy.format(double.parse(wallet?.amount ?? '0'))
                            : double.parse(wallet?.amount ?? '0').toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color:
                              _walletController.currentWallet?.id == wallet?.id
                                  ? Colors.white
                                  : Colors.grey,
                        ),
                      ),
                    ]),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        _walletController.currentWallet?.id == wallet?.id
                            ? Colors.blue
                            : Colors.grey[100],
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      elevation: MaterialStateProperty.all(0),
                    ),
                  ), //Color(0xfff5a623)
                )
            ],
          );
        }));
    // return GetBuilder<WalletsController>(builder: (controller) {
    //   return ListView.builder(itemBuilder: null);
    // });
  }
}
