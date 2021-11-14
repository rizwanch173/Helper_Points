import '../../../exports.dart';
import 'package:intl/intl.dart';

class SendScreen extends StatefulWidget {
  @override
  _SendScreenState createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  WalletsController _walletsController = Get.put(WalletsController());
  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();
  final oCcy = new NumberFormat("#,##0.00", "en_US");

  SendController _sendController = Get.put(SendController());
  ProfileController _profileController = Get.put(ProfileController());

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
          child: GetBuilder<SendController>(builder: (_send) {
            return _send.isLoading == false
                ? Icon(
                    Icons.send,
                    color: Color(0xff58778b),
                  )
                : CircularProgressIndicator();
          }),
          onPressed: () async {
            if (_sendController.isLoading == true) {
              return;
            }
            if (_fbkey.currentState!.saveAndValidate()) {
              var comment =
                  _fbkey.currentState!.value['note_to_receiver_field'];
              var email;
              if (_sendController.sendTo?.id ==
                  _profileController.loggedUser?.id) {
                email = _fbkey.currentState!.value['receiver_email_field'];
              } else {
                email = _sendController.sendTo?.email;
              }

              await _sendController.submitTransfer(
                  comment,
                  email,
                  _walletsController.amountToTransfer,
                  (_walletsController.currentWallet?.currency?.id ?? '0'));
            }
          },
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xff3160d6),
            height: MediaQuery.of(context).size.height / 1.1,
            width: MediaQuery.of(context).size.width,
            child: FormBuilder(
              key: _fbkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: [
                      Text(
                        'Send',
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
                                ? _walletsController.amountToTransfer
                                : oCcy.format(
                                    double.parse(
                                      _walletsController.amountToTransfer,
                                    ),
                                  ),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 64,
                            ),
                          ),
                          Text(
                            _walletsController.currentWallet?.currency?.code ??
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
                  _sendController.sendTo?.id ==
                          _profileController.loggedUser?.id
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 20.0),
                              child: Text(
                                'Receiver email',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: FormBuilderTextField(
                                name: 'receiver_email_field',
                                maxLines: 1,
                                obscureText: false,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  //focusedBorder: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 0.0,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xfff5a623),
                                      width: 2,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xfff5a623),
                                      width: 2,
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderSide: const BorderSide(
                                      color: Colors.blue,
                                      width: 0.0,
                                    ),
                                  ),
                                  // labelText: _walletsController.currenctWallet.currency.symbol,
                                  labelStyle: new TextStyle(
                                    color: Colors.blue,
                                  ),
                                  errorStyle: TextStyle(
                                      color: Color(0xfff5a623),
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.italic),
                                  //focusedBorder: InputBorder.none,
                                  labelText: 'Type here ...',
                                  prefixIcon: Icon(
                                    Icons.alternate_email,
                                    color: Colors.blue,
                                  ),
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.email(context),
                                  FormBuilderValidators.required(context),
                                ]),
                              ),
                            ),
                          ],
                        )
                      : Column(
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
                                      (_sendController.sendTo?.avatar ?? '_')),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              '@' + (_sendController.sendTo?.name ?? ''),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 20.0),
                        child: Text(
                          _sendController.sendTo?.id ==
                                  _profileController.loggedUser?.id
                              ? 'Note to Receiver'
                              : 'Note to @' +
                                  (_sendController.sendTo?.name ?? ''),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: FormBuilderTextField(
                          name: 'note_to_receiver_field',
                          maxLines: 10,
                          obscureText: false,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            //focusedBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 0.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xfff5a623),
                                width: 2,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xfff5a623),
                                width: 2,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(
                                color: Colors.blue,
                                width: 0.0,
                              ),
                            ),
                            // labelText: _walletsController.currenctWallet.currency.symbol,
                            labelStyle: new TextStyle(
                              color: Colors.blue,
                            ),
                            errorStyle: TextStyle(
                                color: Color(0xfff5a623),
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic),
                            //focusedBorder: InputBorder.none,
                            labelText: 'Type here ...',
                            prefixIcon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
