// Package imports:
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:alanis/export.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController titleController;
  TextEditingController uploadTypeController;
  TextEditingController uploadFileController;
  TextEditingController tagUserEditTextController;
  TextEditingController discriptionController;
  FocusNode descNode;
  FocusNode tagInPostNode;
  FocusNode uploadNode;
  FocusNode uploadTypeNode;
  FocusNode additionalNode;
  String fileTypeString;
  File selectedFile;
  var multiPartFile;
  String whichSuffixIcon;
  bool flag = false;
  var fileType;
  CustomLoader _customLoader = CustomLoader();
  AddPostModel _addResponseModel = new AddPostModel();
  final _formKey = GlobalKey<FormState>();
  MyFollower myFollowing = new MyFollower();
  List<bool> _isChecked;
  List<String> selectedList = [];
  List<String> selectidList = [];
  var _currentSelectedValue;
  var _fileTypes = [TEXT, PICTURE, VIDEO];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    if (mounted)
      setState(() {
        titleController = TextEditingController();
        tagUserEditTextController = TextEditingController();
        uploadFileController = TextEditingController();
        discriptionController = TextEditingController();
        descNode = FocusNode();
        uploadTypeNode = FocusNode();
        uploadNode = FocusNode();
        tagInPostNode = FocusNode();
        additionalNode = FocusNode();
        myFollowingApiCall();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: HelperWidget.appBar(
          title: Strings.addPost,
          context: context,
          leading: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                HelperUtility.onBackPress(context: context);
              })),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimens.height_30),
            _form(),
            SizedBox(height: Dimens.height_30),
            _onSave()
          ],
        ),
      ),
    );
  }

  Widget _form() => Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _uploadTypeDrop(),
            _currentSelectedValue != TEXT ? _uploadField() : Container(),
            _tagField(),
            _descriptionEditText(),
          ],
        ),
      );

  Padding _descriptionEditText() {
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20.0),
        child: TextFieldRect(
          minLines: 4,
          maxLength: 2000,
          focusNode: additionalNode,
          textController: discriptionController,
          hint: Strings.desc,
          iconMargin: Dimens.margin_15,
          inputAction: TextInputAction.done,
          inputType: TextInputType.text,
          width: Dimens.width_25,
          height: Dimens.height_25,
        ));
  }

  Widget _uploadTypeDrop() => Padding(
        padding: EdgeInsets.only(left: 20, right: 20.0),
        child: TextFieldDropdown(
          hint: Strings.postType,
          focusNode: uploadTypeNode,
          iconMargin: Dimens.margin_10,
          items: _fileTypes.map((String value) {
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
                uploadFileController.clear();
                fileType = null;
              });
          },
        ),
      );

  Widget _uploadField() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
        readonly: _currentSelectedValue == TEXT ? false : true,
        focusNode: uploadNode,
        textController: uploadFileController,
        hint: _currentSelectedValue == TEXT
            ? Strings.enterText
            : Strings.uploadFile,
        suffixIcon: _currentSelectedValue == TEXT
            ? Strings.empty
            : fileType == null
                ? Assets.upload
                : whichSuffixIcon,
        inputAction: TextInputAction.next,
        inputType: TextInputType.visiblePassword,
        onTap: () {
          if (_currentSelectedValue == TEXT) {
          } else {
            filePicker();
          }
        },
      ));

  Widget _tagField() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
        readonly: true,
        textController: tagUserEditTextController,
        focusNode: tagInPostNode,
        hint: Strings.tagInPost,
        onTap: () {
          tagDialog();
        },
      ));

  myFollowingApiCall() async {
    await APIRepository.myFollowing(context).then((value) {
      myFollowing = value;
      _isChecked = List<bool>.filled(myFollowing.list.length, false);
    }).onError((error, stackTrace) {
      HelperWidget.toast(error);
    });
  }

  tagDialog() {
    var alert = StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => Dialog(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    padding: EdgeInsets.only(right: 20.0),
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                      selectedList.clear();
                    }),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 12.0, bottom: 20.0),
                  child: myFollowing.list != null &&
                          myFollowing?.list?.length != 0
                      ? ListView.separated(
                          itemCount: myFollowing.list.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return Divider(
                              thickness: 1,
                              color: Colors.grey[300],
                            );
                          },
                          itemBuilder: (context, index) {
                            var item = myFollowing.list[index];
                            return Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(70.0),
                                      child: FadeInImage(
                                        image: NetworkImage(item.profileFile),
                                        placeholder: AssetImage(Assets.profile),
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                SizedBox(width: 7.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      myFollowing?.list[index]?.fullName ?? "",
                                    ),
                                    myFollowing?.list[index]?.roleId ==
                                            ROLE_PROFESSIONAL
                                        ? Text(
                                            myFollowing?.list[index]
                                                        ?.risingDetail?.title ==
                                                    null
                                                ? getRole(myFollowing
                                                        ?.list[index]
                                                        ?.risingDetail
                                                        ?.field ??
                                                    1.toString())
                                                : toBeginningOfSentenceCase(
                                                    myFollowing?.list[index]
                                                        ?.risingDetail?.title),
                                            style: HelperUtility.textStyle(
                                                color: Colors.black,
                                                fontsize: 13.0),
                                          )
                                        : Text(Strings.risingstar,
                                            style: HelperUtility.textStyle(
                                                fontsize: 13,
                                                color: Colors.black
                                                    .withOpacity(0.7))),
                                  ],
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {});
                                  },
                                  child: Checkbox(
                                    activeColor: primaryColor,
                                    value: _isChecked[index],
                                    onChanged: (bool val) {
                                      setState(() {
                                        _isChecked[index] = val;
                                        if (_isChecked[index] == true) {
                                          selectidList.add(myFollowing
                                              .list[index].id
                                              .toString());
                                          selectedList.add(
                                              myFollowing.list[index].fullName);
                                        } else {
                                          selectidList.remove(myFollowing
                                              .list[index].id
                                              .toString());
                                          selectedList.remove(
                                              myFollowing.list[index].fullName);
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      : Center(
                          child: Container(
                          margin: EdgeInsets.only(top: 40.0, bottom: 40.0),
                          child: Text(Strings.nodataFound),
                        )),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20.0, bottom: 20.0),
                  child: CustomButton(
                    height: Dimens.height_45,
                    isbold: true,
                    buttonText: Strings.done,
                    fontsize: Dimens.font_18,
                    textColor: Colors.white,
                    isIcon: false,
                    onPressed: () {
                      setState(() {
                        tagUserEditTextController.text =
                            selectedList.join(' , ');
                        Navigator.pop(context);
                      });
                    },
                    buttonColor: primaryColor,
                  ),
                )
              ],
            )));

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _onSave() => Padding(
        padding: EdgeInsets.only(left: 20, right: 20.0),
        child: CustomButton(
          height: Dimens.height_45,
          isbold: true,
          buttonText: Strings.addPost,
          fontsize: Dimens.font_18,
          textColor: Colors.white,
          buttonIcon: Assets.facebook,
          isIcon: false,
          onPressed: () {
            if (discriptionController.text.length > 0 &&
                _currentSelectedValue != null &&
                flag == false)
              addPost();
            else if (flag)
              HelperWidget.toast(Strings.supportedSize);
            else if (_currentSelectedValue == null)
              HelperWidget.toast(Strings.selectPost);
            else if (_currentSelectedValue != TEXT &&
                !flag &&
                uploadFileController.text.length < 10)
              HelperWidget.toast(Strings.selectFile);
            else if (discriptionController.text.length < 1)
              HelperWidget.toast(Strings.enterDescription);
          },
          buttonColor: primaryColor,
        ),
      );

  void filePicker() async {
    var document = await FilePicker.getFile(
      type: _currentSelectedValue == PICTURE ? FileType.image : FileType.video,
    );

    File file = File(document.path);
    file.length().then((value) {
      var size = value / 1048576;
      if (size > 20)
        flag = true;
      else
        flag = false;
    });

    setState(() {
      selectedFile = file;
      uploadFileController.text = selectedFile.path;
      String mimeStr = lookupMimeType(document.path);
      fileType = mimeStr.split('/').last;
      switch (fileType) {
        case "mp4":
          whichSuffixIcon = "${Assets.video}";
          break;
        case "3gp":
          whichSuffixIcon = "${Assets.video}";
          break;
        case "png":
          whichSuffixIcon = "${Assets.image}";
          break;
        case "jpeg":
          whichSuffixIcon = "${Assets.image}";
          break;
        case "jpg":
          whichSuffixIcon = "${Assets.image}";
          break;
        case "heic":
          whichSuffixIcon = "${Assets.image}";
          break;
        case "mp3":
          whichSuffixIcon = "${Assets.audio}";
      }
    });
  }

  /*========================================================================Api Call===================================================================================*/
  void addPost() async {
    String tagId = "";
    if (selectidList != null && selectidList.length != 0) {
      for (int i = 0; i < selectidList.length; i++) {
        if (tagId == "") {
          tagId = selectidList[i];
        } else {
          tagId = tagId + "," + selectidList[i];
        }
      }
    }
    hideKeyBoard(context: context);
    _customLoader.show(context);
    if (selectedFile != null) {
      multiPartFile = await MultipartFile.fromFile(selectedFile.path,
          filename: selectedFile.path);
    }

    var response = AuthRequestModel.addPost(
      title: no_title /*titleController.text.trim()*/,
      tagId: tagId,
      typeId: _currentSelectedValue == TEXT
          ? TYPE_AUDIO
          : _currentSelectedValue == PICTURE
              ? TYPE_IMAGE
              : TYPE_VIDEO,
      file: multiPartFile ?? null,
      description: discriptionController.text.trim(),
    );
    await APIRepository.addPostApi(context: context, dataBody: response)
        .then((value) {
      _customLoader.hide();
      _addResponseModel = value;
      if (mounted) {
        showAnimation();
      }
      _clearEditText();
    }).onError((error, stackTrace) {
      _customLoader.hide();
      HelperWidget.toast(error);
    });
  }

  void _clearEditText() {
    uploadFileController.clear();
    titleController.clear();
    tagUserEditTextController.clear();
    selectedFile = null;
  }

  Future<void> showAnimation() async {
    if (int.parse(_addResponseModel.detail.countPost) == 15) {
      showAlertDialog(context);
    } else if (int.parse(_addResponseModel.detail.countPost) == 40) {
      showAlertDialog(context);
    } else if (int.parse(_addResponseModel.detail.countPost) == 70) {
      showAlertDialog(context);
    } else if (int.parse(_addResponseModel.detail.countPost) == 100) {
      showAlertDialog(context);
    } else if (int.parse(_addResponseModel.detail.countPost) == 125) {
      showAlertDialog(context);
    } else {
      HelperWidget.toast(_addResponseModel.message);
      HelperUtility.push(context: context, route: BottomNavigationScreen(0));
    }
  }

  showAlertDialog(BuildContext context) async {
    Dialog alert = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Lottie.asset(Assets.bubble),
          Positioned(
              top: 50,
              child: Text(
                Strings.congratulations,
                style: HelperUtility.textStyleBold(fontsize: 22),
              )),
          _addResponseModel.detail.roleId == ROLE_PROFESSIONAL
              ? Image.asset(
                  getProfessionalBadge(_addResponseModel.detail.countPost) ??
                      "",
                  height: 80,
                  width: 70,
                  fit: BoxFit.fitHeight,
                )
              : Image.asset(
                  getRisingBadge(_addResponseModel.detail.countPost) ?? "",
                  height: 80,
                  width: 80,
                  fit: BoxFit.fitHeight,
                ),
          Positioned(
              bottom: 50,
              child: Text(
                Strings.youLeveledUP,
                style: HelperUtility.textStyleBold(
                    fontsize: 18, color: Colors.grey.withOpacity(0.8)),
              )),
        ],
      ),
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return alert;
        });
    doneAnimation(context);
  }

  doneAnimation(context) {
    if (mounted)
      Timer(Duration(seconds: 5), () {
        Navigator.pop(context);
        HelperUtility.push(context: context, route: BottomNavigationScreen(0));
      });
  }

  @override
  void dispose() {
    super.dispose();
    _customLoader.hide();
  }
}
