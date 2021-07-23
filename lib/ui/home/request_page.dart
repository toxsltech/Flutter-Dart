// Project imports:
import 'package:alanis/export.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class RequestPage extends StatefulWidget {
  final bool notification;

  RequestPage({this.notification = false});

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  FriendRequest _friendRequest = FriendRequest();
  List<ShortDetail> friendRequestList = [];
  bool _friendRequestData = false;
  var data;
  ScrollController _scrollController = ScrollController();
  bool loadPginateData = false;
  int pagecount = 0;
  CustomLoader _customLoader = CustomLoader();

  void friendReqList() async {
    await APIRepository.friendRequest(context: context).then((value) {
      if (mounted)
        setState(() {
          _friendRequest = value;
          friendRequestList = _friendRequest.list;
          _friendRequestData = true;
        });
    }).onError((error, stackTrace) {
      HelperWidget.toast(error);
    });
  }

  void acceptOrReject({id, state}) async {
    var response = AuthRequestModel.acceptOrReject(state: state, id: id);
    _customLoader.show(context);
    await APIRepository.acceptOrReject(context: context, dataBody: response)
        .then((value) {
      if (mounted) setState(() {});
      friendReqList();
      _customLoader.hide();
    }).onError((error, stackTrace) {
      HelperWidget.toast(error);
      _customLoader.hide();
    });
  }

  paginateData() {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        pagecount++;

        if (pagecount < _friendRequest.mMeta.pageCount) {
          if (mounted)
            setState(() {
              loadPginateData = true;
            });
          await APIRepository.friendRequest(context: context).then((value) {
            if (mounted)
              setState(() {
                _friendRequest = value;
                friendRequestList.addAll(_friendRequest.list);
                _friendRequestData = true;
                loadPginateData = false;
              });
          }).onError((error, stackTrace) {
            HelperWidget.toast(error);
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    friendReqList();
    paginateData();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      switch (message.data['action']) {
        case "follow":
          friendReqList();
          break;
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      switch (message.data['action']) {
        case "follow":
          friendReqList();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: _appbar(),
        body: RefreshIndicator(
          color: primaryColor,
          onRefresh: () {
            return Future.delayed(Duration(milliseconds: 500), () {
              setState(() {
                pagecount = 0;
                friendReqList();
              });
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(
                top: Dimens.margin_10,
                left: Dimens.margin_15,
                right: Dimens.margin_15),
            child: _friendRequestData
                ? followRequestList()
                : Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                      backgroundColor: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    if (widget.notification) {
      Navigator.pop(context, "returned");
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => new BottomNavigationScreen(0),
            fullscreenDialog: true,
          ));
    }

    return Future.value(false);
  }

  Widget followRequestList() {
    return friendRequestList.length > 0
        ? Container(
            padding: EdgeInsets.only(top: Dimens.height_10),
            margin: EdgeInsets.zero,
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              controller: _scrollController,
              child: Column(
                children: [
                  ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                          height: 20,
                          child: Divider(
                            color: Colors.grey,
                          ));
                    },
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _friendRequest?.list?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: Dimens.height_60,
                              width: Dimens.height_60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: FadeInImage(
                                    placeholder: AssetImage(Assets.profile),
                                    image: NetworkImage(imageUrl +
                                            _friendRequest?.list[index]
                                                ?.createdBy?.profileFile ??
                                        ""),
                                    imageErrorBuilder: (_, __, ___) {
                                      return Image.asset(
                                        Assets.profile,
                                        fit: BoxFit.fill,
                                      );
                                    },
                                  )),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                          _friendRequest
                                              .list[index].createdBy.fullName,
                                          style: TextStyle(
                                              fontSize: Dimens.font_14,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(width: 8),
                                      friendRequestList[index]
                                                  .createdBy
                                                  .roleId ==
                                              ROLE_PROFESSIONAL
                                          ? Image.asset(
                                              getProfessionalBadge(
                                                      _friendRequest
                                                          .list[index]
                                                          ?.createdBy
                                                          ?.countPost) ??
                                                  "",
                                              height: 15,
                                              width: int.parse(_friendRequest
                                                          .list[index]
                                                          ?.createdBy
                                                          ?.countPost) >
                                                      14
                                                  ? 13
                                                  : 0,
                                              fit: BoxFit.fill,
                                            )
                                          : Image.asset(
                                              getRisingBadge(_friendRequest
                                                      .list[index]
                                                      ?.createdBy
                                                      ?.countPost) ??
                                                  "",
                                              height: 15,
                                              width: int.parse(_friendRequest
                                                          .list[index]
                                                          ?.createdBy
                                                          ?.countPost) >
                                                      14
                                                  ? 15
                                                  : 0,
                                              fit: BoxFit.cover,
                                            ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  if (friendRequestList[index]
                                          ?.createdBy
                                          ?.roleId ==
                                      ROLE_PROFESSIONAL)
                                    Text(
                                      getRole(_friendRequest
                                              .list[index]
                                              ?.createdBy
                                              ?.risingDetail
                                              ?.field ??
                                          1.toString()),
                                      style: HelperUtility.textStyle(
                                          color: Colors.black, fontsize: 12.0),
                                    )
                                  else
                                    Text(
                                      friendRequestList[index]
                                                  ?.createdBy
                                                  ?.roleId ==
                                              ROLE_PROFESSIONAL
                                          ? Strings.professional
                                          : Strings.risingstar,
                                      style: TextStyle(
                                        fontSize: Dimens.font_12,
                                      ),
                                    ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      if (_friendRequest
                                              .list[index]?.createdBy?.roleId ==
                                          ROLE_PROFESSIONAL)
                                        Text(
                                          Strings.professional,
                                          style: TextStyle(
                                              fontSize: Dimens.font_10,
                                              fontWeight: FontWeight.w500),
                                        )
                                      else
                                        Container(),
                                      Expanded(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              acceptOrReject(
                                                  id: _friendRequest
                                                      .list[index].id,
                                                  state: STATE_REJECTED);
                                            },
                                            child: HelperWidget.container(
                                              height: Dimens.margin_20,
                                              width: Dimens.height_60,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              widget: Center(
                                                child: Text("Decline",
                                                    style: TextStyle(
                                                        fontSize:
                                                            Dimens.font_12,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                acceptOrReject(
                                                    id: _friendRequest
                                                        .list[index].id,
                                                    state: STATE_ACCEPTED);
                                              },
                                              child: HelperWidget.container(
                                                height: Dimens.margin_20,
                                                width: Dimens.height_60,
                                                decoration: BoxDecoration(
                                                    color: Colors.green[700],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                widget: Center(
                                                  child: Text("Accept",
                                                      style: TextStyle(
                                                          fontSize:
                                                              Dimens.font_12,
                                                          color: Colors.white)),
                                                ),
                                              )),
                                        ],
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  loadPginateData
                      ? Container(
                          height: 60,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          )
        : Center(
            child: Text(
              "No pending requests",
              style: HelperUtility.textStyleBold(fontsize: 14),
            ),
          );
  }

  _appbar() {
    return HelperWidget.appBar(
        title: Strings.request,
        context: context,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            if (widget.notification) {
              Navigator.pop(context, "returned");
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new BottomNavigationScreen(0),
                    fullscreenDialog: true,
                  ));
            }
          },
        ));
  }

  @override
  void dispose() {
    _customLoader.hide();
    super.dispose();
  }
}
