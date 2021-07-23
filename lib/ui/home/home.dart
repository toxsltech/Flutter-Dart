// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:alanis/export.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String likeIndex;
  HomeResponseModel _homeResponseModel;
  CheckUserModel user = CheckUserModel();
  ScrollController _scrollController = ScrollController();
  int pagecount;
  List<PostList> list = [];
  Future _future;
  DateFormat dateTimeFormator = DateFormat('dd-MM-yyyy hh:mm a');
  int likeCount;
  ReusableVideoListController videoListController =
      ReusableVideoListController();
  bool _refresh = false;

  @override
  void initState() {
    super.initState();
    pagecount = 0;
    likeCount = 0;
    checkUser();
    _future = homeApiCall();
    paginateData();
    _homeResponseModel = HomeResponseModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: RefreshIndicator(
        child: tabbarList(),
        color: primaryColor,
        onRefresh: () {
          return Future.delayed(Duration(milliseconds: 500), () {
            setState(() {
              pagecount = 0;
              homeApiCall();
            });
          });
        },
      ),
    );
  }

  Widget _appBar() {
    return HelperWidget.appBar(
      title: Strings.home,
      context: context,
      leading: HelperWidget.getInkwell(
          onTap: () {
            HelperUtility.push(context: context, route: AddPost());
          },
          widget: Padding(
            padding: EdgeInsets.all(5.0),
            child: Image.asset(Assets.add, height: 20),
          )),
      actions: [
        Badge(
          badgeContent: Text(
            user?.detail?.countRequest ?? "0",
            style: HelperUtility.textStyle(
              color: user?.detail?.countRequest == null
                  ? primaryColor
                  : user?.detail?.countRequest == "0"
                      ? primaryColor
                      : Colors.white,
            ),
          ),
          badgeColor: user?.detail?.countRequest == null
              ? primaryColor
              : user?.detail?.countRequest == "0"
                  ? primaryColor
                  : Colors.red,
          elevation: 0,
          position: BadgePosition.topEnd(top: 4, end: 0),
          child: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: Image.asset(
                Assets.accounts,
                height: 25,
                width: 25,
              ),
              onPressed: () async {
                var datas = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RequestPage()),
                );
                if (datas == "returned") {
                  initState();
                }
              }),
        ),
        Badge(
          badgeContent: Text(
            user?.detail?.notificationCount ?? "0",
            style: HelperUtility.textStyle(
              color: user?.detail?.notificationCount == null
                  ? primaryColor
                  : user?.detail?.notificationCount == "0"
                      ? primaryColor
                      : Colors.white,
            ),
          ),
          badgeColor: user?.detail?.notificationCount == null
              ? Colors.transparent
              : user?.detail?.notificationCount == "0"
                  ? Colors.transparent
                  : Colors.red,
          elevation: 0,
          position: BadgePosition.topEnd(
              top:
                  int.parse(user?.detail?.notificationCount ?? "0") > 0 ? 4 : 3,
              end: 0),
          child: HelperWidget.getInkwell(
              onTap: () async {
                var data = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notifications()),
                );
                if (data == "notiifcationReturned") {
                  initState();
                }
              },
              widget: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Image.asset(
                    Assets.notifications,
                    height: 25,
                    color: Colors.white,
                  ))),
        ),
        SizedBox(width: 20),
      ],
    );
  }

  Widget tabbarList() {
    return FutureBuilder(
      future: _future,
      builder: (context, result) {
        switch (result.connectionState) {
          case ConnectionState.waiting:
            return PostShimmer();
            break;
          case ConnectionState.active:
            return Container();
            break;
          case ConnectionState.done:
            {
              if (result != null) {
                return _homeResponseModel?.list != null &&
                        _homeResponseModel?.list?.length != 0
                    ? SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        controller: _scrollController,
                        child: Column(
                          children: [
                            ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                separatorBuilder: (context, index) => Divider(
                                    thickness: 0.0,
                                    height: 0,
                                    color: Colors.grey.shade200),
                                itemCount: list?.length ?? 0,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        leading: GestureDetector(
                                          onTap: () {
                                            user.detail.id ==
                                                    list[index].createdById
                                                ? HelperUtility.pushReplacement(
                                                    context: context,
                                                    route:
                                                        BottomNavigationScreen(
                                                            2))
                                                : HelperUtility.pushNamed(
                                                    context: context,
                                                    route: Routes
                                                        .professionalDetail,
                                                    arguments: {
                                                        'arg': list[index]
                                                            .createdById,
                                                        'home': 'home'
                                                      });
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: HelperUtility.cachedImage(
                                                  list[index]
                                                      ?.createdBy
                                                      ?.profileFile,
                                                  hash: (blurhashes.toList()
                                                        ..shuffle())
                                                      .first,
                                                  height: 40,
                                                  width: 40),
                                            ),
                                          ),
                                        ),
                                        title: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                user.detail.id ==
                                                        list[index].createdById
                                                    ? HelperUtility.pushReplacement(
                                                        context: context,
                                                        route:
                                                            BottomNavigationScreen(
                                                                2))
                                                    : HelperUtility.pushNamed(
                                                        context: context,
                                                        route: Routes
                                                            .professionalDetail,
                                                        arguments: {
                                                            'arg': list[index]
                                                                .createdById,
                                                            'home': 'home'
                                                          });
                                              },
                                              child: Text(
                                                list[index]
                                                            .createdBy
                                                            .fullName
                                                            .length >=
                                                        15
                                                    ? list[index]
                                                            .createdBy
                                                            .fullName
                                                            .substring(0, 15) +
                                                        '...'
                                                    : "${list[index].createdBy.fullName}",
                                                style:
                                                    HelperUtility.textStyleBold(
                                                        fontsize: 16,
                                                        color: Colors.black),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            if (int.parse(list[index]
                                                    ?.createdBy
                                                    ?.countPost) >
                                                14)
                                              list[index].createdBy.roleId ==
                                                      ROLE_PROFESSIONAL
                                                  ? Image.asset(
                                                      getProfessionalBadge(list[
                                                                  index]
                                                              ?.createdBy
                                                              ?.countPost) ??
                                                          "",
                                                      height: 15,
                                                      width: int.parse(list[
                                                                      index]
                                                                  ?.createdBy
                                                                  ?.countPost) >
                                                              14
                                                          ? 13
                                                          : 0,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : Image.asset(
                                                      getRisingBadge(list[index]
                                                              ?.createdBy
                                                              ?.countPost) ??
                                                          "",
                                                      height: 15,
                                                      width: int.parse(list[
                                                                      index]
                                                                  ?.createdBy
                                                                  ?.countPost) >
                                                              14
                                                          ? 15
                                                          : 0,
                                                      fit: BoxFit.cover,
                                                    ),
                                            SizedBox(width: 5),
                                            Expanded(
                                              child: Text(
                                                "has published a new post.",
                                                overflow: TextOverflow.ellipsis,
                                                style: HelperUtility.textStyle(
                                                    fontsize: 16,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                        subtitle: Text(
                                          whatTime(list[index].createdOn),
                                          style: HelperUtility.textStyle(
                                              fontsize: 10, color: Colors.grey),
                                        ),
                                      ),
                                      Container(
                                        color: Colors.grey.shade200,
                                        padding: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            bottom: 10,
                                            top: 10),
                                        child: Column(
                                          children: [
                                            if (list[index].typeId ==
                                                    TYPE_IMAGE ||
                                                list[index].typeId ==
                                                    TYPE_VIDEO)
                                              Container(
                                                height: 200,
                                                width: HelperUtility
                                                    .fullWidthScreen(
                                                        context: context),
                                                child: list[index].typeId ==
                                                        TYPE_IMAGE
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 10),
                                                        child: HelperUtility.cachedImage(
                                                            imageUrl +
                                                                "${list[index]?.file?.key}",
                                                            boxFit:
                                                                BoxFit.contain,
                                                            hash: (blurhashes
                                                                    .toList()
                                                                      ..shuffle())
                                                                .first,
                                                            isPost: true),
                                                      )
                                                    : list[index].typeId ==
                                                            TYPE_VIDEO
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 10),
                                                            child:
                                                                ReusableVideoListWidget(
                                                              videoListData:
                                                                  VideoListData(
                                                                      "Video $index",
                                                                      imageUrl +
                                                                              "${list[index]?.file?.key}" ??
                                                                          ""),
                                                              videoListController:
                                                                  videoListController,
                                                              canBuildVideo:
                                                                  true,
                                                            ),
                                                          ) /*Container(height: 100,width: 200,color: Colors.red,)*/
                                                        : Container(),
                                              ),
                                            InkWell(
                                              onTap: () {
                                                HelperUtility.pushNamed(
                                                    context: context,
                                                    route: Routes.postdetails,
                                                    arguments: {
                                                      "modelID": list[index].id,
                                                      'home': 'home'
                                                    });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 8),
                                                decoration: BoxDecoration(
                                                    color: list[index]
                                                                .createdBy
                                                                .roleId ==
                                                            ROLE_PROFESSIONAL
                                                        ? darkPrimaryColor
                                                        : primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    HelperWidget.sizeBox(
                                                        height: 8.0),
                                                    Text(
                                                      list[index].description,
                                                      style: HelperUtility
                                                          .textStyleBold(
                                                              fontsize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    HelperWidget.sizeBox(
                                                        height: 8.0),
                                                    tags(index),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                              width: HelperUtility
                                                                  .fullWidthScreen(
                                                                      context:
                                                                          context),
                                                              child: Divider(
                                                                thickness: 0.8,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                        ),
                                                        Image.asset(
                                                            list[index]
                                                                        .createdBy
                                                                        .roleId ==
                                                                    ROLE_PROFESSIONAL
                                                                ? identifyLightPostType(
                                                                    isProf:
                                                                        true,
                                                                    type: list[
                                                                            index]
                                                                        .typeId)
                                                                : identifyLightPostType(
                                                                    isProf:
                                                                        false,
                                                                    type: list[
                                                                            index]
                                                                        .typeId),
                                                            height: 35)
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            likeIndex =
                                                                "${list[index].id}";
                                                            if (mounted)
                                                              setState(() {
                                                                if (list[index]
                                                                        .checkLike ==
                                                                    false) {
                                                                  list[index]
                                                                          .checkLike =
                                                                      true;
                                                                  list[index]
                                                                          .likes =
                                                                      list[index]
                                                                              .likes -
                                                                          1;
                                                                } else {
                                                                  list[index]
                                                                          .checkLike =
                                                                      false;
                                                                  list[index]
                                                                          .likes =
                                                                      list[index]
                                                                              .likes +
                                                                          1;
                                                                }
                                                              });
                                                            likeApiCall(
                                                                likeIndex);
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                list[index].checkLike ==
                                                                        true
                                                                    ? Icons
                                                                        .star_border
                                                                    : Icons
                                                                        .star,
                                                                color: Colors
                                                                    .white,
                                                                size: 20,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                  "${list[index].likes}",
                                                                  style: HelperUtility.textStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontsize:
                                                                          13.0)),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            HelperUtility.pushNamed(
                                                                context:
                                                                    context,
                                                                route: Routes
                                                                    .commentscreen,
                                                                arguments: {
                                                                  'home':
                                                                      'home',
                                                                  'userID': user
                                                                      .detail
                                                                      .id,
                                                                  'modelID':
                                                                      list[index]
                                                                          .id,
                                                                });
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                Assets.comments,
                                                                height: 15,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                  "${list[index].comments ?? "0"}",
                                                                  style: HelperUtility.textStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontsize:
                                                                          13.0)),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                }),
                            _refresh
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
                      )
                    : Center(
                        child: Container(
                        margin: EdgeInsets.only(top: 40.0, bottom: 40.0),
                        child: Text(Strings.nodataFound),
                      ));
              } else {
                return Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 40.0, bottom: 40.0),
                  child: Text(Strings.nodataFound),
                ));
              }
            }
            break;
          case ConnectionState.none:
            return Container();
            break;
          default:
            return Container();
        }
      },
    );
  }

  tags(index) {
    if (list[index].tags.length == 0) {
      return Container();
    } else if (list[index].tags.length == 1) {
      return Row(
        children: [
          Image.asset(
            Assets.tag,
            height: 16,
            width: 16,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 4),
          Text("${list[index].tags[0].fullName}",
              style:
                  HelperUtility.textStyle(fontsize: 12, color: Colors.white)),
        ],
      );
    } else if (list[index].tags.length == 2) {
      return Row(
        children: [
          Image.asset(
            Assets.tag,
            height: 16,
            width: 16,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 4),
          Text(
              "${list[index].tags[0].fullName}" +
                  " , " +
                  "${list[index].tags[1].fullName}",
              style:
                  HelperUtility.textStyle(fontsize: 12, color: Colors.white)),
        ],
      );
    } else if (list[index].tags.length > 2) {
      return InkWell(
        onTap: () {
          taggedListDialog(index);
        },
        child: Row(
          children: [
            Image.asset(
              Assets.tag,
              height: 16,
              width: 16,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 4),
            Text(
                "${list[index].tags[0].fullName}" +
                    " , " +
                    "${list[index].tags[1].fullName}"
                        " + " +
                    "${list[index].tags.length - 2}" +
                    " others",
                style:
                    HelperUtility.textStyle(fontsize: 12, color: Colors.white)),
          ],
        ),
      );
    }
  }

  taggedListDialog(listIndex) {
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
                    }),
                Container(
                    padding:
                        EdgeInsets.only(left: 20, right: 12.0, bottom: 20.0),
                    child: FutureBuilder(
                      future: _future,
                      builder: (context, result) {
                        switch (result.connectionState) {
                          case ConnectionState.waiting:
                            return Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                                backgroundColor: Colors.white,
                              ),
                            );
                            break;
                          case ConnectionState.active:
                            return Container();
                            break;
                          case ConnectionState.done:
                            {
                              if (result != null) {
                                return list != null && list?.length != 0
                                    ? ListView.separated(
                                        itemCount: list[listIndex].tags.length,
                                        shrinkWrap: true,
                                        separatorBuilder: (context, index) {
                                          return Divider(
                                            thickness: 1,
                                            color: Colors.grey[300],
                                          );
                                        },
                                        itemBuilder: (context, index) {
                                          var item =
                                              list[listIndex].tags[index];
                                          return Row(
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 40,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            70.0),
                                                    child: FadeInImage(
                                                      image: NetworkImage(
                                                          imageUrl +
                                                              item.profileFile),
                                                      placeholder: AssetImage(
                                                          Assets.profile),
                                                      width: 40,
                                                      height: 40,
                                                      fit: BoxFit.cover,
                                                    )),
                                              ),
                                              SizedBox(width: 7.0),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    list[listIndex]
                                                            .tags[index]
                                                            ?.fullName ??
                                                        "",
                                                  ),
                                                  list[listIndex]
                                                              .tags[index]
                                                              ?.roleId ==
                                                          ROLE_PROFESSIONAL
                                                      ? Text(
                                                          "Pro",
                                                          style: HelperUtility
                                                              .textStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontsize:
                                                                      13.0),
                                                        )
                                                      : Text(Strings.risingstar,
                                                          style: HelperUtility
                                                              .textStyle(
                                                                  fontsize: 13,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.7))),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      )
                                    : Center(
                                        child: Container(
                                        margin: EdgeInsets.only(
                                            top: 40.0, bottom: 40.0),
                                        child: Text(Strings.nodataFound),
                                      ));
                              } else {
                                return Center(
                                    child: Container(
                                  margin:
                                      EdgeInsets.only(top: 40.0, bottom: 40.0),
                                  child: Text(Strings.nodataFound),
                                ));
                              }
                            }
                            break;
                          case ConnectionState.none:
                            return Container();
                            break;
                          default:
                            return Container();
                        }
                      },
                    )),
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

  void likeApiCall(val) async {
    var response = AuthRequestModel.likeRequestData(
      id: val,
    );
    await APIRepository.likeapi(dataBody: response, context: context)
        .then((value) {
      if (value != null) {}
    }).onError((error, stackTrace) {
      if (error.toString() != Strings.unableToProcessData)
      HelperWidget.toast(error);
    });
  }

  void checkUser() async {
    await APIRepository.checkuser(context).then((value) {
      if (value != null) {
        if (mounted) {
          user = value;
          setState(() {});
        }
      }
    }).onError((error, stackTrace) {
      HelperWidget.toast(error.toString());
    });
  }

  homeApiCall() async {
    await APIRepository.homeapi(context: context, page: pagecount)
        .then((value) {
      if (value != null) {
        if (mounted) {
          _homeResponseModel = value;
          if (pagecount == 0) {
            list = _homeResponseModel.list;
          } else {
            list.addAll(_homeResponseModel.list);
          }
        }
      }
    }).onError((error, stackTrace) {
      HelperWidget.toast(error);
    });
  }

  paginateData() {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        pagecount++;

        if (pagecount < _homeResponseModel.mMeta.pageCount) {
          _refresh = true;
          if (mounted) setState(() {});
          await APIRepository.homeapi(context: context, page: pagecount)
              .then((value) {
            _homeResponseModel = value;
            if (mounted)
              setState(() {
                list.addAll(_homeResponseModel.list);
                _refresh = false;
              });
          }).onError((error, stackTrace) {
            HelperWidget.toast(error.toString());
          });
        }
      }
    });
  }
}

identifyLightPostType({type, isProf}) {
  switch (type) {
    case TYPE_IMAGE:
      return isProf ? Assets.imageDark : Assets.imageLight;
    case TYPE_VIDEO:
      return isProf ? Assets.videoDark : Assets.videoLight;
    default:
      return isProf ? Assets.textDark : Assets.textLight;
  }
}
