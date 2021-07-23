// Project imports:
import 'package:alanis/export.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController newPassword;
  TextEditingController cnfPassword;
  FocusNode newPasswordNode;
  FocusNode cnfPasswordNode;
  CustomLoader _customLoader;
  ChangePasswordResponseModel _changePasswordResponseModel;
  String accessToken;
  bool eye1 = true;
  bool eye2 = true;

  @override
  void initState() {
    super.initState();
    _customLoader = CustomLoader();
    newPassword = TextEditingController();
    cnfPassword = TextEditingController();
    newPasswordNode = FocusNode();
    cnfPasswordNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperWidget.appBar(
          title: Strings.textChangePassword, context: context),
      body: _body(),
    );
  }

  _body() {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 30),
          _form(),
          SizedBox(height: Dimens.height_50),
          _saveButton()
        ],
      ),
    );
  }

  void changePasswordApiCall() async {
    _customLoader.show(context);
    var response = AuthRequestModel.changePassword(
        changePassword: newPassword.text.trim(),
        confirmPassword: cnfPassword.text.trim());
    await APIRepository.changePassword(response, context).then((value) {
      _customLoader.hide();
      _changePasswordResponseModel = value;
      HelperWidget.toast(_changePasswordResponseModel.message);
      HelperUtility.pushAndRemoveUntil(route: LoginScreen(), context: context);
    }).onError((error, stackTrace) {
      _customLoader.hide();
      HelperWidget.toast(error);
    });
  }

  Widget _newpasswordEditText() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
        focusNode: newPasswordNode,
        textController: newPassword,
        hint: Strings.textNewPassword,
        inputAction: TextInputAction.next,
        inputType: TextInputType.visiblePassword,
        validate: passwordValidator,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[A-Za-z0-9#+-./:@] *"))
        ],
        isObsecure: eye1,
        suffixIcon: eye1 ? Assets.eyeon : Assets.eyeoff,
        onTapSufix: () {
          if (mounted)
            setState(() {
              eye1 = !eye1;
            });
          newPasswordNode.unfocus();
          newPasswordNode.canRequestFocus = false;
        },
      ));

  Widget _cnfpasswordEditText() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
          focusNode: cnfPasswordNode,
          textController: cnfPassword,
          hint: Strings.textConfirmPassword,
          inputAction: TextInputAction.done,
          inputType: TextInputType.visiblePassword,
          isObsecure: eye2,
          suffixIcon: eye2 ? Assets.eyeon : Assets.eyeoff,
          onTapSufix: () {
            if (mounted)
              setState(() {
                eye2 = !eye2;
              });
            cnfPasswordNode.unfocus();
            cnfPasswordNode.canRequestFocus = false;
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[A-Za-z0-9#+-./:@] *"))
          ],
          validate: (val) {
            if (val.length < 1)
              return Strings.pleaseCnfPassword;
            else if (val != newPassword.text)
              return Strings.passworDontMatch;
            else
              return null;
          }));

  Widget _saveButton() => Padding(
        padding: EdgeInsets.only(left: 25, right: 25.0),
        child: CustomButton(
          height: Dimens.height_45,
          isbold: false,
          buttonText: Strings.save,
          fontsize: Dimens.font_16,
          textColor: Colors.white,
          buttonIcon: Assets.facebook,
          isIcon: false,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              if (newPassword.text == cnfPassword.text)
                changePasswordApiCall();
              else
                HelperWidget.toast(Strings.passworDontMatch);
            }
          },
          buttonColor: primaryColor,
        ),
      );

  _form() => Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _newpasswordEditText(),
            _cnfpasswordEditText(),
          ],
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _customLoader.hide();
  }
}
