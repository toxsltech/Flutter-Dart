// Project imports:
import 'package:alanis/export.dart';

class CommentsScreen extends StatefulWidget {
  final Map<dynamic, dynamic> arguments;

  CommentsScreen(this.arguments);

  @override
  _CommentsScreenState createState() => _CommentsScreenState(arguments);
}

class _CommentsScreenState extends State<CommentsScreen> {
  final Map arguments;
  final ScrollController _scrollController = ScrollController();

  _CommentsScreenState(this.arguments);

  var argID;
  TextEditingController commentsController = new TextEditingController();
  FocusNode descNode = new FocusNode();
  final _formKey = GlobalKey<FormState>();
  CustomLoader _customLoader = CustomLoader();
  PostList postList;
  CommentListDataModel _commentListDataModel = new CommentListDataModel();
  bool _isloading = true;
  LoginDataModel data = LoginDataModel();
  int modelId;

  @override
  void initState() {
    super.initState();
    argID = widget.arguments['userID'];
    modelId = widget.arguments['modelID'];
    commentListApiCall();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: WillPopScope(
          onWillPop: onWillPop,
          child: Scaffold(
            appBar: _appBar(),
            body: _body(),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    if (widget.arguments['home'] == 'home') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavigationScreen(0),
          ));
      return Future.value(true);
    } else if (widget.arguments['home'] == 'profile') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => BottomNavigationScreen(2)));
      return Future.value(true);
    } else if (widget.arguments['home'] == 'detail') {
      HelperUtility.pushNameRemoveUntil(
          context: context,
          route: Routes.professionalDetail,
          arguments: {'arg': argID, 'home': 'comment'});
      return Future.value(true);
    } else if (widget.arguments['home'] == 'post') {
      HelperUtility.pushReplacementNamed(
          context: context,
          route: Routes.postdetails,
          arguments: {
            "modelID": widget.arguments['modelID'],
            'home': 'comment'
          });
      return Future.value(true);
    } else {
      Navigator.pop(context, "refresh");
      return Future.value(true);
    }
  }

  Widget _appBar() {
    return AppBar(
        title: Text(
          Strings.comments,
          style: HelperUtility.textStyleBold(color: Colors.white, fontsize: 16),
        ),
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            if (widget.arguments['home'] == 'home')
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavigationScreen(0),
                  ));
            else if (widget.arguments['home'] == 'profile')
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavigationScreen(2),
                  ));
            else if (widget.arguments['home'] == 'detail')
              HelperUtility.pushNameRemoveUntil(
                  context: context,
                  route: Routes.professionalDetail,
                  arguments: {'arg': argID, 'home': 'home'});
            else if (widget.arguments['home'] == 'post')
              HelperUtility.pushReplacementNamed(
                  context: context,
                  route: Routes.postdetails,
                  arguments: {
                    "modelID": widget.arguments['modelID'],
                    'home': 'comment'
                  });
            else
              Navigator.pop(context, "refresh");
          },
        ));
  }

  Widget _body() {
    return _isloading != true
        ? Column(
            children: [
              Expanded(
                child: _commentListDataModel.list.isEmpty
                    ? Center(
                        child: Text("No Comments Yet"),
                      )
                    : commentsList(),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    _form(),
                    _postButton(),
                  ],
                ),
              ),
            ],
          )
        : Center(
            child: CircularProgressIndicator(
            color: primaryColor,
            backgroundColor: Colors.white,
          ));
  }

  _form() => Form(
        key: _formKey,
        child: Expanded(
          child: TextFormField(
            autocorrect: true,
            enableSuggestions: true,
            focusNode: descNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: commentsController,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 3,
            decoration: InputDecoration(
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              errorStyle: TextStyle(
                fontSize: 0,
                height: 0,
              ),
              hintText: Strings.writeacomment,
              icon: Container(
                height: 35,
                width: 35,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: HelperUtility.cachedImage(
                      imageUrl + data?.profileFile ?? "",
                      hash: (blurhashes.toList()..shuffle()).first,
                      height: 35,
                      width: 35),
                ),
              ),
            ),

            textInputAction: TextInputAction.done,
            validator: (val) {
              if (val.length == null || val.length < 1)
                return "";
              else
                return null;
            },
            //onFieldSubmitted: addComment,
          ),
        ),
      );

  Widget _postButton() {
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState.validate()) {
          commentApiCall();
          FocusScope.of(context).unfocus();
        } else
          HelperWidget.toast("Comment can't be empty");
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          Strings.post,
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }

  Widget commentsList() {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      controller: _scrollController,
      shrinkWrap: true,
      reverse: true,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 35,
              width: 35,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: HelperUtility.cachedImage(
                    "$imageUrl${_commentListDataModel?.list[index]?.createdBy?.profileFile}",
                    hash: (blurhashes.toList()..shuffle()).first,
                    height: 35,
                    width: 35),
              ),
            ),
            HelperWidget.sizeBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${_commentListDataModel.list[index].createdBy.fullName}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  HelperWidget.sizeBox(width: 10),
                  Text(
                    "${_commentListDataModel?.list[index]?.comment}",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    whatTime(_commentListDataModel?.list[index]?.createdOn),
                    style: TextStyle(fontSize: 10),
                  ),
                  HelperWidget.sizeBox(width: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      itemCount: _commentListDataModel?.list?.length == null
          ? 0
          : _commentListDataModel?.list?.length,
    );
  }

  void commentApiCall() async {
    hideKeyBoard(context: context);
    _customLoader.show(context);
    var response = AuthRequestModel.commentsRequestData(
      id: modelId,
      comment: commentsController.text.trim(),
    );
    await APIRepository.commentapi(dataBody: response, context: context)
        .then((value) {
      commentsController.clear();
      if (value != null) {
        _customLoader.hide();
        if (mounted)
          setState(() {
            commentListApiCall();
          });
        commentsController.clear();
      }
    }).onError((error, stackTrace) {
      commentsController.clear();
      commentListApiCall();
      _customLoader.hide();
      if (error.toString() != Strings.unableToProcessData)
        HelperWidget.toast(error.toString());
    });
  }

  void commentListApiCall() async {
    await APIRepository.commentListApi(
            context: context, id: widget.arguments['modelID'])
        .then((value) {
      if (value != null) {
        if (mounted)
          setState(() {
            _commentListDataModel = value;
            for (int i = 0; i < _commentListDataModel.list.length; i++) {
              _commentListDataModel.list[i].like = false;
            }
            _isloading = false;
          });
      }
    }).onError((error, stackTrace) {
      HelperWidget.toast("$error");
    });
  }

  Future<void> getData() async {
    await PrefManger.getRegisterData().then((value) {
      if (mounted)
        setState(() {
          data = value;
          print("data.profileFile");
          print(data.profileFile);
        });
    });
  }
}
