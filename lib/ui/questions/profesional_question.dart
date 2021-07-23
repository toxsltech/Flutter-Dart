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

class ProfessionalQuestion extends StatefulWidget {
  @override
  _ProfessionalQuestionState createState() => _ProfessionalQuestionState();
}

class _ProfessionalQuestionState extends State<ProfessionalQuestion> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController tellusController;
  TextEditingController otherController;
  TextEditingController emailController;
  TextEditingController jobTitleController;
  TextEditingController companyController;
  TextEditingController whatFieldController;
  SubmitProfessionalModel _submitProfessionalModel = SubmitProfessionalModel();
  CustomLoader _customLoader = CustomLoader();
  FocusNode tellusNode;
  FocusNode otherNode;
  FocusNode emailNode;
  FocusNode jobTitleNode;
  FocusNode companyNode;
  FocusNode whatFieldNode;
  Usertype _currentSelectedValue;
  List<DropdownMenuItem<Usertype>> _dropdownMenuItems;

  List<DropdownMenuItem<Usertype>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<Usertype>> items = [];
    for (Usertype listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.type),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(usertype);
    tellusController = TextEditingController();
    emailController = TextEditingController();
    jobTitleController = TextEditingController();
    companyController = TextEditingController();
    whatFieldController = TextEditingController();
    otherController = TextEditingController();
    tellusNode = new FocusNode();
    otherNode = new FocusNode();
    emailNode = new FocusNode();
    jobTitleNode = new FocusNode();
    companyNode = new FocusNode();
    whatFieldNode = new FocusNode();
  }

  @override
  void dispose() {
    _customLoader.hide();
    tellusController.dispose();
    emailController.dispose();
    jobTitleController.dispose();
    companyController.dispose();
    whatFieldController.dispose();
    otherController.dispose();
    tellusNode.dispose();
    otherNode.dispose();
    emailNode.dispose();
    jobTitleNode.dispose();
    companyNode.dispose();
    whatFieldNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    HelperUtility.pushAndRemoveUntil(
                        context: context, route: LoginScreen());
                  }),
              title: Text(
                Strings.question,
                style: HelperUtility.textStyleBold(
                    fontsize: 20, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _form(),
                      HelperWidget.sizeBox(height: Dimens.margin_20),
                      _onSaveButtonPress(),
                      HelperWidget.sizeBox(height: Dimens.margin_20),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void saveQuestion() async {
    hideKeyBoard(context: context);
    _customLoader.show(context);
    var response = AuthRequestModel.submitProfessionalJson(
      title: jobTitleController.text.trim(),
      companyName: companyController.text.trim(),
      field: _currentSelectedValue.id,
      otherDetail: "null",
    );
    await APIRepository.submitProfessionalQuestion(response, context)
        .then((value) {
      _customLoader.hide();
      _submitProfessionalModel = value;
      HelperWidget.toast(_submitProfessionalModel.message);
      HelperUtility.push(context: context, route: ProfileSetUp());
    }).onError((error, stackTrace) {
      _customLoader.hide();
      HelperWidget.toast(error);
    });
  }

  _form() => Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _jobEditText(),
            _companyEditText(),
            _whatJobEditText(),
          ],
        ),
      );

  /*=================================================================== Email Edit Text ====================================================================*/

  Widget _jobEditText() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[A-Za-z0-9#+-./:@] *"))
        ],
        focusNode: jobTitleNode,
        textController: jobTitleController,
        hint: Strings.jobTitle,
        inputAction: TextInputAction.next,
        inputType: TextInputType.text,
        validate: (String val) {
          if (val.length < 1)
            return "Field can't be empty.";
          else
            return null;
        },
      ));

  _onSaveButtonPress() => Padding(
        padding: EdgeInsets.only(left: 25, right: 25.0),
        child: CustomButton(
          height: Dimens.height_45,
          isbold: true,
          buttonText: Strings.save,
          fontsize: Dimens.font_16,
          textColor: Colors.white,
          buttonIcon: Assets.facebook,
          isIcon: false,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              if (_currentSelectedValue == null) {
                HelperWidget.toast(Strings.pleaseselectwhatfield);
              } else if (_currentSelectedValue != null) {
                saveQuestion();
              }
            }
          },
          buttonColor: primaryColor,
        ),
      );

  _companyEditText() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
        focusNode: companyNode,
        textController: companyController,
        hint: Strings.company,
        isObsecure: false,
        validate: (String val) {
          if (val.length < 1)
            return "Field can't be empty.";
          else
            return null;
        },
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[A-Za-z0-9#+-./:@] *"))
        ],
        onFieldSubmitted: (String val) {
          FocusScope.of(context).unfocus();
        },
        inputAction: TextInputAction.next,
        inputType: TextInputType.text,
      ));

  _whatJobEditText() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldDropdown(
        focusNode: whatFieldNode,
        hint: Strings.whatField,
        width: Dimens.width_20,
        height: Dimens.height_20,
        items: _dropdownMenuItems,
        value: _currentSelectedValue,
        onChanged: (newValue) {
          if (mounted)
            setState(() {
              _currentSelectedValue = newValue;
            });
        },
      ));
}
