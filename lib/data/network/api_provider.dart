// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:alanis/export.dart';
import 'package:alanis/model/response_model/coverphoto_model.dart';
import 'package:alanis/model/response_model/postdetail.dart';

class APIRepository {
  static DioClient dioClient;

  APIRepository() {
    var dio = Dio();
    dioClient = DioClient(baseUrl, dio);
  }

  /*===================================================================== login API Call  ==========================================================*/
  static Future loginApiCall(
      Map<String, dynamic> dataBody, BuildContext context) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(loginEndPoint, data: formData);
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  static Future socialApiCall(
      Map<String, dynamic> dataBody, BuildContext context) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response =
          await dioClient.post(socialLoginEndPoint, data: formData);
      return LoginResponseModel.fromJson(response);
    } on DioError catch (e) {
      StatusCode.getDioException(e, context);
      return null;
    }
  }

  /*===================================================================== register API Call  ==========================================================*/
  static Future registerApiCall(
      Map<String, dynamic> dataBody, BuildContext context) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(registerEndPoint, data: formData);
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== forgot password  Call  =======================================================*/
  static Future forgotApiCall(
      Map<String, dynamic> dataBody, BuildContext context) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response =
          await dioClient.post(resetPasswordEndPoint, data: formData);

      return ForgotPasswordResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== logout API Call  ==========================================================*/
  static Future logoutApiCall(BuildContext context) async {
    try {
      final response = await dioClient.post(userLogout,
          queryParameters: {'access-token': await PrefManger.getAcessToken()});
      return LogoutResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== check user API Call  ==========================================================*/
  static Future checkuser(BuildContext context) async {
    try {
      final response = await dioClient.post(checkUser,
          queryParameters: {'access-token': await PrefManger.getAcessToken()});
      return CheckUserModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== chat user list API Call  ==========================================================*/
  static Future chatUserList(BuildContext context) async {
    try {
      final response = await dioClient.post(chatuser,
          queryParameters: {'access-token': await PrefManger.getAcessToken()});
      return ChatUserModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  static Future chatLikeApiCall({Map dataBody, BuildContext context}) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(chatLike,
          data: formData,
          queryParameters: {'access-token': await PrefManger.getAcessToken()});
      return ChatLikeDataModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  static Future sendMessageApiCall(
      BuildContext context, Map<String, dynamic> requestBody) async {
    try {
      FormData formData = FormData.fromMap(requestBody);
      final response = await dioClient.post(messageSendEndPoint,
          queryParameters: {'access-token': await PrefManger.getAcessToken()},
          data: formData);
      return SendMessageResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  static Future oneToOneChatApiCall(
    BuildContext context,
    userId,
  ) async {
    try {
      final response =
          await dioClient.post(oneToOneChatEndPoint, queryParameters: {
        'access-token': await PrefManger.getAcessToken(),
        'to_user': userId,
      });
      return OneToOneChatResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  static Future staticPagesApiCall(BuildContext context, typeId) async {
    try {
      final response = await dioClient.post(staticPageEndPoint,
          queryParameters: {
            'access-token': await PrefManger.getAcessToken(),
            'type_id': typeId
          });
      return StaticPageResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== myPost API Call  ==========================================================*/
  static Future myPostApi({BuildContext context, int page}) async {
    try {
      final response = await dioClient.post(myPost, queryParameters: {
        'access-token': await PrefManger.getAcessToken(),
        'page': page
      });
      return MyPostModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== user detail API Call  ==========================================================*/
  static Future userDetail(
      Map<String, dynamic> dataBody, BuildContext context) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(user_detail,
          data: formData,
          queryParameters: {'access-token': await PrefManger.getAcessToken()});

      return UserDetailModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== user Post API Call  ==========================================================*/
  static Future userPostApi(
      {BuildContext context, int page, Map<String, dynamic> dataBody}) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(userPost,
          data: formData,
          queryParameters: {
            'access-token': await PrefManger.getAcessToken(),
            'page': page
          });
      return MyPostModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== change Password API Call  ==========================================================*/
  static Future changePassword(
      Map<String, dynamic> dataBody, BuildContext context) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(userChangePasswordEndPoint,
          data: formData,
          queryParameters: {'access-token': await PrefManger.getAcessToken()});

      return ChangePasswordResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== add Post API Call  ==========================================================*/
  static Future addPostApi(
      {Map<String, dynamic> dataBody, BuildContext context}) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(addPost,
          data: formData,
          queryParameters: {'access-token': await PrefManger.getAcessToken()});

      return AddPostModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== Follow Request API Call  ==========================================================*/
  static Future followRequest(
      {Map<String, dynamic> dataBody, BuildContext context}) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(user_follow,
          data: formData,
          queryParameters: {'access-token': await PrefManger.getAcessToken()});
      return FollowRequest.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== search  APi Call  ==========================================================*/
  static Future searchAPI(
      {Map<String, dynamic> dataBody, BuildContext context, int page}) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(user_search,
          data: formData,
          queryParameters: {
            'access-token': await PrefManger.getAcessToken(),
            'page': page
          });

      return SearchModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== search  APi Call  ==========================================================*/
  static Future searchByFieldAPI(
      {Map dataBody, BuildContext context, int page}) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(user_search_field,
          data: formData,
          queryParameters: {
            'access-token': await PrefManger.getAcessToken(),
            'page': page
          });

      return SearchModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== commentapi  ==========================================================*/

  static Future commentapi({Map dataBody, BuildContext context}) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(comment,
          data: formData,
          queryParameters: {'access-token': await PrefManger.getAcessToken()});
      return CommentDataModel.fromJson(response);
      // return response;
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== comment List api  ==========================================================*/
  static Future commentListApi({BuildContext context, id}) async {
    try {
      final response = await dioClient.get(commentlist, queryParameters: {
        'access-token': await PrefManger.getAcessToken(),
        'id': id
      });
      print("check---------------$response");
      return CommentListDataModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*=====================================================================like ==========================================================*/

  static Future likeapi({Map dataBody, BuildContext context}) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(like,
          data: formData,
          queryParameters: {'access-token': await PrefManger.getAcessToken()});
      return LikeDataModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*=====================================================================like ==========================================================*/

  static Future postDetail({Map dataBody, BuildContext context}) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(postDetailEndPoint,
          data: formData,
          queryParameters: {'access-token': await PrefManger.getAcessToken()});
      //TODO :  Change Response Model
      return PostDetail.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== Accept and Reject Request  API Call  ==========================================================*/
  static Future acceptOrReject(
      {Map<String, dynamic> dataBody, BuildContext context, int page}) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(acceptRequest,
          data: formData,
          queryParameters: {
            'access-token': await PrefManger.getAcessToken(),
            'page': page
          });
      return AcceptRejectModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== Home  APi Call  ==========================================================*/
  static Future homeapi({BuildContext context, int page}) async {
    try {
      final response = await dioClient.post(home, queryParameters: {
        'access-token': await PrefManger.getAcessToken(),
        'page': page
      });
      return HomeResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== Notification APi Call  ==========================================================*/
  static Future notificationApi({BuildContext context, int page}) async {
    try {
      final response = await dioClient.post(notification_list,
          queryParameters: {
            'access-token': await PrefManger.getAcessToken(),
            'page': page
          });

      return NotificationListModal.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== friend request list  API Call  ==========================================================*/
  static Future friendRequest(
      {Map<String, dynamic> dataBody, BuildContext context, int page}) async {
    try {
      final response = await dioClient.post(myRequest, queryParameters: {
        'access-token': await PrefManger.getAcessToken(),
        'page': page
      });

      return FriendRequest.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== update profile API Call  ==========================================================*/
  static Future updateProfile(
      Map<String, dynamic> dataBody, BuildContext context) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(user_update,
          data: formData,
          queryParameters: {'access-token': await PrefManger.getAcessToken()});
      return UpdateResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== My Follower API Call  ==========================================================*/
  static Future myFollower(BuildContext context, {page}) async {
    try {
      final response = await dioClient.post(my_follower, queryParameters: {
        'access-token': await PrefManger.getAcessToken(),
        'page': page
      });
      return MyFollower.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== My Follower APi Call  ==========================================================*/
  static Future myFollowing(BuildContext context, {page}) async {
    try {
      final response = await dioClient.post(my_following, queryParameters: {
        'access-token': await PrefManger.getAcessToken(),
        'page': page
      });
      return MyFollower.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== rising Question API Call  ==========================================================*/
  static Future risingStarQuestion(BuildContext context) async {
    try {
      final response = await dioClient.post(risingStarQuestionEndPoint,
          queryParameters: {'access-token': await PrefManger.getAcessToken()});
      return RisingStarQuestionModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== submit rising Question API Call  ==========================================================*/
  static Future submitRisingStarQuestion(
      Map<String, dynamic> dataBody, BuildContext context) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(postRisingAnswer,
          data: formData,
          queryParameters: {'access-token': await PrefManger.getAcessToken()});
      return SubmitRisingModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== submit professional Question API Call  ==========================================================*/
  static Future submitProfessionalQuestion(
      Map<String, dynamic> dataBody, BuildContext context) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(submitprofessionalQuestion,
          data: formData,
          queryParameters: {'access-token': await PrefManger.getAcessToken()});
      return SubmitProfessionalModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== update cover photo API Call  ==========================================================*/
  static Future coverPhoto(
      Map<String, dynamic> dataBody, BuildContext context) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(user_coverphoto,
          data: formData,
          queryParameters: {'access-token': await PrefManger.getAcessToken()});
      return CoverPhotoModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== contactus API Call  ==========================================================*/
  static Future contactUs(
      Map<String, dynamic> dataBody, BuildContext context) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(contactusend,
          data: formData,
          queryParameters: {'access-token': await PrefManger.getAcessToken()});

      return ContactUsModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  /*===================================================================== Notification Setting API Call  ==========================================================*/
  static Future enableReply(
      Map<String, dynamic> dataBody, BuildContext context) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(enable_Reply,
          data: formData,
          queryParameters: {'access-token': await PrefManger.getAcessToken()});

      return NotificationSettingModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  static Future enableRequest(
      Map<String, dynamic> dataBody, BuildContext context) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(enable_Request,
          data: formData,
          queryParameters: {'access-token': await PrefManger.getAcessToken()});
      debugPrint("request: $response");
      return NotificationSettingModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }

  static Future enableLikePost(
      Map<String, dynamic> dataBody, BuildContext context) async {
    try {
      FormData formData = FormData.fromMap(dataBody);
      final response = await dioClient.post(enable_LikePost,
          data: formData,
          queryParameters: {'access-token': await PrefManger.getAcessToken()});

      return NotificationSettingModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e, context));
    }
  }
}
