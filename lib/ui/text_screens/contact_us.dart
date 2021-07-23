// Project imports:
import 'package:alanis/export.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController emailController;
  TextEditingController subjectController;
  TextEditingController commmentController;
  final _formKey = GlobalKey<FormState>();
  FocusNode emailNode;
  FocusNode subjectNode;
  FocusNode commentNode;
  CustomLoader _customLoader = CustomLoader();
  ContactUsModel contactUsModel = ContactUsModel();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    subjectController = TextEditingController();
    commmentController = TextEditingController();
    emailNode = FocusNode();
    subjectNode = FocusNode();
    commentNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperWidget.appBar(title: Strings.contactus, context: context),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            _form(),
            SizedBox(height: Dimens.height_50),
            _onSaveButton()
          ],
        ),
      ),
    );
  }

  Widget _form() => Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _emailField(),
            _subjectField(),
            _commentField(),
          ],
        ),
      );

  Widget _emailField() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
        focusNode: emailNode,
        textController: emailController,
        hint: Strings.onlyEmail,
        inputAction: TextInputAction.next,
        inputType: TextInputType.emailAddress,
        validate: (String val) {
          return EmailFormValidator.validate(val);
        },
      ));

  Widget _subjectField() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
        focusNode: subjectNode,
        textController: subjectController,
        hint: Strings.subject,
        inputAction: TextInputAction.next,
        inputType: TextInputType.visiblePassword,
        validate: (val) {
          if (val == null || val.length < 1)
            return "Subject can't be empty.";
          else
            return null;
        },
      ));

  Widget _commentField() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldRect(
        minLines: 4,
        focusNode: commentNode,
        textController: commmentController,
        hint: Strings.comments,
        iconMargin: Dimens.margin_15,
        inputAction: TextInputAction.next,
        inputType: TextInputType.visiblePassword,
        width: Dimens.width_25,
        height: Dimens.height_25,
        validate: (val) {
          if (val == null || val.length < 1)
            return "Comments can't be empty.";
          else
            return null;
        },
      ));

  _onSaveButton() => Padding(
        padding: EdgeInsets.only(left: 20, right: 20.0),
        child: CustomButton(
          height: Dimens.height_45,
          isbold: true,
          buttonText: Strings.send,
          fontsize: Dimens.font_18,
          textColor: Colors.white,
          buttonIcon: Assets.facebook,
          isIcon: false,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              contactusApi();
            }
          },
          buttonColor: primaryColor,
        ),
      );

  void contactusApi() async {
    _customLoader.show(context);
    var response = AuthRequestModel.contactus(
        email: emailController.text.trim(),
        subject: subjectController.text.trim(),
        description: commmentController.text.trim());
    await APIRepository.contactUs(response, context).then((value) {
      _customLoader.hide();
      contactUsModel = value;
      showAlertDialog(context);
    }).onError((error, stackTrace) {
      _customLoader.hide();
      HelperWidget.toast(error);
    });
  }

  showAlertDialog(BuildContext context) async {
    hideKeyBoard(context: context);
    Dialog alert = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              contactUsModel.message,
              style: HelperUtility.textStyleBold(fontsize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          // _onLoginPress()
        ],
      ),
    );

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    doneAnimation(context);
  }

  doneAnimation(context) {
    if (mounted)
      Timer(Duration(seconds: 1), () {
        Navigator.pop(context);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => BottomNavigationScreen(4)));
      });
  }
}
