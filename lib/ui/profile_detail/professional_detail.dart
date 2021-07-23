// Project imports:
import 'package:alanis/export.dart';

class ProfessionalDetail extends StatefulWidget {
  final Map<dynamic, dynamic> arguments;

  ProfessionalDetail(this.arguments);

  @override
  _ProfessionalDetailState createState() => _ProfessionalDetailState();
}

class _ProfessionalDetailState extends State<ProfessionalDetail> {
  var argID;
  int indx;
  String likeIndex;
  CustomLoader _customLoader = CustomLoader();
  UserDetailModel userDetailModel;
  Detail data;
  bool hasData = false;
  MyPostModel myPostModel = MyPostModel();
  List<PostList> myPostList = [];
  bool myPostData = false;
  Future _future;
  int likeCount;
  bool _aboutMe;
  ReusableVideoListController videoListController =
      ReusableVideoListController();
  ScrollController _scrollController = ScrollController();
  bool loadPginateData = false;
  int pagecount = 0;

  // follow - unfollow api
  void followRequest({modelId, typeId}) async {
    var response = AuthRequestModel.followRequest(
        modelId: int.parse(modelId.toString()), typeId: typeId);
    await APIRepository.followRequest(context: context, dataBody: response)
        .then((value) {})
        .onError((error, stackTrace) {
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
        hasData = true;
        if (mounted) setState(() {});
      }
    }).onError((error, stackTrace) {
      HelperWidget.toast(error.toString());
      return null;
    });
  }

  userPost() async {
    var response = AuthRequestModel.userDetailParam(
      id: argID,
    );
    await APIRepository.userPostApi(
            context: context, page: 0, dataBody: response)
        .then((value) {
      if (value != null) {
        myPostList.clear();
        myPostModel = value;
        myPostList.addAll(myPostModel.list);
        myPostData = true;
      }
    }).onError((error, stackTrace) {
      HelperWidget.toast(error);
    });
  }

  paginate() {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        pagecount++;
        if (pagecount < myPostModel.mMeta.pageCount) {
          if (mounted)
            setState(() {
              loadPginateData = true;
            });
          var response = AuthRequestModel.userDetailParam(
            id: argID,
          );
          await APIRepository.userPostApi(
                  context: context, page: pagecount, dataBody: response)
              .then((value) {
            if (value != null) {
              if (mounted) {
                myPostModel = value;
                if (pagecount == 0) {
                  myPostList = myPostModel.list;
                } else {
                  myPostList.addAll(myPostModel.list);
                }
                if (mounted)
                  setState(() {
                    loadPginateData = false;
                  });
              }
            }
            if (mounted) setState(() {});
          }).onError((error, stackTrace) {
            HelperWidget.toast(error.toString());
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    argID = widget.arguments['arg'];
    paginate();
    _aboutMe = false;
    userDetail(userId: argID, context: context);
    _future = userPost();
  }

  Widget _appBar() {
    return AppBar(
        title: Text(
          data?.fullName ?? "",
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
            else if (widget.arguments['home'] == 'network')
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavigationScreen(3),
                  ));
            else
              Navigator.pop(context);
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          appBar: _appBar(),
          body: Column(
            children: [
              hasData ? coverProfilePhoto() : ProfProfileShimmer(),
              Expanded(
                child: _aboutMe
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            thickness: 0.5,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Strings.aboutme,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "${data?.shortDescription}" ?? "",
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 0.5,
                          ),
                        ],
                      )
                    : tabbarList(),
              )
            ],
          )),
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
    } else {
      Navigator.pop(context);
      return Future.value(true);
    }
  }

  Widget coverProfilePhoto() {
    return Stack(
      children: [
        Container(
          height: data?.roleId == ROLE_PROFESSIONAL ? 290 : 275,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 130),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        data?.fullName ?? "",
                        style: HelperUtility.textStyle(fontsize: 18),
                      ),
                      SizedBox(width: 8),
                      if (int.parse(data?.countPost ?? "0") > 14)
                        Image.asset(
                          data.roleId == ROLE_PROFESSIONAL
                              ? getProfessionalBadge(data?.countPost) ?? "0"
                              : getRisingBadge(data?.countPost) ?? "0",
                          height: 18,
                          width: data.roleId == ROLE_PROFESSIONAL ? 14 : 18,
                          fit: data?.roleId == ROLE_PROFESSIONAL
                              ? BoxFit.fill
                              : BoxFit.cover,
                        )
                    ],
                  ),
                ),
                data?.roleId == ROLE_PROFESSIONAL
                    ? Padding(
                        padding: EdgeInsets.only(left: 130),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  data?.risingDetail?.title ?? "",
                                  style: HelperUtility.textStyle(
                                      height: 1.2,
                                      color: Colors.black,
                                      fontsize: 12.0),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  data?.risingDetail?.companyName ?? "",
                                  style: HelperUtility.textStyle(
                                      height: 1.2,
                                      color: Colors.black,
                                      fontsize: 12.0),
                                ),
                              ],
                            ),
                            Text(
                              getRole(
                                  data?.risingDetail?.field ?? 1.toString()),
                              style: HelperUtility.textStyle(
                                  height: 1.2,
                                  color: Colors.black,
                                  fontsize: 12.0),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(left: 130),
                        child: Text(
                          Strings.risingstar,
                          style: HelperUtility.textStyle(
                              fontsize: 12, height: 1.2, color: grey),
                        ),
                      ),
                data?.roleId == ROLE_PROFESSIONAL
                    ? Padding(
                        padding: EdgeInsets.only(left: 130),
                        child: Text(
                          data?.country ?? "",
                          style: HelperUtility.textStyle(
                              fontsize: 12, height: 1.2, color: grey),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(left: 130),
                        child: Text(""),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 90,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(primaryColor),
                        ),
                        onPressed: () {
                          int choice;
                          if (data.checkFollowStatus == 3) {
                            {
                              choice = TYPE_UNFOLLOW;
                              data.checkFollowStatus = choice;
                            }
                          } else if (data.checkFollowStatus == 2) {
                            choice = TYPE_REQUESTED;
                            data.checkFollowStatus = choice;
                          } else if (data.checkFollowStatus == 1)
                            choice = TYPE_UNFOLLOW;
                          else {
                            choice = TYPE_REQUESTED;
                            data.checkFollowStatus = choice;
                          }
                          if (mounted) setState(() {});

                          if (data.checkFollowStatus == 1)
                            showUnfollowAlertDialog(context);
                          else
                            followRequest(modelId: data?.id, typeId: choice);
                        },
                        child: Text(
                          data?.checkFollowStatus == 0
                              ? Strings.follow
                              : data?.checkFollowStatus == 1
                                  ? Strings.following
                                  : data?.checkFollowStatus == 3
                                      ? Strings.requested
                                      : Strings.follow,
                          style: HelperUtility.textStyle(
                              fontsize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    if (data?.checkFollowStatus == 1)
                      Container(
                        width: 90,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(darkPink),
                          ),
                          onPressed: () {
                            HelperUtility.pushNamed(
                                context: context,
                                route: Routes.chatscreen,
                                arguments: {"arg": data.id});
                          },
                          child: Text(
                            Strings.message ?? "",
                            style: HelperUtility.textStyle(
                                fontsize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    SizedBox(width: 8),
                    Container(
                      width: 90,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              darkPrimaryColor),
                        ),
                        onPressed: () {
                          if (mounted)
                            setState(() {
                              _aboutMe = !_aboutMe;
                            });
                        },
                        child: Text(
                          _aboutMe ? "Posts" : Strings.aboutme ?? "",
                          style: HelperUtility.textStyle(
                              fontsize: 14, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        data?.coverProfile == null
            ? Shimmer.fromColors(
                baseColor: shimmerbaseColor,
                highlightColor: shimmerhighlightColor,
                child: Container(
                  height: 170,
                  width: HelperUtility.fullWidthScreen(context: context),
                  color: shimmerBodyColor.withOpacity(0.25),
                ),
              )
            : HelperUtility.cachedImage(data?.coverProfile ?? "",
                boxFit: BoxFit.cover,
                height: 170,
                width: HelperUtility.fullWidthScreen(context: context),
                hash: (blurhashes.toList()..shuffle()).first,
                isPost: true),
        Positioned(
          top: 120,
          left: 20,
          child: Container(
            height: 100,
            width: 100,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: primaryColorShades,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: HelperUtility.cachedImage(data?.profileFile,
                  hash: (blurhashes.toList()..shuffle()).first,
                  height: 100,
                  width: 100),
            ),
          ),
        ),
      ],
    );
  }

  showUnfollowAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text(
        Strings.no,
        style: HelperUtility.textStyle(color: Colors.red),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
        child: Text(Strings.yes),
        onPressed: () {
          followRequest(modelId: data.id, typeId: 2);
          data.checkFollowStatus = 2;
          if (mounted) setState(() {});
          Navigator.pop(context);
        });

    AlertDialog alert = AlertDialog(
      title: Text(Strings.appNameC),
      content: Text("Are you sure you want to unfollow " + data.fullName),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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
                return myPostList != null && myPostList?.length != 0
                    ? SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        controller: _scrollController,
                        child: Column(
                          children: [
                            ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) => Divider(
                                    thickness: 0.0,
                                    height: 0,
                                    color: Colors.grey.shade200),
                                itemCount: myPostList.length ?? 0,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        leading: Container(
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
                                                myPostList[index]
                                                    .createdBy
                                                    .profileFile,
                                                hash: (blurhashes.toList()
                                                      ..shuffle())
                                                    .first,
                                                height: 40,
                                                width: 40),
                                          ),
                                        ),
                                        title: Row(
                                          children: [
                                            Text(
                                              "${myPostList[index].createdBy.fullName}",
                                              style:
                                                  HelperUtility.textStyleBold(
                                                      fontsize: 16,
                                                      color: Colors.black),
                                            ),
                                            SizedBox(width: 5),
                                            if (int.parse(myPostList[index]
                                                    ?.createdBy
                                                    ?.countPost) >
                                                14)
                                              myPostList[index]
                                                          .createdBy
                                                          .roleId ==
                                                      ROLE_PROFESSIONAL
                                                  ? Image.asset(
                                                      getProfessionalBadge(
                                                              myPostList[index]
                                                                  ?.createdBy
                                                                  ?.countPost) ??
                                                          "",
                                                      height: 15,
                                                      width: int.parse(myPostList[
                                                                      index]
                                                                  ?.createdBy
                                                                  ?.countPost) >
                                                              14
                                                          ? 13
                                                          : 0,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : Image.asset(
                                                      getRisingBadge(myPostList[
                                                                  index]
                                                              ?.createdBy
                                                              ?.countPost) ??
                                                          "",
                                                      height: 15,
                                                      width: int.parse(myPostList[
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
                                          whatTime(myPostList[index].createdOn),
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
                                            if (myPostList[index].typeId ==
                                                    TYPE_IMAGE ||
                                                myPostList[index].typeId ==
                                                    TYPE_VIDEO)
                                              Container(
                                                height: 200,
                                                width: HelperUtility
                                                    .fullWidthScreen(
                                                        context: context),
                                                child: myPostList[index]
                                                            .typeId ==
                                                        TYPE_IMAGE
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 10),
                                                        child: HelperUtility.cachedImage(
                                                            imageUrl +
                                                                "${myPostList[index]?.file?.key}",
                                                            boxFit:
                                                                BoxFit.contain,
                                                            hash: (blurhashes
                                                                    .toList()
                                                                      ..shuffle())
                                                                .first,
                                                            isPost: true),
                                                      )
                                                    : myPostList[index]
                                                                .typeId ==
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
                                                                        "${myPostList[index]?.file?.key}" ??
                                                                    "",
                                                              ),
                                                              videoListController:
                                                                  videoListController,
                                                              canBuildVideo:
                                                                  true,
                                                            ),
                                                          )
                                                        : Container(),
                                              ),
                                            InkWell(
                                              onTap: () {
                                                HelperUtility.pushNamed(
                                                  context: context,
                                                  route: Routes.postdetails,
                                                  arguments: {
                                                    "modelID":
                                                        myPostList[index].id,
                                                    'home': 'detail',
                                                    'argID': argID
                                                  },
                                                );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 8),
                                                decoration: BoxDecoration(
                                                    color: myPostList[index]
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
                                                      myPostList[index]
                                                          .description,
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
                                                            myPostList[index]
                                                                        .createdBy
                                                                        .roleId ==
                                                                    ROLE_PROFESSIONAL
                                                                ? identifyLightPostType(
                                                                    isProf:
                                                                        true,
                                                                    type: myPostList[
                                                                            index]
                                                                        .typeId)
                                                                : identifyLightPostType(
                                                                    isProf:
                                                                        false,
                                                                    type: myPostList[
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
                                                                "${myPostList[index].id}";
                                                            if (mounted)
                                                              setState(() {
                                                                if (myPostList[
                                                                            index]
                                                                        .checkLike ==
                                                                    false) {
                                                                  myPostList[
                                                                          index]
                                                                      .checkLike = true;
                                                                  myPostList[
                                                                          index]
                                                                      .likes = myPostList[
                                                                              index]
                                                                          .likes -
                                                                      1;
                                                                } else {
                                                                  myPostList[index]
                                                                          .checkLike =
                                                                      false;
                                                                  myPostList[
                                                                          index]
                                                                      .likes = myPostList[
                                                                              index]
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
                                                                myPostList[index]
                                                                            .checkLike ==
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
                                                                  "${myPostList[index].likes}",
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
                                                                      'detail',
                                                                  'userID':
                                                                      argID,
                                                                  'modelID':
                                                                      myPostList[
                                                                              index]
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
                                                                  "${myPostList[index].comments ?? "0"}",
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
    if (myPostList[index].tags.length == 0) {
      return Container();
    } else if (myPostList[index].tags.length == 1) {
      return Row(
        children: [
          Image.asset(
            Assets.tag,
            height: 16,
            width: 16,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 4),
          Text("${myPostList[index].tags[0].fullName}",
              style:
                  HelperUtility.textStyle(fontsize: 12, color: Colors.white)),
        ],
      );
    } else if (myPostList[index].tags.length == 2) {
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
              "${myPostList[index].tags[0].fullName}" +
                  " , " +
                  "${myPostList[index].tags[1].fullName}",
              style:
                  HelperUtility.textStyle(fontsize: 12, color: Colors.white)),
        ],
      );
    } else if (myPostList[index].tags.length > 2) {
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
                "${myPostList[index].tags[0].fullName}" +
                    " , " +
                    "${myPostList[index].tags[1].fullName}"
                        " + " +
                    "${myPostList[index].tags.length - 2}" +
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
                                return myPostList != null &&
                                        myPostList?.length != 0
                                    ? ListView.separated(
                                        itemCount:
                                            myPostList[listIndex].tags.length,
                                        shrinkWrap: true,
                                        separatorBuilder: (context, index) {
                                          return Divider(
                                            thickness: 1,
                                            color: Colors.grey[300],
                                          );
                                        },
                                        itemBuilder: (context, index) {
                                          var item =
                                              myPostList[listIndex].tags[index];
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
                                                    myPostList[listIndex]
                                                            .tags[index]
                                                            ?.fullName ??
                                                        "",
                                                  ),
                                                  myPostList[listIndex]
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
      if (value != null) {
        userPost();
      }
    }).onError((error, stackTrace) {
      _customLoader.hide();
      if (error.toString() != Strings.unableToProcessData)
      HelperWidget.toast(error);
    });
  }
}
