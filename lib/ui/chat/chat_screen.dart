// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:alanis/export.dart';

class ChatScreen extends StatefulWidget {
  final Map<dynamic, dynamic> arguments;

  ChatScreen(this.arguments);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int userId;
  TextEditingController controller = TextEditingController();
  LoginDataModel _loginDataModel;
  OneToOneChatResponseModel _oneToOneChatResponseModel;
  List<OneToOneChatDataModel> chatList = [];
  Timer timer;
  Timer timerval;
  UserDetailModel userDetailModel;
  Detail data;
  bool hasData = false;
  ScrollController _scrollController = ScrollController();
  var maxScreen = 0.0;
  bool _refresh = false;

  @override
  void initState() {
    userId = widget.arguments['arg'];
    _loginDataModel = LoginDataModel();
    _oneToOneChatResponseModel = OneToOneChatResponseModel();
    userDetail(userId: userId, context: context);
    _getLocalData();
    getChat();
    getScreen();
    super.initState();
  }

  animateScroll({negative = 0}) {
    _scrollController.animateTo(
        _scrollController.position.minScrollExtent - negative,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut);
  }

  getScreen() {
    if (mounted)
      timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
        APIRepository.oneToOneChatApiCall(context, userId).then((value) {
          _oneToOneChatResponseModel = value;
          timerval = t;
          setState(() {
            chatList = _oneToOneChatResponseModel.list;
          });
        }).onError((error, stackTrace) {});
      });
  }

  _getLocalData() async {
    _loginDataModel = await PrefManger.getRegisterData();
  }

  getChat() {
    APIRepository.oneToOneChatApiCall(
      context,
      userId,
    ).then((value) {
      if (mounted)
        setState(() {
          _oneToOneChatResponseModel = value;

          chatList = _oneToOneChatResponseModel.list;
        });
    }).onError((error, stackTrace) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperWidget.appBar(
        title: data?.fullName ?? "",
        context: context,
      ),
      body: column(),
    );
  }

  column() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _refresh
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Center(child: CupertinoActivityIndicator()),
                )
              : SizedBox(),
          visibleChat(),
          vGap(10),
          typeMessageField(),
          vGap(10),
        ],
      ),
    );
  }

  leftUser(OneToOneChatDataModel item, index) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          leftSideImage(item),
          hGap(17),
          GestureDetector(
              onDoubleTap: () {
                chatList[index].checkLike = !chatList[index].checkLike;
                if (mounted) setState(() {});
                likeMessageApi(index);
              },
              child: chat(item, index)),
        ],
      ),
    );
  }

  leftImage(OneToOneChatDataModel item) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: FadeInImage.assetNetwork(
          placeholder: Assets.profile,
          image: imageUrl + item.fromUserProfileFile,
          fit: BoxFit.fitWidth,
        ));
  }

  Widget leftSideImage(OneToOneChatDataModel item) {
    return HelperUtility.imageContainer(
      height: 38,
      width: 38,
      color: primaryColor,
      radius: 50,
      widget: leftImage(item),
    );
  }

  Widget chat(OneToOneChatDataModel item, index) {
    return HelperUtility.chatDesign(
        color: Colors.pink.shade100,
        width: HelperUtility.fullWidthScreen(context: context) * 0.6,
        bottomleft: 0,
        bottomright: 10,
        topleft: 10,
        topright: 10,
        widget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.message,
                style: HelperUtility.textStyle(fontsize: 11.5),
              ),
              vGap(5),
              Row(
                children: [
                  Text(
                    whatTime(item.sendOn, lessThanAMinute: true),
                    style: HelperUtility.textStyle(fontsize: 10.5),
                  ),
                  hGap(20),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      chatList[index].checkLike = !chatList[index].checkLike;
                      if (mounted) setState(() {});
                      likeMessageApi(index);
                    },
                    child: Icon(
                      chatList[index].checkLike
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 16,
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  rightUser(OneToOneChatDataModel item, index) {
    return Container(
        margin: EdgeInsets.only(bottom: 15.0),
        alignment: Alignment.centerRight,
        child: HelperUtility.chatDesign(
            color: Colors.blue.shade100,
            width: HelperUtility.fullWidthScreen(context: context) * 0.6,
            bottomleft: 10,
            bottomright: 0,
            topleft: 10,
            topright: 10,
            widget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    item?.message ?? "Loading ...",
                    style: HelperUtility.textStyle(fontsize: 11.5),
                  ),
                  vGap(5),
                  if (item != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (chatList[index].checkLike)
                          Icon(
                            Icons.favorite,
                            size: 16,
                            color: Colors.red,
                          ),
                        if (chatList[index].checkLike) hGap(20),
                        Text(
                          whatTime(item.sendOn, lessThanAMinute: true),
                          style: HelperUtility.textStyle(fontsize: 10.5),
                        ),
                      ],
                    )
                ],
              ),
            )));
  }

  typeMessageField() {
    return Row(
      children: [
        textFiled(),
        hGap(12),
        sendIcon(),
      ],
    );
  }

  textFiled() {
    return Expanded(
      flex: 8,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
        ),
        child: Center(
          child: TextField(
            maxLines: 4,
            minLines: 1,
            controller: controller,
            autocorrect: true,
            enableSuggestions: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: primaryColor,
              hintText: Strings.typeHere,
              contentPadding: EdgeInsets.only(
                  left: Dimens.width_35,
                  right: Dimens.width_15,
                  top: 4,
                  bottom: 4),
              hintStyle: HelperUtility.textStyle(
                  fontsize: Dimens.font_16, color: Colors.white),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: primaryColor, width: 0)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: primaryColor, width: 0)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: primaryColor, width: 0)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: primaryColor, width: 0)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: primaryColor, width: 0)),
            ),
          ),
        ),
      ),
    );
  }

  bool sending = false;

  sendIcon() {
    return InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () {
          if (controller.text.isNotEmpty) {
            setState(() {
              sending = true;
            });
            String chat = controller.text;
            sendMessageApi(chat);
            // animateScroll();
            controller.clear();
            getChat();
          } else {
            HelperWidget.toast(Strings.enterMessage);
          }
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: primaryColor),
          child: Center(
            child: sending
                ? CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  )
                : Icon(
                    Icons.send_rounded,
                    size: 25,
                    color: Colors.white,
                  ),
          ),
        ));
  }

  visibleChat() {
    return Expanded(
      child: chatList == null || chatList?.length == 0
          ? Container()
          : ListView.builder(
              physics: ClampingScrollPhysics(),
              controller: _scrollController,
              itemBuilder: (builder, ind) {
                try {
                  var item = chatList[ind];
                  return item?.fromId == _loginDataModel?.id
                      ? rightUser(item, ind)
                      : leftUser(item, ind);
                } catch (exp) {
                  return null;
                }
              },
              itemCount: chatList?.length ?? 0,
              reverse: true,
            ),
    );
  }

  hGap(double i) => SizedBox(width: i);

  vGap(double i) => SizedBox(height: i);

  void sendMessageApi(chat) {
    var requestBody =
        ChatRequestModel.messageSendRequestBody(userId: userId, message: chat);
    APIRepository.sendMessageApiCall(context, requestBody).then((value) {
      if (mounted)
        setState(() {
          sending = false;
          controller.clear();
        });
      getChat();
    }).onError((error, stackTrace) {
      if (mounted)
        setState(() {
          sending = false;
        });
      if (error.toString() != Strings.unableToProcessData)
        HelperWidget.toast(error.toString());
    });
  }

  void likeMessageApi(index) async {
    var response = AuthRequestModel.chatLikeRequestData(
      chatId: chatList[index].id.toString(),
      modelId: userId.toString(),
    );
    await APIRepository.chatLikeApiCall(dataBody: response, context: context)
        .then((value) {
      if (value != null) {
        return response;
      }
    }).onError((error, stackTrace) {
      if (error.toString() != Strings.unableToProcessData)
      HelperWidget.toast(error);
    });
  }

  userDetail({int userId, BuildContext context}) async {
    var response = AuthRequestModel.userDetailParam(
      id: userId,
    );
    await APIRepository.userDetail(response, context).then((value) {
      if (value != null) {
        userDetailModel = value;
        data = userDetailModel.detail;
        if (mounted) setState(() {});
      }
    }).onError((error, stackTrace) {
      HelperWidget.toast(error.toString());
      return null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer.cancel();
      timer = null;
    }

    if (timerval != null) {
      timerval.cancel();
      timerval = null;
    }
    if (_scrollController != null) _scrollController.dispose();
  }
}
