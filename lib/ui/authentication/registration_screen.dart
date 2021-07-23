/*
 *  @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 *  @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 *  the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

// Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';

// Project imports:
import 'package:alanis/export.dart';

class SignUpPage extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController;
  TextEditingController _nameTextController;
  TextEditingController _passwordTextController;
  FocusNode _userTypeNode;
  FocusNode _emailNode;
  FocusNode _nameNode;
  DeviceInfoPlugin deviceInfo;
  FocusNode _passwordNode;
  LoginResponseModel _loginResponseModel = LoginResponseModel();
  LoginDataModel _loginDataModel = LoginDataModel();
  CustomLoader _customLoader = CustomLoader();
  FirebaseMessaging _firebaseMessaging;
  String deviceToken = "";
  bool _agreeTerm;
  var _currentSelectedValue;
  var _userTypes = [
    "Professional",
    Strings.risingstar,
  ];
  IosDeviceInfo iosInfo;
  AndroidDeviceInfo androidInfo;
  bool eye = true;

  @override
  void initState() {
    super.initState();
    deviceDetail();
    _firebaseMessaging = FirebaseMessaging.instance;
    _getFirebaseToken();
    _agreeTerm = false;
    _userTypeNode = new FocusNode();
    _emailNode = new FocusNode();
    _passwordNode = new FocusNode();
    _emailTextController = new TextEditingController();
    _passwordTextController = new TextEditingController();
    _nameTextController = new TextEditingController();
  }

  Future<void> deviceDetail() async {
    !Platform.isAndroid
        ? await deviceInfo.iosInfo.then((value) {
            iosInfo = value;
          })
        : await deviceInfo.androidInfo.then((value) {
            androidInfo = value;
          });
  }

  @override
  void dispose() {
    super.dispose();
    _currentSelectedValue = null;
    _customLoader.hide();
  }

  _getFirebaseToken() {
    _firebaseMessaging.getToken().then((value) {
      deviceToken = value;
      debugPrint("deviceToken $deviceToken");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              imageWidget(),
              HelperWidget.sizeBox(height: Dimens.margin_20),
              loginHeading(),
              HelperWidget.sizeBox(height: Dimens.height_10),
              _form(),
              _agreeTermsAndCond(),
              HelperWidget.sizeBox(height: Dimens.margin_10),
              _onLoginPress(),
              HelperWidget.sizeBox(height: Dimens.margin_50),
              _dontHaveAccountText(),
              HelperWidget.sizeBox(height: Dimens.margin_20),
            ],
          ),
        ),
        _backButton(),
      ],
    );
  }

  void registerApiCall() async {
    hideKeyBoard(context: context);
    _customLoader.show(context);
    var response = AuthRequestModel.registerRequestData(
        roleId: _currentSelectedValue == "Professional"
            ? ROLE_PROFESSIONAL
            : ROLE_RISING_STAR,
        name: _nameTextController.text.trim(),
        email: _emailTextController.text.trim(),
        passwrod: _passwordTextController.text.trim(),
        deviceName: Platform.isAndroid
            ? androidInfo?.device ?? ""
            : iosInfo?.name ?? "",
        deviceType: Platform.isAndroid ? "1" : "2",
        deviceToken: deviceToken);
    await APIRepository.registerApiCall(response, context).then((value) {
      _customLoader.hide();
      _loginResponseModel = value;
      _loginDataModel = _loginResponseModel.detail;
      saveDataToLcoalStorage(_loginResponseModel, _loginDataModel);
      HelperWidget.toast(_loginResponseModel.message);
      if (_loginResponseModel.detail.roleId == ROLE_PROFESSIONAL)
        HelperUtility.pushAndRemoveUntil(
            context: context, route: ProfessionalQuestion());
      else
        HelperUtility.pushAndRemoveUntil(
            context: context, route: RisingStarQuestion());

      _clearEditText();
    }).onError((error, stackTrace) {
      _customLoader.hide();
      HelperWidget.toast(error);
    });
  }

  void _clearEditText() {
    _nameTextController.clear();
    _emailTextController.clear();
    _passwordTextController.clear();
  }

  void saveDataToLcoalStorage(
      LoginResponseModel loginResponseModel, LoginDataModel loginDataModel) {
    PrefManger.saveRegisterData(loginDataModel);
    PrefManger.saveAccessToken(_loginResponseModel.accessToken);
  }

  Widget imageWidget() {
    return Container(
        height: 250.0,
        width: HelperUtility.fullWidthScreen(context: context),
        child: Image.asset(Assets.bg_2, fit: BoxFit.fill));
  }

  Widget _backButton() => Padding(
        padding: EdgeInsets.all(Dimens.width_15),
        child: HelperWidget.getInkwell(
            onTap: () {
              HelperUtility.onBackPress(context: context);
            },
            widget: Icon(Icons.arrow_back)),
      );

  Widget loginHeading() => Text(
        Strings.signUp,
        style: HelperUtility.textStyleBold(
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontsize: Dimens.font_30),
      );

  Widget _form() => Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _userTypeDrop(),
            _nameEditText(),
            _emailEditText(),
            _passWordField(),
          ],
        ),
      );

  Widget _userTypeDrop() => Padding(
        padding: EdgeInsets.only(left: 20, right: 20.0),
        child: TextFieldDropdown(
          focusNode: _userTypeNode,
          hint: Strings.userType,
          iconMargin: Dimens.margin_10,
          icon: Assets.userType,
          width: Dimens.width_20,
          height: Dimens.height_20,
          items: _userTypes.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          value: _currentSelectedValue,
          onChanged: (newValue) {
            if (mounted)
              setState(() {
                _currentSelectedValue = newValue;
              });
          },
        ),
      );

  Widget _emailEditText() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
        focusNode: _emailNode,
        textController: _emailTextController,
        hint: Strings.email,
        inputAction: TextInputAction.next,
        validate: (String val) {
          return EmailFormValidator.validate(val);
        },
        inputType: TextInputType.emailAddress,
        icon: Assets.email,
      ));

  Widget _nameEditText() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
        focusNode: _nameNode,
        textController: _nameTextController,
        hint: Strings.fullName,
        inputAction: TextInputAction.next,
        inputType: TextInputType.name,
        icon: Assets.profile_bottom_selected,
        validate: (val) {
          if (val == null || val.length < 2)
            return "Name can't be empty.";
          else
            return null;
        },
      ));

  Widget _passWordField() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
        focusNode: _passwordNode,
        textController: _passwordTextController,
        hint: Strings.password,
        isObsecure: eye,
        onFieldSubmitted: (String val) {
          _passwordNode.unfocus();
          _passwordNode.canRequestFocus = false;
        },
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[A-Za-z0-9#+-./:@] *"))
        ],
        inputAction: TextInputAction.done,
        validate: passwordValidator,
        inputType: TextInputType.visiblePassword,
        icon: Assets.password,
        suffixIcon: eye ? Assets.eyeon : Assets.eyeoff,
        onTapSufix: () {
          if (mounted)
            setState(() {
              eye = !eye;
            });
          _passwordNode.unfocus();
          _passwordNode.canRequestFocus = false;
        },
      ));

  Widget _onLoginPress() => Padding(
        padding: EdgeInsets.only(left: 20, right: 20.0),
        child: CustomButton(
            height: Dimens.height_45,
            isbold: true,
            buttonText: Strings.signUp,
            fontsize: Dimens.font_18,
            textColor: Colors.white,
            buttonIcon: Assets.facebook,
            isIcon: false,
            buttonColor: primaryColor,
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                if (_currentSelectedValue != null && _agreeTerm == true)
                  registerApiCall();
                else if (_currentSelectedValue == null)
                  HelperWidget.toast(Strings.selectUserType);
                else if (_agreeTerm == false)
                  HelperWidget.toast(Strings.agreeTC);
              }
            }),
      );

  Widget _dontHaveAccountText() => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            height: Dimens.width_30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Strings.alradyaccount,
                  style: HelperUtility.textStyle(
                      color: Colors.grey, fontsize: Dimens.font_16),
                ),
                HelperWidget.sizeBox(width: Dimens.radius_3),
                GestureDetector(
                  onTap: () {
                    HelperUtility.pushReplacementNamed(
                        context: context, route: Routes.login);
                  },
                  child: Text(
                    Strings.signIn,
                    style: HelperUtility.textStyleBold(
                        color: primaryColor, fontsize: Dimens.font_16),
                  ),
                ),
              ],
            )),
      );

  Widget _agreeTermsAndCond() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Checkbox(
                value: _agreeTerm,
                activeColor: primaryColor,
                onChanged: (val) {
                  if (mounted)
                    setState(() {
                      _agreeTerm = val;
                    });
                }),
          ),
          Text(
            Strings.agreeTerms,
            style: HelperUtility.textStyle(
                color: Colors.grey, fontsize: Dimens.font_14),
          ),
          GestureDetector(
            onTap: () {
              HelperUtility.push(context: context, route: TermsandCondition());
            },
            child: Text(
              Strings.termsandCond,
              style: HelperUtility.textStyleBold(
                  color: primaryColor, fontsize: Dimens.font_14),
            ),
          ),
        ],
      );
}
