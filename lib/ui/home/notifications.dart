// Project imports:
import 'package:alanis/export.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  NotificationListModal notificationListModal = NotificationListModal();
  ScrollController _scrollController = ScrollController();
  int pagecount;
  List<NotificationData> list = [];
  bool loadPginateData = false;
  Future _future;

  notifiactionList() async {
    await APIRepository.notificationApi(context: context, page: pagecount)
        .then((value) {
      if (value != null) {
        if (mounted) {
          notificationListModal = value;
          if (pagecount == 0) {
            list = notificationListModal.list;
          } else {
            list.addAll(notificationListModal.list);
          }
        }
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

        if (pagecount < notificationListModal.mMeta.pageCount) {
          if (mounted)
            setState(() {
              loadPginateData = true;
            });
          await APIRepository.notificationApi(context: context, page: pagecount)
              .then((value) {
            notificationListModal = value;
            if (mounted)
              setState(() {
                list.addAll(notificationListModal.list);
                loadPginateData = false;
              });
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
    pagecount = 0;
    _future = notifiactionList();
    paginateData();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      notifiactionList();
      setState(() {});
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      notifiactionList();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        HelperUtility.pushAndRemoveUntil(
            context: context, route: BottomNavigationScreen((0)));
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.textNotification,
            style:
                HelperUtility.textStyleBold(color: Colors.white, fontsize: 16),
          ),
          centerTitle: true,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              HelperUtility.pushAndRemoveUntil(
                  context: context, route: BottomNavigationScreen((0)));
            },
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration(milliseconds: 500), () {
              setState(() {
                pagecount = 0;
                notifiactionList();
              });
            });
          },
          color: primaryColor,
          child: notificationList(),
        ),
      ),
    );
  }

  Widget notificationList() {
    return FutureBuilder(
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
                return notificationListModal?.list != null &&
                        notificationListModal?.list?.length != 0
                    ? SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        controller: _scrollController,
                        child: Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 10.0,
                                  child: Divider(),
                                );
                              },
                              itemBuilder: (context, index) {
                                var item = list[index];
                                return ListTile(
                                  onTap: () {
                                    if (list[index].action == "comment")
                                      HelperUtility.pushNamed(
                                        context: context,
                                        route: Routes.postdetails,
                                        arguments: {
                                          "modelID": list[index].modelId,
                                          'home': 'notification',
                                        },
                                      );
                                    else if (list[index].action == "like") {
                                      HelperUtility.pushNamed(
                                        context: context,
                                        route: Routes.postdetails,
                                        arguments: {
                                          "modelID": list[index].modelId,
                                          'home': 'notification',
                                        },
                                      );
                                    } else if (list[index].action ==
                                        "accept-follow-request")
                                      HelperUtility.pushNamed(
                                          context: context,
                                          route: Routes.professionalDetail,
                                          arguments: {
                                            'arg': list[index].createdById,
                                            'home': 'notification'
                                          });
                                    else if (list[index].action == "follow")
                                      HelperUtility.push(
                                          context: context,
                                          route:
                                              RequestPage(notification: true));
                                    else if (list[index].action == "send")
                                      HelperUtility.pushNamed(
                                          context: context,
                                          route: Routes.chatscreen,
                                          arguments: {
                                            "arg": list[index].createdById
                                          });
                                  },
                                  leading: Icon(
                                    Icons.notifications,
                                    color: primaryColor,
                                    size: 35,
                                  ),
                                  title: Text(
                                    sentenceCase(item.title),
                                    style:
                                        HelperUtility.textStyle(fontsize: 16),
                                  ),
                                  trailing: Text(
                                    whatTime(list[index].createdOn),
                                    style: HelperUtility.textStyle(
                                        color: Colors.grey, fontsize: 13),
                                  ),
                                );
                              },
                              itemCount: list.length,
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
}
