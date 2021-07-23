// Project imports:
import 'package:alanis/export.dart';

class RisingStarQuestion extends StatefulWidget {
  @override
  _RisingStarQuestionState createState() => _RisingStarQuestionState();
}

class _RisingStarQuestionState extends State<RisingStarQuestion> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _whereStudying;
  TextEditingController _whatStudying;
  TextEditingController _futureGoal;
  TextEditingController _seehere;
  FocusNode _whereStudyingNode;
  FocusNode _whatStudyingNode;
  FocusNode _futureGoalNode;
  FocusNode _seehereNode;
  bool ask, getadvice, meetpeople, looking, justbrowsw;
  RisingStarQuestionModel _risingStarQuestionModel;
  CustomLoader _customLoader = CustomLoader();
  bool hasData;
  SubmitRisingModel _submitRisingModel = SubmitRisingModel();
  List<String> achievement = [];
  int dataLength;

  @override
  void initState() {
    super.initState();
    ask = false;
    getadvice = false;
    meetpeople = false;
    looking = false;
    justbrowsw = false;
    _whereStudying = TextEditingController();
    _whatStudying = TextEditingController();
    _futureGoal = TextEditingController();
    _seehere = TextEditingController();
    _whereStudyingNode = new FocusNode();
    _whatStudyingNode = new FocusNode();
    _futureGoalNode = new FocusNode();
    _seehereNode = new FocusNode();
    getRisingStarQuestion();
    hasData = false;
    dataLength = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          bottom: false,
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
            body: hasData
                ? SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: dataLength < 3
                        ? Center(child: Text(Strings.noQuestionFound))
                        : Column(
                            children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _whereStudyingText(),
                                    _whatStudyingText(),
                                    _futureGoalText(),
                                    checkBoxes(),
                                    _seehereText(),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              _onSave(),
                              SizedBox(height: 20),
                            ],
                          ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                      backgroundColor: Colors.white,
                    ),
                  ),
          )),
    );
  }

  getRisingStarQuestion() async {
    await APIRepository.risingStarQuestion(context).then((value) {
      if (value != null) {
        _risingStarQuestionModel = value;
        dataLength = _risingStarQuestionModel.list.length;
        hasData = true;
        if (mounted) setState(() {});
      } else {
        _customLoader.hide();
      }
    }).onError((error, stackTrace) {
      _customLoader.hide();
      HelperWidget.toast(error);
    });
  }

  void saveQuestion() async {
    hideKeyBoard(context: context);
    _customLoader.show(context);
    if (ask == true) achievement.add(Strings.askQuestion);
    if (getadvice == true) achievement.add(Strings.getAdvice);
    if (meetpeople == true) achievement.add(Strings.meetNewPeople);
    if (looking == true) achievement.add(Strings.lookingForInsp);
    if (justbrowsw == true) achievement.add(Strings.justWantToBrowse);

    var response = dataLength < 4
        ? AuthRequestModel.submitRisingStarJson(answer: [])
        : AuthRequestModel.submitRisingStarJson(answer: [
            {
              "question_id": _risingStarQuestionModel?.list[0]?.id ?? 0,
              "description": _whereStudying.text,
              "achievement": "  ",
              "other": achievement.join(',')
            },
            {
              "question_id": _risingStarQuestionModel?.list[1]?.id ?? 1,
              "description": _whatStudying.text,
              "achievement": "  ",
              "other": achievement.join(',')
            },
            {
              "question_id": _risingStarQuestionModel?.list[2]?.id ?? 2,
              "description": _futureGoal.text,
              "achievement": "  ",
              "other": achievement.join(',')
            },
            {
              "question_id": _risingStarQuestionModel?.list[3]?.id ?? 3,
              "description": _seehere.text,
              "achievement": "  ",
              "other": achievement.join(',')
            },
          ]);
    await APIRepository.submitRisingStarQuestion(response, context)
        .then((value) {
      _customLoader.hide();
      _submitRisingModel = value;
      HelperWidget.toast(_submitRisingModel.message);
      _clearEditText();
      HelperUtility.push(context: context, route: ProfileSetUp());
    }).onError((error, stackTrace) {
      _customLoader.hide();
      HelperWidget.toast(error);
    });
  }

  _whereStudyingText() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
        focusNode: _whereStudyingNode,
        textController: _whereStudying,
        hint: _risingStarQuestionModel?.list[0]?.title ?? "",
        isObsecure: false,
        inputAction: TextInputAction.next,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[A-Za-z0-9#+-./:@] *"))
        ],
        validate: (val) {
          if (val == null || val.length < 2)
            return Strings.fieldCantBeEmpty;
          else
            return null;
        },
      ));

  _whatStudyingText() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[A-Za-z0-9#+-./:@] *"))
        ],
        focusNode: _whatStudyingNode,
        textController: _whatStudying,
        hint: _risingStarQuestionModel?.list[1]?.title ?? "",
        isObsecure: false,
        inputAction: TextInputAction.next,
        validate: (val) {
          if (val == null || val.length < 2)
            return Strings.fieldCantBeEmpty;
          else
            return null;
        },
      ));

  _futureGoalText() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[A-Za-z0-9#+-./:@] *"))
        ],
        focusNode: _futureGoalNode,
        textController: _futureGoal,
        hint: _risingStarQuestionModel?.list[2]?.title ?? "",
        isObsecure: false,
        inputAction: TextInputAction.next,
        validate: (val) {
          if (val == null || val.length < 2)
            return Strings.fieldCantBeEmpty;
          else
            return null;
        },
      ));

  _seehereText() => Padding(
      padding: EdgeInsets.only(left: 20, right: 20.0),
      child: TextFieldWidget(
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[A-Za-z0-9#+-./:@] *"))
        ],
        focusNode: _seehereNode,
        textController: _seehere,
        hint: _risingStarQuestionModel?.list[3]?.title ?? "",
        isObsecure: false,
        inputAction: TextInputAction.next,
        validate: (val) {
          if (val == null || val.length < 2)
            return Strings.fieldCantBeEmpty;
          else
            return null;
        },
      ));

  _onSave() => Padding(
        padding: EdgeInsets.only(left: 20, right: 20.0),
        child: CustomButton(
          height: Dimens.height_45,
          isbold: true,
          buttonText: Strings.save,
          fontsize: Dimens.font_18,
          textColor: Colors.white,
          isIcon: false,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              saveQuestion();
            }
          },
          buttonColor: primaryColor,
        ),
      );

  checkBoxes() => Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 20, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.whatdoyouHope,
              style: HelperUtility.textStyleBold(fontWeight: FontWeight.w500),
            ),
            _ask(),
            _getadvice(),
            _meetpeople(),
            _looking(),
            _justbrowse()
          ],
        ),
      );

  _ask() {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      checkColor: Colors.white,
      title: Text(Strings.askQuestion),
      value: ask,
      dense: true,
      activeColor: primaryColor,
      onChanged: (val) {
        if (mounted)
          setState(() {
            ask = val;
          });
      },
    );
  }

  _getadvice() {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      checkColor: Colors.white,
      activeColor: primaryColor,
      title: Text(Strings.getAdvice),
      value: getadvice,
      dense: true,
      onChanged: (val) {
        if (mounted)
          setState(() {
            getadvice = val;
          });
      },
    );
  }

  _meetpeople() {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      checkColor: Colors.white,
      title: Text(Strings.meetNewPeople),
      value: meetpeople,
      dense: true,
      activeColor: primaryColor,
      onChanged: (val) {
        if (mounted)
          setState(() {
            meetpeople = val;
          });
      },
    );
  }

  _looking() {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      checkColor: Colors.white,
      activeColor: primaryColor,
      title: Text(Strings.lookingForInsp),
      value: looking,
      dense: true,
      onChanged: (val) {
        if (mounted)
          setState(() {
            looking = val;
          });
      },
    );
  }

  _justbrowse() {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      checkColor: Colors.white,
      activeColor: primaryColor,
      title: Text(Strings.justWantToBrowse),
      value: justbrowsw,
      dense: true,
      onChanged: (val) {
        if (mounted)
          setState(() {
            justbrowsw = val;
          });
      },
    );
  }

  checkboxListTile(String label, bool value) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      checkColor: primaryColor,
      title: Text(label),
      value: value,
      dense: true,
      onChanged: (val) {
        if (mounted)
          setState(() {
            value = val;
          });
      },
    );
  }

  void _clearEditText() {
    _whereStudying.clear();
    _whatStudying.clear();
    _futureGoal.clear();
    _seehere.clear();
  }
}
