import '../../../exports.dart';

class SendAmountForm extends StatefulWidget {
  @override
  _SendAmountFormState createState() => _SendAmountFormState();
}

class _SendAmountFormState extends State<SendAmountForm> {
  ProfileController _profileController = Get.find<ProfileController>();
  WalletsController _walletsController = Get.find<WalletsController>();
  SendController _sendController = Get.find<SendController>();
  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 490,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GetBuilder<SendController>(
            builder: (_send) => _send.sendTo?.id !=
                    _profileController.loggedUser?.id
                ? Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                      height: 223,
                      width: double.infinity,
                      child: GetBuilder<ProfileController>(builder: (_profile) {
                        if (_profile.isLoading == true ||
                            _send.isLoading == true) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [CircularProgressIndicator()],
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: (Colors.grey[400])!),
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        (_send.sendTo?.avatar ?? '_')),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '@' + (_send.sendTo?.name ?? ''),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          );
                        }
                      }),
                    ),
                  )
                : SizedBox(
                    height: 1,
                  ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              height: 240,
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
                          'Send Money',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            //color: Theme.of(context).primaryColor,
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
                            GetBuilder<WalletsController>(
                                builder: (controller) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 2),
                                child: Text(
                                  controller.currentWallet?.currency
                                              ?.isCrypto ==
                                          '0'
                                      ? oCcy.format(double.parse(
                                          controller.currentWallet?.amount ??
                                              '0'))
                                      : double.parse(controller
                                                  .currentWallet?.amount ??
                                              '0')
                                          .toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }),
                            GetBuilder<WalletsController>(
                                builder: (controller) {
                              return InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    controller.currentWallet?.currency?.code ??
                                        '',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Get.bottomSheet(
                                    CurrencyList(),
                                  );
                                },
                              );
                            }),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: InkWell(
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onTap: () {
                                  Get.bottomSheet(
                                    CurrencyList(),
                                  );
                                },
                              ),
                            ),
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
                          padding: EdgeInsets.only(bottom: 20),
                          width: 100,
                          child: FormBuilderTextField(
                            key: UniqueKey(),
                            initialValue: _walletsController.amountToTransfer,
                            name: 'amountfield',
                            maxLines: 1,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: _walletsController
                                      .currentWallet?.currency?.code ??
                                  '' + ' Amount',
                              //focusedBorder: InputBorder.none,
                              // prefixIcon: Icon(
                              //   Icons.attach_money,
                              // )
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
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
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
                            if (_sendController.isLoading == true ||
                                _profileController.isLoading == true) {
                              Get.snackbar('Loading ...', 'Please whait !',
                                  margin: EdgeInsets.only(
                                      top: 50.0, left: 20.0, right: 20.0),
                                  snackPosition: SnackPosition.TOP,
                                  colorText: Colors.white,
                                  backgroundColor: Colors.grey[900]);
                              return;
                            }
                            if (_fbkey.currentState!.saveAndValidate()) {
                              var amount =
                                  _fbkey.currentState!.value['amountfield'];
                              if (double.parse(amount) == 0) {
                                Get.snackbar('Error',
                                    'The amount must be greater than 0',
                                    margin: EdgeInsets.only(
                                        bottom: 50.0, left: 20.0, right: 20.0),
                                    snackPosition: SnackPosition.BOTTOM,
                                    colorText: Colors.white,
                                    backgroundColor: Colors.grey[900]);
                                return;
                              }
                              _walletsController.setAmountToTransfer(amount);
                              //_withdrawalController.setAmountToWithdraw(amount);
                              Get.to(SendScreen());
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
                          setState(() {
                            _walletsController.amountToTransfer = '50';
                          });
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
                          setState(() {
                            _walletsController.amountToTransfer = '100';
                          });
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
                          setState(() {
                            _walletsController.amountToTransfer = '150';
                          });
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
                          setState(() {
                            _walletsController.amountToTransfer = '200';
                          });
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
        ],
      ),
    );
  }
}
