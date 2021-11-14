import '../../../exports.dart';
import 'package:intl/intl.dart';

class WithdrawalScreen extends StatefulWidget {
  @override
  _WithdrawalScreenState createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  WithdrawController _withdrawalController = Get.find<WithdrawController>();
  WalletsController _walletsController = Get.find<WalletsController>();

  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();
  final oCcy = new NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    super.initState();
    //await _withdrawalController.getMethodsForCurrency(controller.userWallets[index].currency.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff3160d6),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff0b1c26),
          child: GetBuilder<WithdrawController>(builder: (_withdraw) {
            return _withdraw.isLoading == false
                ? Icon(
                    Icons.send,
                    color: Color(0xff58778b),
                  )
                : CircularProgressIndicator();
          }),
          onPressed: () {
            if (_withdrawalController.isLoading == true) {
              return;
            }
            if (_fbkey.currentState!.saveAndValidate()) {
              _withdrawalController.submitWithdrawal(
                  (_walletsController.currentWallet?.id ?? '_'));
            }
          },
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.1,
            width: MediaQuery.of(context).size.width,
            color: Color(0xff3160d6),
            child: FormBuilder(
                key: _fbkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: [
                        Text(
                          'Withdraw',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              _walletsController
                                          .currentWallet?.currency?.isCrypto ==
                                      '1'
                                  ? _withdrawalController.amountToWithdraw
                                  : oCcy.format(double.parse(
                                      _withdrawalController.amountToWithdraw)),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 64,
                              ),
                            ),
                            Text(
                              _walletsController
                                      .currentWallet?.currency?.code ??
                                  '',
                              style: TextStyle(
                                color: Color(0xff749ad9),
                                fontSize: 32,
                              ),
                            )
                          ],
                        ),
                        Text(
                          'to',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 20, top: 20),
                                child: Text(
                                  (_walletsController
                                              .currentWallet
                                              ?.transferMethod
                                              ?.accontIdentifierMechanism ??
                                          '')
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white //Color(0xff749ad9),
                                      ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 20, top: 20),
                                child: Text(
                                  _walletsController.currentWallet
                                          ?.accontIdentifierMechanismValue ??
                                      '',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white //Color(0xff749ad9),
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
