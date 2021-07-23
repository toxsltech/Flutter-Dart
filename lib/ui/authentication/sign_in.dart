/*
 *  @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 *  @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 *  the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

// Package imports:
import 'package:apple_sign_in/apple_sign_in.dart' as AppleSignInButton;
import 'package:apple_sign_in/apple_sign_in.dart';

// Project imports:
import 'package:alanis/export.dart';

import 'package:firebase_messaging/firebase_messaging.dart'
    as FirebaseMessaging;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController;
  TextEditingController _passwordTextController;
  FocusNode _emailNode;
  FocusNode _passwordNode;
  bool rememberme;
  DeviceInfoPlugin deviceInfo;
  DateTime _lastPressedAt;
  UserCredential userCredential;
  User user;
  LoginResponseModel _loginResponseModel = LoginResponseModel();
  LoginDataModel _loginDataModel = LoginDataModel();
  CustomLoader _customLoader = CustomLoader();
  IosDeviceInfo iosInfo;
  AndroidDeviceInfo androidInfo;
  Map map;
  bool checkValue;
  bool eye = true;
  String deviceToken = "";
  String deviceName = "";
  int deviceType;
  FirebaseMessaging.FirebaseMessaging _firebaseMessaging;

  _getRemberMeData() {
    PrefManger.getRemberData().then((value) {
      map = value;
      if (map != null) {
        if (mounted)
          setState(() {
            _emailTextController.text = map["email"];
            _passwordTextController.text = map["password"];
            if (_emailTextController.text.length == 0 &&
                _passwordTextController.text.length == 0) {
              checkValue = false;
            } else {
              checkValue = true;
            }
          });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _firebaseMessaging = FirebaseMessaging.FirebaseMessaging.instance;
    _emailNode = new FocusNode();
    _passwordNode = new FocusNode();
    _emailTextController = new TextEditingController();
    _passwordTextController = new TextEditingController();
    rememberme = false;
    deviceInfo = DeviceInfoPlugin();
    deviceDetail();
    checkValue = false;
    _getRemberMeData();
    initFirebase();
    _getFirebaseToken();
  }

  Future logInFacebook(int role, int loginType) async {
    try {
      userCredential = await signInWithFacebook();
      user = userCredential.user;
      _customLoader.show(context);
      userCredential = userCredential;
      print('email: ${userCredential.user.email}');
      print('displayName;: ${userCredential.user.displayName}');
      print('uid: ${userCredential.user.uid}');
      //HelperWidget.toast(userCredential.user.email);
      socialLoginApiCall(loginType, role);
    } on FirebaseException catch (e) {
      HelperWidget.toast(e.message);
    } catch (e) {
      debugPrint("fb error  :" + e.toString());
      HelperWidget.toast(Strings.cancelled);
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    String token;
    final result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
        loginBehavior: LoginBehavior.webViewOnly).then((value) {
      debugPrint("facebook message: " +
          value.message +
          "facebook status: " +
          value.status.toString() +
          "facebook token: " +
          value.accessToken.token);
      token = value.accessToken.token;
    }).onError((error, stackTrace) {
      debugPrint("facebook error: " + error);
    });
    debugPrint(result);
    // Create a credential from the access token
    final facebookAuthCredential = FacebookAuthProvider.credential(token);

    FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
    FirebaseAuth auth = FirebaseAuth.instanceFor(app: secondaryApp);

    // Once signed in, return the UserCredential
    return await auth.signInWithCredential(facebookAuthCredential);
  }

  initFirebase() async {
    await Firebase.initializeApp().whenComplete(() {
      print("initializedAppFirebase");
    });
  }

  _getFirebaseToken() {
    _firebaseMessaging.getToken().then((value) {
      deviceToken = value;
      debugPrint("deviceToken $deviceToken");
      return deviceToken;
    });
  }

  @override
  void dispose() {
    _customLoader.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          Fluttertoast.showToast(
            fontSize: 12.0,
            msg: Strings.pressAgain,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            textColor: Colors.black87,
            gravity: ToastGravity.BOTTOM,
          );
          _lastPressedAt = DateTime.now();
          return false;
        }
        return true;
      },
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: _body(),
          ),
        ),
      ),
    );
  }

  _body() {
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
              _form(),
              HelperWidget.sizeBox(height: Dimens.height_10),
              _rememberAndForget(),
              HelperWidget.sizeBox(height: Dimens.margin_20),
              _onLoginPress(),
              HelperWidget.sizeBox(height: Dimens.margin_20),
              _socialButton(),
              Platform.isIOS ? _appleButton() : Container(),
              HelperWidget.sizeBox(height: Dimens.margin_20),
              _dontHaveAccountText(),
              HelperWidget.sizeBox(height: Dimens.margin_20),
            ],
          ),
        ),
        // _backButton()
      ],
    );
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

  Future logInGoogle(int role, int googleType) async {
    try {
      userCredential = await signInWithGoogle();
      user = userCredential?.user;
      _customLoader.show(context);

      socialLoginApiCall(googleType, role);
    } catch (e) {
      debugPrint('error: $e.');
      if (e.toString().contains("NoSuchMethodError"))
        HelperWidget.toast("Cancelled");
      else
        HelperWidget.toast(e.toString());
    }
  }

  /*-------------------------------------- sign With Apple ---------------------------------*/

  Future<void> _signInWithApple(int role, int loginType) async {
    try {
      user = await signInWithApple();
      _customLoader.show(context);
      debugPrint('uid: ${user?.uid}');
      debugPrint('email: ${user?.email}');
      debugPrint('displayName: ${user?.displayName}');
      socialLoginApiCall(loginType, role);
    } catch (e) {
      print(e);
    }
  }

  Future<User> signInWithApple() async {
    final result = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode),
        );
        final authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final firebaseUser = authResult.user;
        return firebaseUser;

      case AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        throw UnimplementedError();
    }
  }

  void socialLoginApiCall(int googleType, int role) async {
    hideKeyBoard(context: context);
    debugPrint("roleOafh $role");
    debugPrint("roldeviceTokendeviceTokendeviceTokeneOafh $deviceToken");
    var response = AuthRequestModel.socialLoginRequestData(
      email: user?.email ?? "",
      fullName: user?.displayName ?? "",
      userId: user?.uid ?? "",
      provider: googleType.toString(),
      deviceName:
          Platform.isAndroid ? androidInfo?.device ?? "" : iosInfo?.name ?? "",
      deviceToken: deviceToken ?? "",
      roleID: role,
      deviceType: Platform.isAndroid ? 1 : 2,
    );
    await APIRepository.socialApiCall(response, context).then((value) {
      if (value != null) {
        _customLoader.hide();
        _loginResponseModel = value;

        _loginDataModel = _loginResponseModel.detail;
        saveDataToLcoalStorage(_loginResponseModel, _loginDataModel);
        HelperWidget.toast(_loginResponseModel.message);
        if (_loginResponseModel.detail.roleId == ROLE_PROFESSIONAL) {
          PrefManger.saveRoleID(ROLE_PROFESSIONAL.toString());
          if (_loginDataModel.checkProfessionalDetail == true)
            HelperUtility.pushAndRemoveUntil(
                context: context, route: BottomNavigationScreen(0));
          else
            HelperUtility.pushAndRemoveUntil(
                context: context, route: ProfessionalQuestion());
        } else if (_loginResponseModel.detail.roleId == ROLE_RISING_STAR) {
          PrefManger.saveRoleID(ROLE_RISING_STAR.toString());
          if (_loginDataModel.checkRisingDetail == true)
            HelperUtility.pushAndRemoveUntil(
                context: context, route: BottomNavigationScreen(0));
          else
            HelperUtility.pushAndRemoveUntil(
                context: context, route: RisingStarQuestion());
        }
      } else {
        _customLoader.hide();
      }
    });
  }

  void loginApiCall() async {
    hideKeyBoard(context: context);
    _customLoader.show(context);
    var response = AuthRequestModel.loginRequestData(
        email: _emailTextController.text.trim(),
        password: _passwordTextController.text.trim(),
        deviceName: Platform.isAndroid ? androidInfo.device : iosInfo.name,
        deviceType: Platform.isAndroid ? "1" : "2",
        deviceToken: deviceToken);
    print("token  $deviceToken");
    await APIRepository.loginApiCall(response, context).then((value) {
      if (value != null) {
        _customLoader.hide();
        _loginResponseModel = value;
        _loginDataModel = _loginResponseModel.detail;
        saveDataToLcoalStorage(_loginResponseModel, _loginDataModel);
        rememberMeData(checkValue);
        if (_loginResponseModel.detail.roleId == ROLE_PROFESSIONAL) {
          PrefManger.saveRoleID(ROLE_PROFESSIONAL.toString());
          if (_loginDataModel.checkProfessionalDetail == true)
            HelperUtility.pushAndRemoveUntil(
                context: context, route: BottomNavigationScreen(0));
          else
            HelperUtility.pushAndRemoveUntil(
                context: context, route: ProfessionalQuestion());
        } else if (_loginResponseModel.detail.roleId == ROLE_RISING_STAR) {
          PrefManger.saveRoleID(ROLE_RISING_STAR.toString());
          if (_loginDataModel.checkRisingDetail == true)
            HelperUtility.pushAndRemoveUntil(
                context: context, route: BottomNavigationScreen(0));
          else
            HelperUtility.pushAndRemoveUntil(
                context: context, route: RisingStarQuestion());
        }
        HelperWidget.toast(_loginResponseModel.message);
      } else {
        _customLoader.hide();
      }
    }).onError((error, stackTrace) {
      _customLoader.hide();
      HelperWidget.toast(error);
    });
  }

  void saveDataToLcoalStorage(
      LoginResponseModel loginResponseModel, LoginDataModel loginDataModel) {
    PrefManger.saveRegisterData(loginDataModel);
    PrefManger.saveAccessToken(_loginResponseModel.accessToken);
  }

  void rememberMeData(bool checkValue) {
    if (checkValue == true) {
      PrefManger.saveRemberMeData(
          email: _emailTextController.text.toString(),
          password: _passwordTextController.text.toString());
    } else {
      PrefManger.saveRemberMeData(email: "", password: "");
    }
  }

  Widget imageWidget() {
    return Container(
        height: 250.0,
        width: HelperUtility.fullWidthScreen(context: context),
        child: Image.asset(Assets.bg_2, fit: BoxFit.fill));
  }

  Widget loginHeading() => Text(
        Strings.signIn,
        style: HelperUtility.textStyleBold(
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontsize: Dimens.font_30),
      );

  Widget loginSubTitle() => Text(
        Strings.loginTitle,
        style: HelperUtility.textStyle(
            color: Colors.grey, fontsize: Dimens.font_16),
      );

  /*================================================================ Creation of From ========================================================*/

  _form() => Form(
        key: _formKey,
        child: Column(
          children: <Widget>[_emailEditText(), _passWordField()],
        ),
      );

  /*=================================================================== Email Edit Text ====================================================================*/

  Widget _emailEditText() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
        focusNode: _emailNode,
        textController: _emailTextController,
        hint: Strings.email,
        inputAction: TextInputAction.next,
        inputType: TextInputType.emailAddress,
        validate: (String val) {
          return EmailFormValidator.validate(val);
        },
        icon: Assets.email,
      ));

  /*====================================================================== Password Edit Text Field ==========================================================*/

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
        validate: (String val) {
          if (val.length < 1)
            return "Password can't be empty.";
          else
            return null;
        },
        inputType: TextInputType.visiblePassword,
        icon: Assets.password,
        suffixIcon: eye ? Assets.eyeon : Assets.eyeoff,
        onTapSufix: () {
          _passwordNode.unfocus();
          _passwordNode.canRequestFocus = false;
          if (mounted)
            setState(() {
              eye = !eye;
            });
        },
      ));

  Widget _textRememberMe() => Container(
        padding: EdgeInsets.only(left: 25, right: 8.0),
        height: 25,
        width: HelperUtility.fullWidthScreen(context: context),
        child: Row(
          children: [
            Flexible(
              child: Checkbox(
                activeColor: primaryColor,
                value: checkValue,
                onChanged: (newValue) {
                  if (mounted)
                    setState(() {
                      checkValue = newValue;
                      rememberMeData(checkValue);
                    });
                },
              ),
            ),
            SizedBox(width: 4),
            Text(
              Strings.rememberme,
              style: HelperUtility.textStyle(
                  color: Colors.grey, fontsize: Dimens.font_14),
            ),
          ],
        ),
      );

  Widget _textForgotPassWord() => Align(
        alignment: Alignment.centerRight,
        child: Padding(
            padding: EdgeInsets.only(right: Dimens.margin_25),
            child: Row(
              children: [
                Image.asset(
                  Assets.forgetIcon,
                  height: 15,
                  width: 15,
                ),
                SizedBox(width: 4),
                HelperWidget.getInkwell(
                    onTap: () {
                      HelperUtility.pushNamed(
                          context: context, route: Routes.forgotPassword);
                    },
                    widget: Text(
                      Strings.forgotPassword,
                      style: HelperUtility.textStyle(
                          color: Colors.grey, fontsize: Dimens.font_14),
                    )),
              ],
            )),
      );

  Widget _rememberAndForget() => Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [Expanded(child: _textRememberMe()), _textForgotPassWord()],
        ),
      );

  Widget _socialButton() => Padding(
        padding: EdgeInsets.only(left: 20, right: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _facbookButton(),
            HelperWidget.sizeBox(width: Dimens.radius_10),
            Expanded(child: _googleButton()),
          ],
        ),
      );

  Widget _facbookButton() => Container(
        padding: EdgeInsets.all(Dimens.margin_10),
        height: Dimens.margin_50,
        width: HelperUtility.fullWidthScreen(context: context) * 0.43,
        decoration: HelperWidget.decorationBoxColor(
            outlineColor: Colors.blue,
            roundCorner: Dimens.margin_50,
            fillColor: Colors.blue),
        child: GestureDetector(
          onTap: () {
            showDailog(faceBookType);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.facebook),
              SizedBox(width: 10),
              Text(
                Strings.facebookF,
                style: HelperUtility.textStyleBold(
                    color: Colors.white, fontsize: 16),
              ),
            ],
          ),
        ),
      );

  Widget _googleButton() => Container(
        padding: EdgeInsets.all(Dimens.margin_10),
        height: Dimens.margin_50,
        width: HelperUtility.fullWidthScreen(context: context) * 0.43,
        decoration: HelperWidget.decorationBoxColor(
            outlineColor: Colors.red,
            roundCorner: Dimens.margin_50,
            fillColor: Colors.red),
        child: GestureDetector(
          onTap: () {
            showDailog(googleType);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.google),
              SizedBox(width: 10),
              Text(
                Strings.googleS,
                style: HelperUtility.textStyleBold(
                    color: Colors.white, fontsize: 16),
              ),
            ],
          ),
        ),
      );

  Widget _onLoginPress() => Padding(
        padding: EdgeInsets.only(left: 20, right: 20.0),
        child: CustomButton(
          height: Dimens.height_45,
          isbold: true,
          buttonText: Strings.signIn,
          fontsize: Dimens.font_18,
          textColor: Colors.white,
          buttonIcon: Assets.facebook,
          isIcon: false,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              loginApiCall();
            }
          },
          buttonColor: primaryColor,
        ),
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
              Strings.textDontAccount,
              style: HelperUtility.textStyle(
                  color: Colors.grey, fontsize: Dimens.font_16),
            ),
            HelperWidget.sizeBox(width: Dimens.radius_3),
            GestureDetector(
              onTap: () {
                HelperUtility.push(context: context, route: SignUpPage());
              },
              child: Text(
                Strings.signUp,
                style: HelperUtility.textStyleBold(
                    color: primaryColor, fontsize: Dimens.font_16),
              ),
            ),
          ],
        ),
      ));

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void showDailog(int loginType) => AlertDialogs.showDialog(
      context: context,
      widget: Padding(
        padding: EdgeInsets.only(
            left: Dimens.margin_20,
            right: Dimens.margin_20,
            bottom: Dimens.margin_10,
            top: Dimens.margin_10),
        child: Card(
          elevation: 10.0,
          child: Container(
            width: HelperUtility.fullWidthScreen(context: context),
            decoration: HelperWidget.decorationBoxx(
                borderWidth: Dimens.radius_1,
                cornerRaduis: Dimens.margin_0,
                borderColor: Colors.white,
                backgroundColor: Colors.white),
            padding: EdgeInsets.all(Dimens.margin_15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Strings.selectType,
                  style: HelperUtility.textStyleBold(
                      color: Colors.black, fontsize: Dimens.font_18),
                ),
                HelperWidget.sizeBox(height: Dimens.width_20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        if (loginType == googleType) {
                          logInGoogle(ROLE_PROFESSIONAL, loginType);
                        } else if (loginType == appleType) {
                          _signInWithApple(ROLE_PROFESSIONAL, loginType);
                        } else {
                          logInFacebook(ROLE_PROFESSIONAL, loginType);
                        }
                      },
                      child: Text(
                        Strings.professional,
                        style: HelperUtility.textStyle(
                            color: Colors.black, fontsize: Dimens.font_20),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        if (loginType == googleType) {
                          logInGoogle(ROLE_RISING_STAR, loginType);
                        } else if (loginType == appleType) {
                          _signInWithApple(ROLE_RISING_STAR, loginType);
                        } else {
                          logInFacebook(ROLE_RISING_STAR, loginType);
                        }
                      },
                      child: Text(
                        Strings.risingstar,
                        style: HelperUtility.textStyle(
                            color: Colors.black, fontsize: Dimens.font_20),
                      ),
                    ),
                  ],
                ),
                HelperWidget.sizeBox(height: Dimens.width_20),
              ],
            ),
          ),
        ),
      ));

  _appleButton() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0, top: Dimens.height_20),
      child: AppleSignInButton.AppleSignInButton(
        cornerRadius: Dimens.margin_50,
        onPressed: () {
          showDailog(appleType);
        },
        type: ButtonType.continueButton,
        style: AppleSignInButton.ButtonStyle.black,
      ),
    );
  }
}
