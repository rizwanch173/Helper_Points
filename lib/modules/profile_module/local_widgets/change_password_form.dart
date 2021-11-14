import '../../../exports.dart';

class ChangePasswordForm extends StatefulWidget {
  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final GlobalKey<FormBuilderState> _pswkey = GlobalKey<FormBuilderState>();
  ProfileController _profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: FormBuilder(
        key: _pswkey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            FormBuilderTextField(
              name: 'current_password_field',
              maxLines: 1,
              obscureText: true,
              style: TextStyle(
                color: Colors.black,
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
                  color: Colors.grey,
                ),
                errorStyle: TextStyle(
                    color: Color(0xfff5a623),
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic),
                //focusedBorder: InputBorder.none,
                labelText: 'Current password',
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
              ]),
            ),
            const SizedBox(height: 20),
            FormBuilderTextField(
              name: 'new_password_field',
              maxLines: 1,
              obscureText: true,
              style: TextStyle(
                color: Colors.black,
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
                  color: Colors.grey,
                ),
                errorStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic),
                //focusedBorder: InputBorder.none,
                labelText: 'New Password',
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
              ]),
            ),
            const SizedBox(height: 20),
            FormBuilderTextField(
              name: 'repeat_new_password_field',
              maxLines: 1,
              obscureText: true,
              style: TextStyle(
                color: Colors.black,
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
                  color: Colors.grey,
                ),
                errorStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic),
                //focusedBorder: InputBorder.none,
                labelText: 'Repeat New Password',
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
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : ElevatedButton(
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
                            if (_profileController.isLoading == true) return;
                            if (_pswkey.currentState!.saveAndValidate()) {
                              if (_pswkey.currentState!
                                      .value['new_password_field'] !=
                                  _pswkey.currentState!
                                      .value['repeat_new_password_field']) {
                                Get.snackbar('Error',
                                    'The new password is not the same as the repeated password',
                                    margin: EdgeInsets.only(
                                        bottom: 50.0, left: 20.0, right: 20.0),
                                    snackPosition: SnackPosition.BOTTOM,
                                    colorText: Colors.white,
                                    backgroundColor: Colors.grey[900]);
                                return;
                              }
                              await _profileController.changePassword(
                                  _pswkey.currentState!
                                      .value['new_password_field'],
                                  _pswkey.currentState!
                                      .value['current_password_field']);
                              //_pswkey.currentState.value['first_namae_field'];
                            }
                          },
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
