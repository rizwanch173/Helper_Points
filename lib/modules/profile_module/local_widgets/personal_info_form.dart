import '../../../exports.dart';

class PersonalInfoForm extends StatefulWidget {
  @override
  _PersonalInfoFormState createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  final GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();
  ProfileController _profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: FormBuilder(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FormBuilderTextField(
              readOnly: true,
              name: 'email_field',
              maxLines: 1,
              initialValue: _profileController.loggedUser?.email,
              obscureText: false,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                //focusedBorder: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
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
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                // labelText: _walletsController.currenctWallet.currency.symbol,
                labelStyle: new TextStyle(
                  color: Colors.grey,
                ),
                errorStyle: TextStyle(
                    color: Color(0xfff5a623),
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic),
                //focusedBorder: InputBorder.none,
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 20),
            FormBuilderTextField(
              readOnly: true,
              name: 'phone_field',
              maxLines: 1,
              initialValue: _profileController.loggedUser?.phonenumber,
              obscureText: false,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                //focusedBorder: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
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
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                // labelText: _walletsController.currenctWallet.currency.symbol,
                labelStyle: new TextStyle(
                  color: Colors.grey,
                ),
                errorStyle: TextStyle(
                    color: Color(0xfff5a623),
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic),
                //focusedBorder: InputBorder.none,
                labelText: 'Phone Number',
              ),
              validator: FormBuilderValidators.compose([]),
            ),
            const SizedBox(height: 20),
            FormBuilderTextField(
              readOnly: _profileController.loggedUser?.firstName == 'null'
                  ? false
                  : true,
              name: 'first_name_field',
              maxLines: 1,
              initialValue: _profileController.loggedUser?.firstName == 'null'
                  ? null
                  : _profileController.loggedUser?.firstName,
              obscureText: false,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                //focusedBorder: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
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
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                // labelText: _walletsController.currenctWallet.currency.symbol,
                labelStyle: new TextStyle(
                  color: Colors.grey,
                ),
                errorStyle: TextStyle(
                    color: Color(0xfff5a623),
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic),
                //focusedBorder: InputBorder.none,
                labelText: 'First Name',
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
              ]),
            ),
            const SizedBox(height: 20),
            FormBuilderTextField(
              readOnly: _profileController.loggedUser?.lastName == 'null'
                  ? false
                  : true,
              name: 'last_name_field',
              initialValue: _profileController.loggedUser?.lastName == 'null'
                  ? null
                  : _profileController.loggedUser?.lastName,
              maxLines: 1,
              obscureText: false,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                //focusedBorder: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
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
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                // labelText: _walletsController.currenctWallet.currency.symbol,
                labelStyle: new TextStyle(
                  color: Colors.grey,
                ),
                errorStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic),
                //focusedBorder: InputBorder.none,
                labelText: 'Last Name',
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
              ]),
            ),
            const SizedBox(height: 20),
            GetBuilder<ProfileController>(
              builder: (_profile) {
                return Container(
                  width: double.infinity,
                  child: _profile.isLoading == true
                      ? SizedBox(width: 10, height: 10)
                      : _profile.loggedUser?.firstName == 'null' &&
                              _profile.loggedUser?.lastName == 'null'
                          ? ElevatedButton(
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
                                child: Text('Submit'),
                              ),
                              onPressed: () async {
                                if (_profileController.isLoading == true)
                                  return;
                                if (_formkey.currentState!.saveAndValidate()) {
                                  await _profileController.updateName(
                                      _formkey.currentState!
                                          .value['first_nama_field'],
                                      _formkey.currentState!
                                          .value['last_nama_field']);
                                  //_formkey.currentState.value['first_namae_field'];
                                }
                              },
                            )
                          : SizedBox(width: 10, height: 10),
                );
              },
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
