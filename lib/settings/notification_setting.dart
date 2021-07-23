// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:alanis/export.dart';

class NotificationSetting extends StatefulWidget {
  @override
  _NotificationSettingState createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  bool newReply = true;
  bool replyToFollowReq = true;
  bool likedPost = true;
  CheckUserModel user = CheckUserModel();
  CustomLoader _customLoader;

  @override
  void initState() {
    super.initState();
    _customLoader = CustomLoader();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperWidget.appBar(
          title: Strings.notificationSetting, context: context),
      body: _body(),
    );
  }

  _body() {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: [
          newReplyListTile(),
          followRequestListTile(),
          likedPostListTile(),
        ],
      ),
    );
  }

  newReplyListTile() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      title: Text(Strings.newReply),
      trailing: Transform.scale(
        scale: .7,
        child: CupertinoSwitch(
          activeColor: primaryColor,
          value: newReply,
          onChanged: (val) {
            newReply = val;
            toggleReply();
          },
        ),
      ),
    );
  }

  followRequestListTile() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      title: Text(Strings.replyToFollowReq),
      trailing: Transform.scale(
        scale: .7,
        child: CupertinoSwitch(
          activeColor: primaryColor,
          value: replyToFollowReq,
          onChanged: (val) {
            replyToFollowReq = val;
            toggleRequest();
          },
        ),
      ),
    );
  }

  likedPostListTile() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      title: Text(Strings.likePost),
      trailing: Transform.scale(
        scale: .7,
        child: CupertinoSwitch(
          activeColor: primaryColor,
          value: likedPost,
          onChanged: (val) {
            likedPost = val;
            toggleLikePost();
          },
        ),
      ),
    );
  }

  toggleReply() async {
    _customLoader.show(context);
    var response = AuthRequestModel.enableReply(isReply: newReply ? 1 : 0);
    await APIRepository.enableReply(response, context).then((value) {
      if (value != null) checkUser();
      _customLoader.hide();
    }).onError((error, stackTrace) {
      _customLoader.hide();
      HelperWidget.toast(error);
    });
  }

  toggleRequest() async {
    _customLoader.show(context);
    var response =
        AuthRequestModel.enableRequest(isFollow: replyToFollowReq ? 1 : 0);
    await APIRepository.enableRequest(response, context).then((value) {
      if (value != null) checkUser();
      _customLoader.hide();
    }).onError((error, stackTrace) {
      _customLoader.hide();
      HelperWidget.toast(error);
    });
  }

  toggleLikePost() async {
    _customLoader.show(context);
    var response = AuthRequestModel.enableLikePost(isPost: likedPost ? 1 : 0);
    await APIRepository.enableLikePost(response, context).then((value) {
      if (value != null) checkUser();
      _customLoader.hide();
    }).onError((error, stackTrace) {
      _customLoader.hide();
      HelperWidget.toast(error);
    });
  }

  void checkUser() async {
    await APIRepository.checkuser(context).then((value) {
      if (value != null) {
        if (mounted) user = value;
        newReply = user.detail.isReply != null && user.detail.isReply == 1
            ? true
            : false;
        replyToFollowReq =
            user.detail.isFollow != null && user.detail.isFollow == 1
                ? true
                : false;
        likedPost = user.detail.isPost != null && user.detail.isPost == 1
            ? true
            : false;
        setState(() {});
      }
    }).onError((error, stackTrace) {
      HelperWidget.toast(error.toString());
    });
  }
}
