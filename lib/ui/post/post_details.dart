// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:video_player/video_player.dart';

// Project imports:
import 'package:alanis/model/response_model/postdetail.dart';
import '../../export.dart';

class PostDetails extends StatefulWidget {
  final Map<dynamic, dynamic> arguments;

  PostDetails(
    this.arguments,
  );

  @override
  _PostDetailsState createState() => _PostDetailsState(arguments);
}

class _PostDetailsState extends State<PostDetails> {
  final Map arguments;
  PostDetail postDetailModel;
  PostShortDetail postModel;

  var fileType;
  var argID;
  bool hasData = false;

  _PostDetailsState(this.arguments);

  CommentListDataModel _commentListDataModel = new CommentListDataModel();

  bool showVol = false;
  bool isPlaying = false;
  bool _isloading = true;
  final ScrollController _scrollController = ScrollController();
  CustomLoader _customLoader = CustomLoader();
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    argID = arguments['argID'];
    postDetailModel = PostDetail();
    fileTypeCheck();
    postDetail(arguments['modelID']);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['action'] == "comment" ||
          message.data['action'] ==
              "like") if (jsonDecode(message.data['detail'])['model_id'] ==
          arguments['modelID']) postDetail(arguments['modelID']);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data['action'] == "comment" ||
          message.data['action'] ==
              "like") if (jsonDecode(message.data['detail'])['model_id'] ==
          arguments['modelID']) postDetail(arguments['modelID']);
    });
  }

  void playVideo(url) {
    controller = VideoPlayerController.network(url,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: false));
    controller.initialize().then((_) {
      if (mounted) setState(() {});
      controller.play();
    });
  }

  void commentListApiCall(val) async {
    await APIRepository.commentListApi(context: context, id: val).then((value) {
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
    }).onError((error, stackTrace) {});
  }

  void postDetail(val) async {
    var response = AuthRequestModel.postDetail(
      id: val,
    );
    await APIRepository.postDetail(dataBody: response, context: context)
        .then((value) {
      if (value != null) {
        postDetailModel = value;
        postModel = postDetailModel.detail;
        hasData = true;
        commentListApiCall(val);
        if (mounted) setState(() {});
        if (postModel?.typeId == TYPE_VIDEO)
          playVideo(imageUrl + postModel?.file?.key);
      }
    }).onError((error, stackTrace) {
      HelperWidget.toast(error);
    });
  }

  void fileTypeCheck() {
    if (postModel?.file != null) {
      switch (postModel.typeId) {
        case TYPE_AUDIO:
          break;
        case TYPE_IMAGE:
          break;
        case TYPE_VIDEO:
          break;
      }
    } else {
      print("else working");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: _appBar(),
        body: hasData == true
            ? postDetailModel == null || postModel == null
                ? Center(
                    child: Container(
                    child: Text("No Data Found"),
                  ))
                : _body()
            : Center(
                child: CircularProgressIndicator(
                color: primaryColor,
                backgroundColor: Colors.white,
              )),
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
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavigationScreen(2),
          ));
      return Future.value(true);
    } else if (widget.arguments['home'] == 'detail') {
      HelperUtility.pushReplacementNamed(
          context: context,
          route: Routes.professionalDetail,
          arguments: {'arg': argID, 'home': 'home'});
      return Future.value(true);
    } else {
      Navigator.pop(context);
      return Future.value(true);
    }
  }

  Widget _appBar() {
    return AppBar(
        title: Text(
          Strings.postdetails,
          style: HelperUtility.textStyleBold(color: Colors.white, fontsize: 16),
        ),
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
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
              HelperUtility.pushReplacementNamed(
                  context: context,
                  route: Routes.professionalDetail,
                  arguments: {'arg': argID, 'home': 'home'});
            else
              Navigator.pop(context);
          },
        ));
  }

  Widget _body() {
    return SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HelperWidget.sizeBox(height: 10),
            _currentUserRow(),
            postModel?.typeId == 1 || postModel?.typeId == 0
                ? postedText()
                : postModel?.typeId == 2
                    ? postedImage()
                    : postedVideo(),
            _commentsSection(),
            _commentList(),
          ],
        ));
  }

  Widget _commentList() {
    return _isloading != true
        ? Column(
            children: [
              _commentListDataModel.list.isEmpty
                  ? Center(
                      child: Text(no_comment),
                    )
                  : commentsList(),
            ],
          )
        : Center(
            child: CircularProgressIndicator(
            color: primaryColor,
            backgroundColor: Colors.white,
          ));
  }

  Padding _currentUserRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: HelperUtility.cachedImage(
                  imageUrl + postModel?.createdBy?.profileFile,
                  hash: (blurhashes.toList()..shuffle()).first,
                  height: 30,
                  width: 30),
            ),
          ),
          HelperWidget.sizeBox(width: 10),
          Text(postModel?.createdBy?.fullName ?? "",
              style: HelperUtility.textStyleBold(
                  fontsize: 16, color: Colors.black)),
          SizedBox(width: 5),
          if (int.parse(postModel?.createdBy?.countPost ?? "0") > 14)
            postModel?.createdBy?.roleId == ROLE_PROFESSIONAL
                ? Image.asset(
                    getProfessionalBadge(postModel?.createdBy?.countPost) ?? "",
                    height: 15,
                    width: 15,
                    fit: BoxFit.fill,
                  )
                : Image.asset(
                    getRisingBadge(postModel?.createdBy?.countPost) ?? "",
                    height: 15,
                    width: 15,
                    fit: BoxFit.fill,
                  ),
          SizedBox(width: 5),
        ],
      ),
    );
  }

  Widget postedImage() {
    return postModel?.file == null
        ? Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: MediaQuery.of(context).size.height * 0.3,
            width: HelperUtility.fullWidthScreen(context: context),
            child: Center(child: Text(no_data)))
        : Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: MediaQuery.of(context).size.height * 0.3,
            width: HelperUtility.fullWidthScreen(context: context),
            child: CachedNetworkImage(
                imageUrl: imageUrl + "${postModel?.file?.key}",
                fit: profileContain,
                errorWidget: (context, url, error) => Icon(Icons.error),
                placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: shimmerbaseColor,
                      highlightColor: shimmerhighlightColor,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: HelperUtility.fullWidthScreen(context: context),
                      ),
                    )));
  }

  Widget postedVideo() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: MediaQuery.of(context).size.height * 0.3,
        width: HelperUtility.fullWidthScreen(context: context),
        child: postModel?.file?.key == null
            ? Container()
            : controller.value != null && controller.value.isInitialized
                ? GestureDetector(
                    child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: SizedBox(
                          child: VideoPlayer(controller),
                          width: controller.value.size?.width ?? 0,
                          height: controller.value.size?.height ?? 0,
                        )),
                    onTap: () {
                      controller.value.isPlaying
                          ? controller.pause()
                          : controller.play();
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                      backgroundColor: Colors.white,
                    ),
                  ));
  }

  Widget postedText() {
    return postModel.description != null
        ? Padding(
            padding: const EdgeInsets.all(22.0),
            child: Text(postModel.description),
          )
        : Strings.nodataFound;
  }

  Widget _commentsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  final likeIndex = "${postModel.id}";
                  if (mounted)
                    setState(() {
                      if (postModel.checkLike == false) {
                        postModel.checkLike = true;
                        postModel.likes = postModel.likes - 1;
                      } else {
                        postModel.checkLike = false;
                        postModel.likes = postModel.likes + 1;
                      }
                    });

                  likeApiCall(likeIndex);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      postModel?.checkLike == true
                          ? Icons.star_border
                          : Icons.star,
                      color: Colors.black87,
                    ),
                    Text(" ${postModel?.likes}",
                        style: HelperUtility.textStyle(
                            color: Colors.black87, fontsize: 13.0)),
                  ],
                ),
              ),
              HelperWidget.sizeBox(width: 20),
              InkWell(
                onTap: () async {
                  await HelperUtility.pushReplacementNamed(
                      context: context,
                      route: Routes.commentscreen,
                      arguments: {
                        "modelID": widget.arguments['modelID'],
                        'home': 'post'
                      });
                },
                child: Image.asset(
                  Assets.comments,
                  height: 15,
                  color: Colors.black87,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(" ${postModel?.comments ?? "0"}",
                  style: HelperUtility.textStyle(
                      color: Colors.black87, fontsize: 13.0)),
            ],
          ),
        ],
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
                    "${imageUrl + _commentListDataModel?.list[index]?.createdBy?.profileFile ?? ""}",
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
                    "${_commentListDataModel.list[index].comment}",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    whatTime(_commentListDataModel.list[index].createdOn),
                    style: TextStyle(fontSize: 10),
                  ),
                  HelperWidget.sizeBox(width: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      itemCount: _commentListDataModel.list.length == null
          ? 0
          : _commentListDataModel.list.length,
    );
  }

  void likeApiCall(val) async {
    var response = AuthRequestModel.likeRequestData(
      id: val,
    );
    await APIRepository.likeapi(dataBody: response, context: context)
        .then((value) {
      if (value != null) {
        if (mounted) setState(() {});
      }
    }).onError((error, stackTrace) {
      _customLoader.hide();
      if (error.toString() != Strings.unableToProcessData)
      HelperWidget.toast(error);
    });
  }

  @override
  void dispose() {
    if (mounted && controller != null) controller.dispose();
    super.dispose();
  }
}
