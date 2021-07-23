// Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:alanis/export.dart';

class ProfileDoc extends StatefulWidget {
  final int tabIndex;

  const ProfileDoc({Key key, this.tabIndex = 0}) : super(key: key);

  @override
  _ProfileDocState createState() => _ProfileDocState();
}

class _ProfileDocState extends State<ProfileDoc> with TickerProviderStateMixin {
  double top;
  ReusableVideoListController videoListController =
      ReusableVideoListController();
  ScrollController _scrollController = ScrollController();
  ScrollController _pageController = ScrollController();
  LoginDataModel data = LoginDataModel();
  MyPostModel myPostModel = MyPostModel();
  List<PostList> myPostList = [];
  List<Detail> myFollowingList = [];
  List<Detail> myFollowerList = [];
  String prof;
  MyFollower myfollwing = new MyFollower();
  MyFollower _myFollower = new MyFollower();
  CheckUserModel user = CheckUserModel();
  DateFormat dateTimeFormator = DateFormat('dd-MM-yyyy hh:mm a');
  bool isLoading;
  int pagecount;
  CustomLoader _customLoader = CustomLoader();
  Future _future;
  String likeIndex;
  bool shimmer;
  var multiPartFile;
  File selectedFile;
  int followercount = 0;
  int followingcount = 0;
  String postCount = "0";
  int selectedIndex = 0;
  Future _myFollowingList;
  Future _myFollowerList;
  TabController tabController;
  bool _primary = false;
  bool loadPginateData = false;

  shrinkTab() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) if (mounted)
        setState(() {
          _primary = true;
        });
    });

    _pageController.addListener(() {
      if (_pageController.position.pixels ==
          _scrollController.position.minScrollExtent) if (mounted)
        setState(() {
          _primary = false;
        });
    });
  }

  @override
  void initState() {
    super.initState();
    top = 0.0;
    checkUser();
    shimmer = false;
    getData();
    pagecount = 0;
    tabController = TabController(initialIndex: 0, length: 4, vsync: this);
    _future = myPost();
    _myFollowingList = myFollowing();
    _myFollowerList = myFollower();
    paginate();
    shrinkTab();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperWidget.appBar(
          title: Strings.textProfile,
          context: context,
          leading: HelperWidget.getInkwell(
              onTap: () {
                HelperUtility.pushNamed(
                    context: context, route: Routes.addpost);
              },
              widget: Padding(
                padding: EdgeInsets.all(5.0),
                child: Image.asset(Assets.add, height: 20),
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Icon(Icons.edit, color: Colors.white),
                onTap: () {
                  HelperUtility.push(context: context, route: ProfileSetUp());
                },
              ),
            )
          ]),
      body: data == null
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
                backgroundColor: Colors.white,
              ),
            )
          : _tabBar(),
    );
  }

  DefaultTabController _tabBar() {
    return DefaultTabController(
      length: 4,
      initialIndex: widget.tabIndex,
      child: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 0.0,
                backgroundColor: Colors.white,
                expandedHeight: 340.0,
                floating: true,
                pinned: true,
                stretch: true,
                stretchTriggerOffset: 340.0,
                leading: null,
                flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                  top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    stretchModes: [
                      StretchMode.blurBackground,
                    ],
                    background: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: top > 320.0 ? 1.0 : 0.3,
                        child: _profilePicBgPic(context)),
                  );
                }),
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(57.0),
                    child: Container(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            color: Colors.white,
                            child: TabBar(
                              controller: tabController,
                              indicator: BoxDecoration(
                                  border: Border(left: BorderSide.none)),
                              indicatorPadding: EdgeInsets.all(0),
                              isScrollable: false,
                              labelColor: primaryColorShades,
                              labelPadding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 10),
                              unselectedLabelColor: Colors.grey,
                              tabs: [
                                Container(
                                  padding: EdgeInsets.only(
                                      right: 10, bottom: 8, top: 8),
                                  decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            color: Colors.grey, width: 1)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Following\n$followingcount",
                                      style:
                                          HelperUtility.textStyle(fontsize: 13),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      right: 10, bottom: 8, top: 8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: Colors.grey, width: 1))),
                                  child: Center(
                                    child: Text(
                                      "Followers\n$followercount",
                                      style:
                                          HelperUtility.textStyle(fontsize: 13),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      right: 10, bottom: 8, top: 8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: Colors.grey, width: 1))),
                                  child: Center(
                                    child: Text(
                                      "About me",
                                      style:
                                          HelperUtility.textStyle(fontsize: 13),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      right: 10, bottom: 8, top: 8),
                                  child: Center(
                                    child: Text(
                                      "Posts\n$postCount",
                                      style:
                                          HelperUtility.textStyle(fontsize: 13),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                              onTap: (index) {
                                if (index == 0) {
                                  pagecount = 0;

                                  myFollowing();
                                } else if (index == 1) {
                                  pagecount = 0;

                                  myFollower();
                                } else if (index == 3) {
                                  pagecount = 0;

                                  myPost();
                                }
                              },
                            ),
                          );
                        },
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.grey, width: 0.5),
                              bottom:
                                  BorderSide(color: Colors.grey, width: 0.5))),
                    ))),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            _listViewFollowing(),
            _listViewFollower(),
            AboutMe(),
            tabbarList()
          ],
          controller: tabController,
        ),
      ),
    );
  }

  _listViewFollower() {
    return FutureBuilder(
      future: _myFollowerList,
      builder: (context, result) {
        switch (result.connectionState) {
          case ConnectionState.waiting:
            return FollowerShimmer();
            break;
          case ConnectionState.active:
            return Container();
            break;
          case ConnectionState.done:
            {
              if (result != null) {
                return _myFollower?.list != null &&
                        _myFollower?.list?.length != 0
                    ? Container(
                        padding: EdgeInsets.only(left: Dimens.margin_15),
                        child: SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          controller: _primary ? _pageController : null,
                          child: Column(
                            children: [
                              ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var item = myFollowerList[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30.0, top: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          HelperUtility.pushNamed(
                                              context: context,
                                              route: Routes.professionalDetail,
                                              arguments: {
                                                'arg': item.id,
                                                'home': 'profile'
                                              });
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 70,
                                              width: 70,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(70.0),
                                                child:
                                                    HelperUtility.cachedImage(
                                                        item.profileFile,
                                                        hash:
                                                            (blurhashes.toList()
                                                                  ..shuffle())
                                                                .first,
                                                        height: 70,
                                                        width: 70),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      item?.fullName ?? "",
                                                      style: HelperUtility
                                                          .textStyleBold(
                                                              fontsize: 16),
                                                    ),
                                                    SizedBox(width: 8),
                                                    if (int.parse(
                                                            item?.countPost) >
                                                        14)
                                                      item.roleId ==
                                                              ROLE_PROFESSIONAL
                                                          ? Image.asset(
                                                              getProfessionalBadge(
                                                                      item?.countPost) ??
                                                                  "",
                                                              height: 16,
                                                              width: 14,
                                                              fit: BoxFit.fill,
                                                            )
                                                          : Image.asset(
                                                              getRisingBadge(item
                                                                      ?.countPost) ??
                                                                  "",
                                                              height: 16,
                                                              width: 16,
                                                              fit: BoxFit.cover,
                                                            )
                                                  ],
                                                ),
                                                item?.roleId ==
                                                        ROLE_PROFESSIONAL
                                                    ? Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          item?.roleId ==
                                                                  ROLE_PROFESSIONAL
                                                              ? Text(
                                                                  "${item?.risingDetail?.title} ${item?.risingDetail?.companyName}" ??
                                                                      "",
                                                                  style: HelperUtility.textStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontsize:
                                                                          13.0),
                                                                )
                                                              : Container(),
                                                          item?.roleId ==
                                                                  ROLE_PROFESSIONAL
                                                              ? Text(
                                                                  getRole(item
                                                                          ?.risingDetail
                                                                          ?.field ??
                                                                      1.toString()),
                                                                  style: HelperUtility.textStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontsize:
                                                                          13.0),
                                                                )
                                                              : Container(),
                                                        ],
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
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      Divider(),
                                  itemCount: myFollowerList?.length ?? 0),
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
                        ))
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

  _listViewFollowing() {
    return FutureBuilder(
      future: _myFollowingList,
      builder: (context, result) {
        switch (result.connectionState) {
          case ConnectionState.waiting:
            return FollowerShimmer();
            break;
          case ConnectionState.active:
            return Container();
            break;
          case ConnectionState.done:
            {
              if (result != null) {
                return myfollwing?.list != null && myfollwing?.list?.length != 0
                    ? Container(
                        padding: EdgeInsets.only(left: Dimens.margin_15),
                        child: SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          controller: _primary ? _pageController : null,
                          child: Column(
                            children: [
                              ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var item = myFollowingList[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30.0, top: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          HelperUtility.pushNamed(
                                              context: context,
                                              route: Routes.professionalDetail,
                                              arguments: {
                                                'arg': item.id,
                                                'home': 'profile'
                                              });
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 70,
                                              width: 70,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(70.0),
                                                child:
                                                    HelperUtility.cachedImage(
                                                        item.profileFile,
                                                        hash:
                                                            (blurhashes.toList()
                                                                  ..shuffle())
                                                                .first,
                                                        height: 70,
                                                        width: 70),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      item?.fullName ?? "",
                                                      style: HelperUtility
                                                          .textStyleBold(
                                                              fontsize: 16),
                                                    ),
                                                    SizedBox(width: 8),
                                                    if (int.parse(
                                                            item.countPost) >
                                                        14)
                                                      item.roleId ==
                                                              ROLE_PROFESSIONAL
                                                          ? Image.asset(
                                                              getProfessionalBadge(
                                                                      item?.countPost) ??
                                                                  "",
                                                              height: 16,
                                                              width: 14,
                                                              fit: BoxFit.fill,
                                                            )
                                                          : Image.asset(
                                                              getRisingBadge(item
                                                                      ?.countPost) ??
                                                                  "",
                                                              height: 16,
                                                              width: 16,
                                                              fit: BoxFit.cover,
                                                            )
                                                  ],
                                                ),
                                                item?.roleId ==
                                                        ROLE_PROFESSIONAL
                                                    ? Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          item?.roleId ==
                                                                  ROLE_PROFESSIONAL
                                                              ? Text(
                                                                  "${item?.risingDetail?.title}  ${item?.risingDetail?.companyName}" ??
                                                                      "",
                                                                  style: HelperUtility.textStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontsize:
                                                                          13.0),
                                                                )
                                                              : Container(),
                                                          item?.roleId ==
                                                                  ROLE_PROFESSIONAL
                                                              ? Text(
                                                                  getRole(item
                                                                          ?.risingDetail
                                                                          ?.field ??
                                                                      1.toString()),
                                                                  style: HelperUtility.textStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontsize:
                                                                          13.0),
                                                                )
                                                              : Container(),
                                                        ],
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
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      Divider(),
                                  itemCount: myFollowingList?.length ?? 0),
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
                        ))
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

  Widget _profilePicBgPic(BuildContext context) {
    return Container(
      height: 340,
      margin: EdgeInsets.only(bottom: 50.0),
      child: Stack(children: [
        user?.detail?.coverProfile != null
            ? Container(
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      BlurHash(hash: (blurhashes.toList()..shuffle()).first),
                  errorWidget: (context, url, error) => Image.asset(
                    Assets.slider3,
                    fit: BoxFit.fill,
                  ),
                  imageUrl: user?.detail?.coverProfile ?? "",
                  fit: BoxFit.cover,
                  height: 170,
                  width: HelperUtility.fullWidthScreen(context: context),
                ),
                height: 200,
                width: HelperUtility.fullWidthScreen(context: context),
                color: Colors.white,
              )
            : Shimmer.fromColors(
                baseColor: shimmerbaseColor,
                highlightColor: shimmerhighlightColor,
                child: Container(
                  height: 200,
                  width: HelperUtility.fullWidthScreen(context: context),
                  color: shimmerBodyColor.withOpacity(0.25),
                ),
              ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              showDailog();
            },
            child: Image.asset(
              Assets.camera,
              width: 35,
              height: 35,
            ),
          ),
        ),
        Positioned(
            left: 25,
            top: 160,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: user?.detail?.profileFile == null
                      ? Shimmer.fromColors(
                          baseColor: shimmerbaseColor,
                          highlightColor: shimmerhighlightColor,
                          child: Container(
                            height: 90,
                            width: 90,
                            color: shimmerBodyColor.withOpacity(0.25),
                          ))
                      : HelperUtility.cachedImage(user?.detail?.profileFile,
                          hash: (blurhashes.toList()..shuffle()).first,
                          height: 90,
                          width: 90),
                ),
                SizedBox(width: 16),
                Align(
                    alignment: Alignment.topCenter,
                    heightFactor: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              data?.fullName ?? "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                              style: HelperUtility.textStyleBold(
                                  fontsize: 20, height: 1.3),
                            ),
                            SizedBox(width: 8),
                            user != null
                                ? data.roleId == ROLE_PROFESSIONAL
                                    ? user?.detail?.countPost != null
                                        ? Image.asset(
                                            getProfessionalBadge(
                                                user.detail.countPost),
                                            height: 20,
                                            width: 18,
                                            fit: BoxFit.fill,
                                          )
                                        : SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: primaryColor,
                                              backgroundColor: Colors.white,
                                            ))
                                    : user?.detail?.countPost != null
                                        ? Image.asset(
                                            getRisingBadge(
                                                user.detail.countPost),
                                            height: 20,
                                            width: 20,
                                            fit: BoxFit.cover,
                                          )
                                        : SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: primaryColor,
                                              backgroundColor: Colors.white,
                                            ))
                                : Container(),
                          ],
                        ),
                        data.roleId == ROLE_PROFESSIONAL
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        data?.risingDetail?.title,
                                        style: HelperUtility.textStyleBold(
                                            fontWeight: FontWeight.w600,
                                            height: 1.3,
                                            color: grey,
                                            fontsize: 12.0),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        data?.risingDetail?.companyName,
                                        style: HelperUtility.textStyleBold(
                                            fontWeight: FontWeight.w600,
                                            height: 1.3,
                                            color: grey,
                                            fontsize: 12.0),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    getRole(data?.risingDetail?.field ??
                                        1.toString()),
                                    style: HelperUtility.textStyle(
                                        height: 1.3,
                                        color: grey,
                                        fontsize: 12.0),
                                  ),
                                ],
                              )
                            : Text(
                                Strings.risingstar,
                                style: HelperUtility.textStyle(
                                    fontsize: 12, height: 1.3, color: grey),
                              ),
                        data.roleId == ROLE_PROFESSIONAL
                            ? Text(
                                data.country ?? "",
                                style: HelperUtility.textStyle(
                                    fontsize: 12, height: 1.3, color: grey),
                              )
                            : Container(),
                      ],
                    ))
              ],
            ))
      ]),
    );
  }

  tabbarList() {
    return FutureBuilder(
      future: _future,
      builder: (context, result) {
        switch (result.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: PostShimmer(),
            );
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
                        controller: _primary ? _pageController : null,
                        child: Column(
                          children: [
                            ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                separatorBuilder: (context, index) => Divider(
                                    thickness: 0.0,
                                    height: 0,
                                    color: Colors.grey.shade200),
                                itemCount: myPostList?.length ?? 0,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var list = myPostList;
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
                                        title: Row(
                                          children: [
                                            Text(
                                              "${list[index].createdBy.fullName}",
                                              style:
                                                  HelperUtility.textStyleBold(
                                                      fontsize: 16,
                                                      color: Colors.black),
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
                                                                "${list[index]?.file?.key ?? ""}",
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
                                                      'home': 'profile',
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
                                                                      'profile',
                                                                  'userID': user
                                                                      .detail
                                                                      .id,
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

  paginate() {
    _pageController.addListener(() async {
      if (_pageController.position.pixels ==
          _pageController.position.maxScrollExtent) {
        pagecount++;

        if (tabController.index == 3) if (pagecount <
            myPostModel.mMeta.pageCount) {
          if (mounted)
            setState(() {
              loadPginateData = true;
            });
          await APIRepository.myPostApi(context: context, page: pagecount)
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
        } else if (tabController.index == 1) if (pagecount <
            myfollwing.mMeta.pageCount) {
          if (mounted)
            setState(() {
              loadPginateData = true;
            });
          await APIRepository.myFollowing(context, page: pagecount)
              .then((value) {
            if (value != null) if (mounted) {
              myfollwing = value;
              if (pagecount == 0) {
                myFollowingList = myfollwing.list;
              } else {
                myFollowingList.addAll(myfollwing.list);
              }
              if (mounted)
                setState(() {
                  loadPginateData = false;
                });
            }
          }).onError((error, stackTrace) {
            HelperWidget.toast(error.toString());
          });
        } else if (tabController.index == 0) if (pagecount <
            _myFollower.mMeta.pageCount) {
          if (mounted)
            setState(() {
              loadPginateData = true;
            });
          await APIRepository.myFollower(context, page: pagecount)
              .then((value) {
            if (value != null) if (mounted) {
              _myFollower = value;
              if (pagecount == 0) {
                myFollowerList = _myFollower.list;
              } else {
                myFollowerList.addAll(_myFollower.list);
              }
              if (mounted)
                setState(() {
                  loadPginateData = false;
                });
            }
          }).onError((error, stackTrace) {
            HelperWidget.toast(error.toString());
          });
        }
      }
    });
  }

  Future<void> getData() async {
    await PrefManger.getRegisterData().then((value) {
      if (mounted)
        setState(() {
          data = value;
          if (data?.risingDetail?.field == "1")
            prof = "Legal";
          else if (data?.risingDetail?.field == "2")
            prof = "Technology";
          else if (data?.risingDetail?.field == "3")
            prof = "IT";
          else if (data?.risingDetail?.field == "4")
            prof = "Medical";
          else if (data?.risingDetail?.field == "5")
            prof = "Entrepreneur";
          else if (data?.risingDetail?.field == "6")
            prof = "Business";
          else if (data?.risingDetail?.field == "7")
            prof = "Education";
          else if (data?.risingDetail?.field == "8")
            prof = "Financial services";
          else if (data?.risingDetail?.field == "9")
            prof = "Management/ Leadership";
          else if (data?.risingDetail?.field == "10")
            prof = "Personal development/ coaching";
          else if (data?.risingDetail?.field == "11")
            prof = "Health/ Nutrition";
          else if (data?.risingDetail?.field == "12")
            prof = "Other";
          else
            prof = "";
        });
    });
  }

  updateCoverPhoto() async {
    _customLoader.show(context);
    if (selectedFile != null) {
      multiPartFile = await MultipartFile.fromFile(selectedFile.path,
          filename: selectedFile.path);
    }

    var response = AuthRequestModel.updateCover(
      file: multiPartFile ?? null,
    );
    await APIRepository.coverPhoto(response, context).then((value) {
      if (value != null) {
        _customLoader.hide();
        if (mounted) checkUser();
      }
    }).onError((error, stackTrace) {
      _customLoader.hide();
      HelperWidget.toast(error);
    });
  }

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

  _cropImage(filePath) async {
    File croppedImage = await ImageCropper.cropImage(
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
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
    if (mounted) if (mounted)
      setState(() {
        selectedFile = croppedImage;
        updateCoverPhoto();
      });
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

  void checkUser() async {
    await APIRepository.checkuser(context).then((value) {
      if (value != null) {
        if (mounted)
          setState(() {
            user = value;
            followercount = user?.detail?.followerCount ?? 0;
            followingcount = user?.detail?.followingCount ?? 0;
            postCount = user?.detail?.countPost.toString() ?? "0";
          });
      }
    }).onError((error, stackTrace) {
      HelperWidget.toast(error);
    });
  }

  myPost() async {
    await APIRepository.myPostApi(context: context, page: 0).then((value) {
      if (value != null) {
        if (mounted) {
          myPostModel = value;
          if (pagecount == 0) {
            myPostList = myPostModel.list;
          } else {
            myPostList.addAll(myPostModel.list);
          }
        }
      }
    }).onError((error, stackTrace) {
      HelperWidget.toast(error);
    });
  }

  myFollower() async {
    await APIRepository.myFollower(context).then((value) {
      if (value != null) {
        if (mounted) {
          _myFollower = value;
          if (pagecount == 0) {
            myFollowerList = _myFollower.list;
          } else {
            myFollowerList.addAll(_myFollower.list);
          }
        }
      }
    }).onError((error, stackTrace) {
      HelperWidget.toast(error);
    });
  }

  myFollowing() async {
    await APIRepository.myFollowing(context).then((value) {
      if (value != null) {
        if (mounted) {
          myfollwing = value;
          if (pagecount == 0) {
            myFollowingList = myfollwing.list;
          } else {
            myFollowingList.addAll(myfollwing.list);
          }
        }
      }
    }).onError((error, stackTrace) {
      HelperWidget.toast(error);
    });
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
                                                  child:
                                                      HelperUtility.cachedImage(
                                                          imageUrl +
                                                              item.profileFile,
                                                          hash: (blurhashes
                                                                  .toList()
                                                                    ..shuffle())
                                                              .first,
                                                          height: 40,
                                                          width: 40),
                                                ),
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
      if (value != null) {}
    }).onError((error, stackTrace) {
      _customLoader.hide();
      if (error.toString() != Strings.unableToProcessData)
      HelperWidget.toast(error);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
