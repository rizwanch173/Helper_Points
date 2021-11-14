import '../../../exports.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();

  final _loginController = Get.find<LoginController>();
  final _loadingController = Get.find<LoadingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
        backgroundColor: Colors.white, // Color(0xFF102839),
        actions: <Widget>[
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'New User ?',
                style: TextStyle(
                  color: Color(0xFF305fd6),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            onTap: () {
              Get.to(RegisterScreen());
            },
          )
        ],
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 40, right: 40),
          color: Colors.white, // Color(0xFF102839),
          height: MediaQuery.of(context).size.height / 1.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      width: double.infinity,
                      child: Text(
                        'Log in to your account & check your wealth',
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
              Container(
                child: FormBuilder(
                  key: _fbkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FormBuilderTextField(
                        name: 'emailfield',
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
                        name: 'passwordfield',
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
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xFF305fd6),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            elevation: MaterialStateProperty.all(0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text('Login'),
                          ),
                          onPressed: () async {
                            if (_fbkey.currentState!.saveAndValidate()) {
                              _loginController.login(
                                  _fbkey.currentState?.value['emailfield'],
                                  _fbkey.currentState?.value['passwordfield']);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
