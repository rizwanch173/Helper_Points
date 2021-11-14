import '../../../exports.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();
  OtpController _otpController = Get.put(OtpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Your Activation Code'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            FormBuilder(
              key: _fbkey,
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    name: 'activation_code_field',
                    maxLines: 1,
                    obscureText: false,
                    decoration: InputDecoration(
                        labelText: 'Code', prefixIcon: Icon(Icons.vpn_key)),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        child: Text('Activate Account'),
                        onPressed: () async {
                          if (_fbkey.currentState!.saveAndValidate()) {
                            _otpController.activateOtp(_fbkey
                                .currentState!.value['activation_code_field']);
                          }
                        }),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
