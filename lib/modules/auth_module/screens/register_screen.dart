import '../../../exports.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();

  RegisterController _registerController = Get.find<RegisterController>();
  LoadingController _loadingController = Get.find<LoadingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white, // Color(0xFF102839),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0), // here the desired height
          child: Obx(
            () => _loadingController.isLoading.value == 1
                ? LinearProgressIndicator()
                : PreferredSize(
                    preferredSize:
                        Size.fromHeight(0.1), // here the desired height
                    child: SizedBox(),
                  ),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white, //Color(0xFF102839),

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  left: 40,
                  right: 40,
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      width: double.infinity,
                      child: Text(
                        'Great men always kept records of their coin.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 5,
                      color: Color(0xFF305fd6),
                      margin: EdgeInsets.only(top: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 250,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 40,
                  right: 40,
                ),
                child: Center(
                  child: FormBuilder(
                    key: _fbkey,
                    child: Column(
                      children: <Widget>[
                        FormBuilderTextField(
                          name: 'name_field',
                          maxLines: 1,
                          obscureText: false,
                          style: TextStyle(
                            color: Color(0xFF305fd6),
                          ),
                          decoration: InputDecoration(
                            //focusedBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xfff5a623),
                                width: 0.5,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xfff5a623),
                                width: 0.5,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            // labelText: _walletsController.currenctWallet.currency.symbol,
                            labelStyle: new TextStyle(
                              color: Color(0xFF305fd6),
                            ),
                            errorStyle: TextStyle(
                                color: Color(0xfff5a623),
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic),
                            //focusedBorder: InputBorder.none,
                            labelText: 'Username',
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FormBuilderTextField(
                          name: 'email_field',
                          maxLines: 1,
                          obscureText: false,
                          style: TextStyle(
                            color: Color(0xFF305fd6),
                          ),
                          decoration: InputDecoration(
                            //focusedBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xfff5a623),
                                width: 0.5,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xfff5a623),
                                width: 0.5,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            // labelText: _walletsController.currenctWallet.currency.symbol,
                            labelStyle: new TextStyle(
                              color: Color(0xFF305fd6),
                            ),
                            errorStyle: TextStyle(
                                color: Color(0xfff5a623),
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic),
                            //focusedBorder: InputBorder.none,
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.grey,
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.email(context),
                            FormBuilderValidators.required(context),
                          ]),
                        ),
                        SizedBox(height: 20),
                        FormBuilderTextField(
                          name: 'password_field',
                          maxLines: 1,
                          obscureText: true,
                          style: TextStyle(
                            color: Color(0xFF305fd6),
                          ),
                          decoration: InputDecoration(
                            //focusedBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xfff5a623),
                                width: 0.5,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xfff5a623),
                                width: 0.5,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            // labelText: _walletsController.currenctWallet.currency.symbol,
                            labelStyle: new TextStyle(
                              color: Color(0xFF305fd6),
                            ),
                            errorStyle: TextStyle(
                                color: Color(0xfff5a623),
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic),
                            //focusedBorder: InputBorder.none,
                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock_open,
                              color: Colors.grey,
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                        ),
                        SizedBox(height: 20),
                        FormBuilderTextField(
                          name: 'repeat_password_field',
                          maxLines: 1,
                          obscureText: true,
                          style: TextStyle(
                            color: Color(0xFF305fd6),
                          ),
                          decoration: InputDecoration(
                            //focusedBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xfff5a623),
                                width: 0.5,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xfff5a623),
                                width: 0.5,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            // labelText: _walletsController.currenctWallet.currency.symbol,
                            labelStyle: new TextStyle(
                              color: Color(0xFF305fd6),
                            ),
                            errorStyle: TextStyle(
                                color: Color(0xfff5a623),
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic),
                            //focusedBorder: InputBorder.none,
                            labelText: 'Repeat password',
                            prefixIcon: Icon(
                              Icons.lock_open,
                              color: Colors.grey,
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 140,
                              child: CountryCodePicker(
                                onChanged: (value) {
                                  _registerController.changePhonePrefix(
                                      value.dialCode ?? '+1');
                                  _registerController
                                      .changeCountryCode(value.code ?? 'US');
                                },
                                onInit: (value) {
                                  _registerController.changePhonePrefix(
                                      value?.dialCode ?? '+1');
                                  _registerController
                                      .changeCountryCode(value?.code ?? 'US');
                                },
                              ),
                            ),
                            Expanded(
                              child: FormBuilderTextField(
                                name: 'phone_number_field',
                                maxLines: 1,
                                style: TextStyle(
                                  color: Color(0xFF305fd6),
                                ),
                                decoration: InputDecoration(
                                  //focusedBorder: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 0.5,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xfff5a623),
                                      width: 0.5,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xfff5a623),
                                      width: 0.5,
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 0.5,
                                    ),
                                  ),
                                  // labelText: _walletsController.currenctWallet.currency.symbol,
                                  labelStyle: new TextStyle(
                                    color: Color(0xFF305fd6),
                                  ),
                                  errorStyle: TextStyle(
                                      color: Color(0xfff5a623),
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.italic),
                                  //focusedBorder: InputBorder.none,
                                  labelText: 'Phone number',
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                ]),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(() {
                          if (_loadingController.isLoading.value == 1) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(20),
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(),
                                ),
                              ],
                            );
                          } else {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Color(0xFFf5a623),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    elevation: MaterialStateProperty.all(0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text('Sign Up'),
                                  ),
                                  onPressed: () async {
                                    if (_fbkey.currentState!
                                        .saveAndValidate()) {
                                      _registerController.register(
                                          _fbkey.currentState!
                                              .value['name_field'],
                                          _fbkey.currentState!
                                              .value['email_field'],
                                          _fbkey.currentState!
                                              .value['password_field'],
                                          _fbkey.currentState!
                                              .value['repeat_password_field'],
                                          _registerController.countryCode,
                                          _registerController.phonePrefix +
                                              _fbkey.currentState!
                                                  .value['phone_number_field']);
                                    }
                                  }),
                            );
                          }
                        }),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: InkWell(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'I already have an account ?',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () => Get.to(LoginScreen()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 150,
              )
            ],
          ),
        ),
      ),
    );
  }
}
