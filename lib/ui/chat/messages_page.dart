// Project imports:
import 'package:alanis/export.dart';

class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  ChatUserModel chatuser = ChatUserModel();
  List<Detail> userList = [];
  Future _future;
  bool loadPginateData = false;
  ScrollController _scrollController = ScrollController();
  int pagecount = 0;

  @override
  void initState() {
    super.initState();
    _future = chatUser();
    paginateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: RefreshIndicator(
        child: messagesList(),
        color: primaryColor,
        onRefresh: () {
          return Future.delayed(Duration(milliseconds: 500), () {
            setState(() {
              pagecount = 0;
              chatUser();
            });
          });
        },
      ),
    );
  }

  Widget messagesList() {
    return FutureBuilder(
      future: _future,
      builder: (context, result) {
        switch (result.connectionState) {
          case ConnectionState.waiting:
            return MessageShimmer();
            break;
          case ConnectionState.active:
            return Container();
            break;
          case ConnectionState.done:
            {
              if (result != null) {
                return userList != null && userList?.length != 0
                    ? SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        controller: _scrollController,
                        child: Column(
                          children: [
                            ListView.builder(
                              itemExtent: 80,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: userList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 0.0, color: Colors.grey[300]),
                                    ),
                                  ),
                                  height: 90,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(60.0),
                                            child: HelperUtility.cachedImage(
                                                userList[index].profileFile,
                                                hash: (blurhashes.toList()
                                                      ..shuffle())
                                                    .first,
                                                height: 60,
                                                width: 60),
                                          ),
                                        ),
                                        Expanded(
                                          child: ListTile(
                                            onTap: () {
                                              HelperUtility.pushNamed(
                                                  context: context,
                                                  route: Routes.chatscreen,
                                                  arguments: {
                                                    "arg": userList[index].id
                                                  });
                                            },
                                            title: Row(
                                              children: [
                                                Text(userList[index].fullName,
                                                    style: TextStyle(
                                                      fontSize: Dimens.font_18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    )),
                                                SizedBox(width: 5),
                                                if (int.parse(userList[index]
                                                        ?.countPost) >
                                                    14)
                                                  userList[index].roleId ==
                                                          ROLE_PROFESSIONAL
                                                      ? Image.asset(
                                                          getProfessionalBadge(
                                                                  chatuser
                                                                      .list[
                                                                          index]
                                                                      ?.countPost) ??
                                                              "",
                                                          height: 18,
                                                          width: 15,
                                                          fit: BoxFit.fill,
                                                        )
                                                      : Image.asset(
                                                          getRisingBadge(chatuser
                                                                  .list[index]
                                                                  ?.countPost) ??
                                                              "",
                                                          height: 18,
                                                          width: 18,
                                                          fit: BoxFit.cover,
                                                        ),
                                              ],
                                            ),
                                            subtitle: Container(
                                              child: Text(
                                                  userList[index].roleId ==
                                                          ROLE_PROFESSIONAL
                                                      ? "${userList[index].risingDetail.title}  ${userList[index].risingDetail.companyName}"
                                                      : Strings.risingstar,
                                                  style: TextStyle(
                                                    fontSize: Dimens.font_14,
                                                    color: Colors.black26,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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

  appBar() {
    return HelperWidget.appBar(
        title: Strings.messages,
        leading: HelperWidget.getInkwell(
            onTap: () {
              HelperUtility.push(context: context, route: AddPost());
            },
            widget: Padding(
                padding: EdgeInsets.all(5),
                child: Image.asset(
                  Assets.add,
                  height: 20,
                ))),
        context: context);
  }

  chatUser() async {
    await APIRepository.chatUserList(context).then((value) {
      if (value != null) {
        chatuser = value;
        userList = chatuser.list;
      }
    }).onError((error, stackTrace) {
      HelperWidget.toast(error.toString());
    });
  }

  paginateData() {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        pagecount++;

        if (pagecount < chatuser.mMeta.pageCount) {
          if (mounted)
            setState(() {
              loadPginateData = true;
            });
          await APIRepository.chatUserList(context).then((value) {
            if (value != null) {
              if (mounted)
                setState(() {
                  chatuser = value;
                  userList.addAll(chatuser.list);
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
}
