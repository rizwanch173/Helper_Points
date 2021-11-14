import '../../../exports.dart';
import 'package:intl/intl.dart';

class WithdrawalAmountForm extends StatefulWidget {
  @override
  _WithdrawalAmountFormState createState() => _WithdrawalAmountFormState();
}

class _WithdrawalAmountFormState extends State<WithdrawalAmountForm> {
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  WalletsController _walletsController = Get.find<WalletsController>();
  WithdrawController _withdrawalController = Get.find<WithdrawController>();
  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: 240,
          padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Withdraw',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        // color: Color(0xff3160d6),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Available ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        GetBuilder<WalletsController>(builder: (_wallets) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 2),
                            child: Text(
                              _wallets.currentWallet?.currency?.isCrypto == '0'
                                  ? oCcy.format(double.parse(
                                      _wallets.currentWallet?.amount ?? '0'))
                                  : double.parse(
                                          _wallets.currentWallet?.amount ?? '0')
                                      .toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }),
                        GetBuilder<WalletsController>(builder: (_wallets) {
                          return Text(
                            _wallets.currentWallet?.currency?.code ?? '',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          );
                        }),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 4.0),
                        //   child: InkWell(
                        //     child: Icon(
                        //       Icons.arrow_drop_down,
                        //       color: Colors.blue,
                        //     ),
                        //     onTap: () {},
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FormBuilder(
                    key: _fbkey,
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.only(bottom: 20),
                      child: GetBuilder<WalletsController>(builder: (_wallets) {
                        return FormBuilderTextField(
                          key: UniqueKey(),
                          initialValue: _wallets.amountToTransfer,
                          name: 'amountfield',
                          maxLines: 1,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: (_walletsController
                                        .currentWallet?.currency?.code ??
                                    '') +
                                ' Amount',
                            //focusedBorder: InputBorder.none,
                            // prefixIcon: Icon(
                            //   Icons.attach_money,
                            // ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.numeric(context),
                            //FormBuilderValidators.minLength(1),
                            _walletsController
                                        .currentWallet?.currency?.isCrypto ==
                                    '1'
                                ? FormBuilderValidators.min(context, 0)
                                : FormBuilderValidators.min(
                                    context, Constants.minimumFiatTransfer),
                            FormBuilderValidators.max(
                              context,
                              double.parse(
                                  _walletsController.currentWallet?.amount ??
                                      '0'),
                            ),
                            FormBuilderValidators.required(context),
                          ]),
                        );
                      }),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0),
                      ),
                      child: Icon(
                        Icons.east,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (_fbkey.currentState!.saveAndValidate()) {
                          var amount =
                              _fbkey.currentState!.value['amountfield'];
                          if (double.parse(amount) == 0) {
                            Get.snackbar(
                                'Error', 'The amount must be greater than 0',
                                margin: EdgeInsets.only(
                                    bottom: 50.0, left: 20.0, right: 20.0),
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white,
                                backgroundColor: Colors.grey[900]);
                            return;
                          }
                          _walletsController.setAmountToTransfer(amount);
                          _withdrawalController.setAmountToWithdraw(amount);
                          Get.to(WithdrawalScreen());
                        }
                      },
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[200]),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _walletsController.setAmountToTransfer('50');
                    },
                    child: Text(
                      '50',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[200]),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _walletsController.setAmountToTransfer('100');
                    },
                    child: Text(
                      '100',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[200]),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _walletsController.setAmountToTransfer('150');
                    },
                    child: Text(
                      '150',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[200]),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _walletsController.setAmountToTransfer('200');
                    },
                    child: Text(
                      '200',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
