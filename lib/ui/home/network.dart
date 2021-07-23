// Project imports:
import 'package:alanis/export.dart';

class Network extends StatefulWidget {
  @override
  _NetworkState createState() => _NetworkState();
}

class _NetworkState extends State<Network> {
  bool shimmer = false;
  var current;
  SearchModel _seachModel = SearchModel();
  TextEditingController _searchController = TextEditingController();
  String prof;
  ScrollController _scrollController = ScrollController();
  int pagecount = 0;
  List<Detail> list = [];
  int maxCount;
  bool start = true;
  int itemHeight = 70;
  Future _searchapi;
  Future _searchByIDapi;
  bool loadPginateData = false;

  // Pagination search api
  paginateData() {
    var response = AuthRequestModel.searchData(search: _searchController.text);
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        pagecount++;

        if (pagecount < _seachModel.mMeta.pageCount) {
          if (mounted)
            setState(() {
              loadPginateData = true;
            });

          if (_searchController.text.length > 0 || current == 0) {
            await APIRepository.searchAPI(
                    context: context, dataBody: response, page: pagecount)
                .then((value) {
              if (mounted)
                setState(() {
                  _seachModel = value;
                  list.addAll(_seachModel.list);
                  loadPginateData = false;
                });
            }).onError((error, stackTrace) {
              HelperWidget.toast(error.toString());
            });
          } else if (current > 0) {
            var response =
                AuthRequestModel.searchByFieldDataRequest(field: current);
            await APIRepository.searchByFieldAPI(
                    context: context, dataBody: response, page: pagecount)
                .then((value) {
              _seachModel = value;
              if (pagecount == 0) {
                list = _seachModel.list;
              } else {
                if (mounted)
                  setState(() {
                    list.addAll(_seachModel.list);
                  });
              }
              loadPginateData = false;
              maxCount = list.length;
            }).onError((error, stackTrace) {
              loadPginateData = false;
              HelperWidget.toast(error);
            });
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    current = 0;
    pagecount = 0;
    maxCount = 10;
    _searchapi = search();
    _searchByIDapi = searchByField();
    paginateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: RefreshIndicator(
        color: primaryColor,
        onRefresh: () {
          return Future.delayed(Duration(milliseconds: 500), () {
            setState(() {
              pagecount = 0;
              current == 0 ? search() : searchByField();
            });
          });
        },
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              textField(),
              SizedBox(height: 10),
              professionalHeading(),
              SizedBox(height: 10),
              Expanded(child: listView()),
            ],
          ),
        ),
      ),
    );
  }

  // Search EditView

  Widget textField() {
    return Container(
      child: Card(
        shadowColor: Colors.grey.withOpacity(0.7),
        elevation: 3,
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            contentPadding: EdgeInsets.all(14),
            hintText: Strings.search,
            hintStyle:
                HelperUtility.textStyle(color: Colors.grey, fontsize: 16.0),
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (val) {
            _searchapi = search();
            if (mounted)
              setState(() {
                loadPginateData = false;
                pagecount = 0;
                list = [];
              });
          },
          onChanged: (val) {
            loadPginateData = false;
            _searchapi = search();
            if (mounted)
              setState(() {
                loadPginateData = false;
                pagecount = 0;
                list = [];
              });
          },
        ),
      ),
    );
  }

  // Sorting Chips

  Widget professionalHeading() {
    return Container(
        child: SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(tabName.length, (index) {
          return GestureDetector(
            onTap: () {
              if (mounted)
                setState(() {
                  list = [];
                  _searchController.text = "";
                  shimmer = false;
                  loadPginateData = false;
                  pagecount = 0;
                  if (index == 0) {
                    current = 0;
                    _searchapi = search();
                  } else if (index == 1) {
                    current = 14;
                    _searchByIDapi = searchByField();
                  } else {
                    current = index - 1;
                    _searchByIDapi = searchByField();
                  }
                });
            },
            child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(5.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                decoration: BoxDecoration(
                  color: tabscolors[index],
                  borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                ),
                child: Text(tabName[index],
                    style: HelperUtility.textStyle(
                        color: Colors.white, fontsize: Dimens.margin_15))),
          );
        }),
      ),
    ));
  }

  // Unfollow alert box

  showAlertDialog(BuildContext context, int index) {
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
          Navigator.pop(context);
          list[index].checkFollowStatus = 2;
          if (mounted) setState(() {});
          followRequest(modelId: list[index]?.id, typeId: 2);
        });

    AlertDialog alert = AlertDialog(
      title: Text(Strings.appNameC),
      content: Text(Strings.wanttoUnfollow + list[index].fullName),
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

  Widget listView() {
    return FutureBuilder(
      future: _searchController.text.length > 0 ||
              current == 0 ||
              _searchController == null
          ? _searchapi
          : _searchByIDapi,
      builder: (context, result) {
        switch (result.connectionState) {
          case ConnectionState.waiting:
            return NetworkShimmer();
            break;
          case ConnectionState.active:
            return Container();
            break;
          case ConnectionState.done:
            {
              if (result != null) {
                return list != null && list?.length != 0
                    ? SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        controller: _scrollController,
                        child: Column(
                          children: [
                            ListView.separated(
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                      height: 10.0,
                                      child: Divider(color: Colors.grey));
                                },
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: list?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          HelperUtility.pushNamed(
                                              context: context,
                                              route: Routes.professionalDetail,
                                              arguments: {
                                                'arg': list[index].id,
                                                'home': 'network'
                                              });
                                        },
                                        child: Container(
                                          height: 70,
                                          width: 70,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(70.0),
                                            child: HelperUtility.cachedImage(
                                                list[index].profileFile,
                                                hash: (blurhashes.toList()
                                                      ..shuffle())
                                                    .first,
                                                height: 70,
                                                width: 70),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Expanded(
                                        child: ListTile(
                                          onTap: () {
                                            HelperUtility.pushNamed(
                                                context: context,
                                                route:
                                                    Routes.professionalDetail,
                                                arguments: {
                                                  'arg': list[index].id,
                                                  'home': 'network'
                                                });
                                          },
                                          visualDensity: VisualDensity
                                              .adaptivePlatformDensity,
                                          contentPadding:
                                              EdgeInsets.only(right: 28),
                                          title: Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  list[index]?.fullName ?? "",
                                                  style: HelperUtility
                                                      .textStyleBold(
                                                          color: Colors.black,
                                                          fontsize: 15.0),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              if (int.parse(
                                                      list[index]?.countPost) >
                                                  14)
                                                list[index].roleId ==
                                                        ROLE_PROFESSIONAL
                                                    ? Image.asset(
                                                        getProfessionalBadge(list[
                                                                    index]
                                                                ?.countPost) ??
                                                            "",
                                                        height: 15,
                                                        width: 13,
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Image.asset(
                                                        getRisingBadge(list[
                                                                    index]
                                                                ?.countPost) ??
                                                            "",
                                                        height: 15,
                                                        width: 15,
                                                        fit: BoxFit.cover,
                                                      )
                                            ],
                                          ),
                                          subtitle: list[index]?.roleId ==
                                                  ROLE_PROFESSIONAL
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    list[index]?.roleId ==
                                                            ROLE_PROFESSIONAL
                                                        ? Text(
                                                            "${list[index]?.risingDetail?.title} ${list[index]?.risingDetail?.companyName}" ??
                                                                "",
                                                            style: HelperUtility
                                                                .textStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontsize:
                                                                        13.0),
                                                          )
                                                        : Container(),
                                                    list[index]?.roleId ==
                                                            ROLE_PROFESSIONAL
                                                        ? Text(
                                                            getRole(list[index]
                                                                    ?.risingDetail
                                                                    ?.field ??
                                                                1.toString()),
                                                            style: HelperUtility
                                                                .textStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontsize:
                                                                        13.0),
                                                          )
                                                        : Container(),
                                                  ],
                                                )
                                              : Text(
                                                  Strings.risingstar,
                                                  style:
                                                      HelperUtility.textStyle(
                                                          color: Colors.black,
                                                          fontsize: 13.0),
                                                ),
                                          isThreeLine: true,
                                          dense: true,
                                          trailing: GestureDetector(
                                            onTap: () {
                                              int choice;
                                              if (list[index]
                                                      .checkFollowStatus ==
                                                  3) {
                                                choice = TYPE_UNFOLLOW;
                                                list[index].checkFollowStatus =
                                                    choice;
                                              } else if (list[index]
                                                      .checkFollowStatus ==
                                                  2) {
                                                choice = TYPE_REQUESTED;
                                                list[index].checkFollowStatus =
                                                    choice;
                                              } else if (list[index]
                                                      .checkFollowStatus ==
                                                  1) {
                                                choice = TYPE_UNFOLLOW;
                                              } else {
                                                choice = TYPE_REQUESTED;
                                                list[index].checkFollowStatus =
                                                    choice;
                                              }

                                              if (list[index]
                                                      .checkFollowStatus ==
                                                  1)
                                                showAlertDialog(context, index);
                                              else
                                                followRequest(
                                                    modelId: list[index]?.id,
                                                    typeId: choice);

                                              setState(() {});
                                            },
                                            child: Container(
                                              color: primaryColor,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 6),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 3.0),
                                              child: Text(
                                                list[index]?.checkFollowStatus ==
                                                        0
                                                    ? Strings.follow
                                                    : list[index]
                                                                ?.checkFollowStatus ==
                                                            1
                                                        ? Strings.following
                                                        : list[index]
                                                                    ?.checkFollowStatus ==
                                                                3
                                                            ? Strings.requested
                                                            : Strings.follow,
                                                style: HelperUtility.textStyle(
                                                    color: Colors.white,
                                                    fontsize: 12.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider()
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
                        margin: EdgeInsets.only(
                            top: Dimens.height_40, bottom: Dimens.height_40),
                        child: Text(Strings.noresultFound),
                      ));
              } else {
                return Center(
                    child: Container(
                  margin: EdgeInsets.only(
                      top: Dimens.height_40, bottom: Dimens.height_40),
                  child: Text(Strings.noresultFound),
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

// All user list api && search by name

  search() async {
    var response = AuthRequestModel.searchData(search: _searchController.text);
    await APIRepository.searchAPI(
            context: context, dataBody: response, page: pagecount)
        .then((value) {
      _seachModel = value;
      if (pagecount == 0) {
        list = _seachModel.list;
      } else {
        list.addAll(_seachModel.list);
      }
      maxCount = list.length;
    }).onError((error, stackTrace) {
      HelperWidget.toast(error);
    });
  }

  // Sorting professional list api

  searchByField() async {
    var response = AuthRequestModel.searchByFieldDataRequest(field: current);
    await APIRepository.searchByFieldAPI(
            context: context, dataBody: response, page: pagecount)
        .then((value) {
      _seachModel = value;
      if (pagecount == 0) {
        list = _seachModel.list;
      } else {
        list.addAll(_seachModel.list);
      }
      maxCount = list.length;
    }).onError((error, stackTrace) {
      HelperWidget.toast(error);
    });
  }

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

// appbar

  _appBar() => HelperWidget.appBar(
      title: Strings.network,
      context: context,
      leading: HelperWidget.getInkwell(
          onTap: () {
            HelperUtility.push(context: context, route: AddPost());
          },
          widget: Padding(
              padding: EdgeInsets.all(5.0),
              child: Image.asset(Assets.add, height: 10))));
}
