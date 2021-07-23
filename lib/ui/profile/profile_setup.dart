/*
 *  @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 *  @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 *  the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

// Package imports:
import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:alanis/export.dart';

class ProfileSetUp extends StatefulWidget {
  final bool professional;

  const ProfileSetUp({Key key, this.professional = false}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ProfileSetUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameTextController;
  TextEditingController _emailTextController;
  TextEditingController _phoneTextController;
  TextEditingController _dobTextController;
  TextEditingController _locationTextController;
  TextEditingController _aboutmeTextController;
  FocusNode _firstNode;
  FocusNode _emailNode;
  FocusNode _dobNode;
  FocusNode _aboutmeNode;
  FocusNode _phoneNumberNode;
  FocusNode _locationNode;
  ImagePicker imagePicker = ImagePicker();
  CustomLoader _customLoader = CustomLoader();
  LoginDataModel data = LoginDataModel();
  File profileFile;
  var mulipartImage;
  String roleId;
  var myFormat = DateFormat('yyyy-mm-dd');
  var maskFormatter = new MaskTextInputFormatter(
      mask: '####-##-##', filter: {"#": RegExp(r'[0-9]')});
  LoginDataModel _loginDataModel = LoginDataModel();
  UpdateResponseModel _updateResponseModel = UpdateResponseModel();
  DateTime currentDate = DateTime.now();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime pickedDate = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: const Color(0xE6CD9AA7),
              accentColor: const Color(0xE6CD9AA7),
              colorScheme: ColorScheme.light(primary: const Color(0xE6CD9AA7)),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child,
          );
        },
        context: context,
        initialDate: _dobTextController.text != null &&
                _dobTextController.text.isNotEmpty
            ? DateTime.parse(_dobTextController.text)
            : DateTime(
                currentDate.year - 16, currentDate.month, currentDate.day),
        firstDate: DateTime(1947),
        lastDate: DateTime(
            currentDate.year - 16, currentDate.month, currentDate.day));
    if (pickedDate != null && pickedDate != currentDate) if (mounted)
      setState(() {
        _dobTextController.text = dateFormat.format(pickedDate);
      });
  }

  Future<void> getData() async {
    await PrefManger.getRegisterData().then((value) {
      data = value;
      if (mounted) setState(() {});
      _nameTextController.text = data.fullName;
      _emailTextController.text = data.email;
      _phoneTextController.text = data.contactNo;
      _dobTextController.text = data.dateOfBirth;
      _aboutmeTextController.text = data.shortDescription;
      _locationTextController.text =
          data?.country == null || data.country.isEmpty ? "" : data?.country;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _phoneTextController = TextEditingController();
    _dobTextController = TextEditingController();
    _aboutmeTextController = TextEditingController();
    _locationTextController = TextEditingController();
    _aboutmeTextController.text = "";
    _firstNode = new FocusNode();
    _emailNode = new FocusNode();
    _phoneNumberNode = new FocusNode();
    _dobNode = new FocusNode();
    _locationNode = new FocusNode();
    _aboutmeNode = new FocusNode();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    _customLoader.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              HelperUtility.onBackPress(context: context);
            }),
        title: Text(
          Strings.profileSetup,
          style: HelperUtility.textStyleBold(
              fontsize: 20, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            HelperWidget.sizeBox(height: Dimens.height_20),
            HelperWidget.getInkwell(
              onTap: () {
                FocusScope.of(context).unfocus();
                showDailog();
              },
              widget: profileFile != null
                  ? _profileHeader()
                  : _profileAssetsHeader(),
            ),
            HelperWidget.sizeBox(height: Dimens.font_35),
            _form(),
            HelperWidget.sizeBox(height: Dimens.margin_30),
            _onSaveButtonPress(),
            HelperWidget.sizeBox(height: Dimens.margin_20),
          ],
        ),
      ),
    );
  }

  void showCountryList() => showCountryPicker(
        showPhoneCode: false,
        context: context,
        countryListTheme: CountryListThemeData(
          textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          inputDecoration: InputDecoration(
            labelText: 'Search',
            hintText: 'Start typing to search',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF8C98A8).withOpacity(0.2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF8C98A8).withOpacity(0.2),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF8C98A8).withOpacity(0.2),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF8C98A8).withOpacity(0.2),
              ),
            ),
          ),
        ),
        onSelect: (Country country) {
          if (mounted)
            setState(() {
              _locationTextController.text = country.name;
            });
        },
      );

  void showDailog() => AlertDialogs.showDialog(
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
                Align(
                  alignment: Alignment.topRight,
                  child: HelperWidget.getInkwell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      widget: Icon(
                        Icons.cancel,
                      )),
                ),
                Text(
                  Strings.choose,
                  style: HelperUtility.textStyleBold(
                      color: Colors.black, fontsize: Dimens.font_18),
                ),
                HelperWidget.sizeBox(height: Dimens.width_20),
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        _imagePickGromCamer();
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 50.0,
                              color: primaryColor,
                            ),
                            Text(
                              Strings.camera,
                              style: HelperUtility.textStyle(
                                  color: Colors.black,
                                  fontsize: Dimens.font_14),
                            ),
                          ],
                        ),
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        _imagePickGallery();
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Icon(
                              Icons.file_copy_rounded,
                              size: 50.0,
                              color: primaryColor,
                            ),
                            Text(
                              Strings.gallery,
                              style: HelperUtility.textStyle(
                                  color: Colors.black,
                                  fontsize: Dimens.font_14),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
                HelperWidget.sizeBox(height: Dimens.width_20),
              ],
            ),
          ),
        ),
      ));

  void _imagePickGromCamer() async {
    var pickedFile = await ImagePick.imgFromCamera();
    File file = File(pickedFile.path);
    if (file == null) {
      HelperWidget.toast(Strings.cancel);
    } else {
      _cropImage(pickedFile.path);
    }
  }

  void _imagePickGallery() async {
    var pickedFile = await ImagePick.imgFromGallery();
    File file = File(pickedFile.path);
    if (file == null) {
      HelperWidget.toast(Strings.cancel);
    } else {
      _cropImage(pickedFile.path);
    }
  }

  _cropImage(filePath) async {
    File croppedImage = await ImageCropper.cropImage(
      cropStyle: CropStyle.rectangle,
      sourcePath: filePath,
      androidUiSettings: AndroidUiSettings(
          showCropGrid: false,
          backgroundColor: Colors.white,
          cropGridColor: Colors.white,
          dimmedLayerColor: primaryColorShades.shade700,
          cropFrameStrokeWidth: 0,
          cropGridStrokeWidth: 0,
          toolbarTitle: "Crop Image",
          toolbarColor: primaryColorShades,
          activeControlsWidgetColor: primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          cropFrameColor: Colors.transparent),
    );

    Navigator.pop(context);
    if (mounted)
      setState(() {
        profileFile = croppedImage;
      });
  }

  void profileSetupApiCall() async {
    hideKeyBoard(context: context);
    _customLoader.show(context);
    if (profileFile != null) {
      mulipartImage = await MultipartFile.fromFile(profileFile.path,
          filename: profileFile.path);
    }

    var response = AuthRequestModel.updateRequestData(
        fullName: _nameTextController.text.trim(),
        contactNo: _phoneTextController.text.trim(),
        dateOfBirth: _dobTextController.text.trim(),
        aboutMe: _aboutmeTextController.text.trim(),
        fileUrl: mulipartImage,
        country: _locationTextController.text.trim());

    await APIRepository.updateProfile(response, context).then((value) {
      _customLoader.hide();
      _updateResponseModel = value;
      _loginDataModel = _updateResponseModel.detail;
      saveDataToLcoalStorage(_loginDataModel);
      HelperWidget.toast(Strings.profileUpdated);
      HelperUtility.pushAndRemoveUntil(
          context: context, route: BottomNavigationScreen(0));
    }).onError((error, stackTrace) {
      _customLoader.hide();
      HelperWidget.toast(error.toString());
    });
  }

  void saveDataToLcoalStorage(LoginDataModel loginDataModel) {
    PrefManger.saveRegisterData(loginDataModel);
  }

  Widget imageWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HelperWidget.imageSet(icon: Assets.half_circle, height: 100.0),
        HelperWidget.imageSet(icon: Assets.dotted, height: 50.0, width: 130.0)
      ],
    );
  }

  /*===================================================== profile header ========================================================*/

  Widget _profileHeader() => Container(
        height: 120.0,
        width: 120.0,
        child: Stack(
          children: [
            Center(
                child: HelperWidget.setFileImage(
                    width: 120.0,
                    height: 120.0,
                    url: profileFile.path,
                    raduis: 120.0)),
            Positioned(
                bottom: 5,
                right: 0,
                child: Image.asset(
                  Assets.camera,
                  height: 30,
                  width: 30,
                )),
          ],
        ),
      );

  Widget _profileAssetsHeader() => Center(
        child: Stack(
          children: [
            HelperWidget.circleImageNetWork(
                width: 120.0,
                height: 120.0,
                imageurl: imageUrl + data?.profileFile,
                radius: 120.0),
            Positioned(
                bottom: 5,
                right: 0,
                child: Image.asset(
                  Assets.camera,
                  height: 30,
                  width: 30,
                )),
          ],
        ),
      );

  /*================================================================ Creation of From ========================================================*/

  _form() => Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _firstNameEditText(),
            _phoneNumberField(),
            _emailEditText(),
            _dobEditText(),
            data.roleId == ROLE_PROFESSIONAL ? _userLocation() : Container(),
            _descriptionEditText(),
          ],
        ),
      );

  Widget _firstNameEditText() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
        focusNode: _firstNode,
        textController: _nameTextController,
        hint: Strings.name,
        inputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_phoneNumberNode);
        },
        validate: (String val) {
          if (val.length < 1)
            return Strings.fieldCantBeEmpty;
          else
            return null;
        },
        inputType: TextInputType.text,
        icon: Assets.last_name,
      ));

  /*=================================================================== Email Edit Text ====================================================================*/

  Widget _emailEditText() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
        readonly: true,
        focusNode: _emailNode,
        textController: _emailTextController,
        hint: data.email ?? Strings.email,
        inputAction: TextInputAction.done,
        validate: (String val) {
          return EmailFormValidator.validate(val);
        },
        inputType: TextInputType.text,
        icon: Assets.emailProfile,
      ));

  Widget _userLocation() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
        onTap: () {
          showCountryList();
        },
        readonly: true,
        focusNode: _locationNode,
        textController: _locationTextController,
        hint: Strings.location,
        isObsecure: false,
        inputAction: TextInputAction.next,
        validate: (String val) {
          if (val.length < 1)
            return Strings.fieldCantBeEmpty;
          else
            return null;
        },
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_aboutmeNode);
        },
        inputType: TextInputType.text,
        icon: Assets.location,
      ));

  /*====================================================================== Password Edit Text Field ==========================================================*/

  _phoneNumberField() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
        focusNode: _phoneNumberNode,
        textController: _phoneTextController,
        hint: Strings.contactNumber,
        isObsecure: false,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_dobNode);
        },
        validate: (String val) {
          return FieldChecker.validateMobile(val);
        },
        maxLength: 15,
        inputAction: TextInputAction.next,
        inputType: TextInputType.number,
        icon: Assets.contactnumber,
      ));

  _onSaveButtonPress() => Padding(
        padding: EdgeInsets.only(left: 20, right: 20.0),
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
              if (_locationTextController.text.length > 0 &&
                  data.roleId == ROLE_PROFESSIONAL)
                profileSetupApiCall();
              else if (_locationTextController.text.length < 1 &&
                  data.roleId == ROLE_PROFESSIONAL)
                HelperWidget.toast(Strings.pleaseSelectCountry);
              else
                profileSetupApiCall();
            }
          },
          buttonColor: primaryColor,
        ),
      );

  _dobEditText() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
        onTap: () {
          print("********" + _dobTextController.text);
          _selectDate(context, _dobTextController);
        },
        readonly: true,
        focusNode: _dobNode,
        textController: _dobTextController,
        hint: Strings.dobyy,
        isObsecure: false,
        inputAction: TextInputAction.next,
        validate: (String val) {
          if (val.length < 1)
            return Strings.fieldCantBeEmpty;
          else
            return null;
        },
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_locationNode);
        },
        inputType: TextInputType.datetime,
        icon: Assets.dob,
      ));

  Padding _descriptionEditText() {
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20.0),
        child: TextFieldRect(
          minLines: 4,
          focusNode: _aboutmeNode,
          textController: _aboutmeTextController,
          hint: Strings.aboutme,
          iconMargin: Dimens.margin_15,
          inputType: TextInputType.multiline,
          width: Dimens.width_25,
          height: Dimens.height_25,
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
          },
          validate: (String val) {
            if (val.length < 10)
              return Strings.descriptionMsg;
            else
              return null;
          },
        ));
  }
}
