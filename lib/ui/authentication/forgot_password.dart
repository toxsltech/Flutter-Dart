/*
 *  @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 *  @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 *  the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

// Project imports:
import 'package:alanis/export.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController;
  FocusNode _emailNode;
  CustomLoader _customLoader = CustomLoader();
  ForgotPasswordResponseModel _forgotPasswordResponseModel =
      ForgotPasswordResponseModel();

  @override
  void initState() {
    super.initState();
    _emailNode = new FocusNode();
    _emailTextController = new TextEditingController();
  }

  @override
  void dispose() {
    _customLoader.hide();
    super.dispose();
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
        Container(
            height: 100.0,
            width: HelperUtility.fullWidthScreen(context: context),
            child: Image.asset(Assets.bg_3, fit: BoxFit.fill)),
        Center(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                HelperWidget.sizeBox(height: Dimens.height_50),
                loginHeading(),
                HelperWidget.sizeBox(height: Dimens.height_10),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: loginSubTitle1(),
                ),
                loginSubTitle2(),
                HelperWidget.sizeBox(height: Dimens.height_10),
                _form(),
                HelperWidget.sizeBox(height: Dimens.height_30),
                _onSubmitPress(),
              ],
            ),
          ),
        ),
        _backButton()
      ],
    );
  }

  Widget loginHeading() => Text(
        Strings.forgotPasswords,
        style: HelperUtility.textStyleBold(
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontsize: Dimens.font_20),
      );

  Widget loginSubTitle1() => Text(
        Strings.text1,
        textAlign: TextAlign.start,
        maxLines: 2,
        style: HelperUtility.textStyle(
            color: Colors.grey, fontsize: Dimens.font_15),
      );

  Widget loginSubTitle2() => Text(
        Strings.text2,
        textAlign: TextAlign.start,
        maxLines: 2,
        style: HelperUtility.textStyle(
            color: Colors.grey, fontsize: Dimens.font_15),
      );

  /*================================================================ Creation of From ========================================================*/

  _form() => Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _emailEditText(),
          ],
        ),
      );

  /*=================================================================== Email Edit Text ====================================================================*/

  Widget _emailEditText() => Padding(
        padding: EdgeInsets.only(left: 20, right: 20.0),
        child: TextFieldWidget(
          focusNode: _emailNode,
          textController: _emailTextController,
          hint: Strings.email,
          inputAction: TextInputAction.done,
          validate: (String val) {
            return EmailFormValidator.validate(val);
          },
          inputType: TextInputType.emailAddress,
          icon: Assets.email,
        ),
      );

  _onSubmitPress() => Padding(
        padding: EdgeInsets.only(left: 20, right: 20.0),
        child: CustomButton(
          height: Dimens.height_45,
          isbold: true,
          buttonText: Strings.submit,
          fontsize: Dimens.font_18,
          textColor: Colors.white,
          buttonIcon: Assets.facebook,
          isIcon: false,
          onPressed: () {
            if (_formKey.currentState.validate()) forgotApiCall();
          },
          buttonColor: primaryColor,
        ),
      );

  _backButton() => Padding(
        padding: EdgeInsets.all(Dimens.width_15),
        child: HelperWidget.getInkwell(
          onTap: () {
            Navigator.pop(context);
          },
          widget: Icon(Icons.arrow_back),
        ),
      );

  void forgotApiCall() async {
    _customLoader.show(context);
    var response = AuthRequestModel.forgotPasswordDataRequest(
      firstName: _emailTextController.text.trim(),
    );
    await APIRepository.forgotApiCall(response, context).then((value) {
      _customLoader.hide();
      _forgotPasswordResponseModel = value;
      HelperUtility.push(context: context, route: LoginScreen());
      HelperWidget.toast(_forgotPasswordResponseModel.message);
    }).onError((error, stackTrace) {
      _customLoader.hide();
      HelperWidget.toast(error);
    });
  }
}
