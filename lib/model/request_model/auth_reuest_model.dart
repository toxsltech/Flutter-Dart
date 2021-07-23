// Project imports:
import 'package:alanis/export.dart';

class AuthRequestModel {
  static loginRequestData(
      {String email,
      String password,
      String deviceToken,
      String deviceType,
      String deviceName}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LoginForm[username]'] = email;
    data['LoginForm[password]'] = password;
    data['LoginForm[device_token]'] = deviceToken;
    data['LoginForm[device_type]'] = deviceType;
    data['LoginForm[device_name]'] = deviceName;
    return data;
  }

  static acceptOrReject({state, id}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_id'] = state;
    data['id'] = id;
    return data;
  }

  static registerRequestData(
      {String email,
      String name,
      String passwrod,
      int roleId,
      String deviceToken,
      String deviceType,
      String deviceName}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User[email]'] = email;
    data['User[password]'] = passwrod;
    data['User[confirm_password]'] = passwrod;
    data['User[full_name]'] = name;
    data['User[role_id]'] = roleId;
    data['AccessToken[device_token]'] = deviceToken ?? " ";
    data['AccessToken[device_type]'] = deviceType ?? " ";
    data['AccessToken[device_name]'] = deviceName ?? " ";
    return data;
  }

  static searchRequestData({String search}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = search;
    return data;
  }

  static searchByFieldDataRequest({field}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field'] = field;
    return data;
  }

  static postRequestData({String title, var file, String description}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Post[title]'] = title;
    data['File[key]'] = file;
    data['Post[description]'] = description;
    return data;
  }

  static submitProfessionalJson(
      {String title, String companyName, int field, String otherDetail}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RisingDetail[title]'] = title;
    data['RisingDetail[company_name]'] = companyName;
    data['RisingDetail[field]'] = field;
    data['RisingDetail[other_detail]'] = otherDetail;
    return data;
  }

  static submitRisingStarJson({var answer}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ansJson'] = jsonEncode(answer);
    data['Answer[state_id]'] = 1;
    return data;
  }

  static searchData({String search}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = search;
    return data;
  }

  static addPost(
      {String title, var file, String tagId, int typeId, String description}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Post[title]'] = title;
    data['Post[tag_id]'] = tagId;
    data['Post[type_id]'] = typeId;
    if (file != null) {
      data['File[key]'] = file;
    }
    data['Post[description]'] = description;
    return data;
  }

  static updateCover({var file}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (file != null) {
      data['User[cover_profile]'] = file;
    }
    return data;
  }

  static forgotPasswordDataRequest({
    String firstName,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User[email]'] = firstName;
    return data;
  }

  static followRequest({var modelId, var typeId}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Follower[model_id]'] = modelId;
    if (typeId != null) {
      data['type_id'] = typeId;
    }
    return data;
  }

  static updateProfileQueryParms({int userId, String accessToken}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = userId;
    data['access-token'] = accessToken;
    return json.encode(data);
  }

  static userDetailParam({int id}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    return data;
  }

  static userPostbyId({int id}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    return data;
  }

  static postDetail({int id}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    return data;
  }

  static editProfileComplete(
      {String firstName,
      String lastName,
      String email,
      String contact,
      double latitude,
      double longitude,
      String me,
      String address,
      image,
      idProff}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User[first_name]'] = firstName;
    data['User[last_name]'] = lastName;
    data['User[email]'] = email;
    data['User[contact_no]'] = contact;
    data['User[Latitude]'] = latitude;
    data['User[Longitude]'] = longitude;
    data['User[about_me]'] = me;
    data['User[address]'] = address;
    if (image != null) {
      data['User[profile_file]'] = image;
    }
    if (idProff != null) {
      data['User[id_proof_document]'] = idProff;
    }
    return data;
  }

  static changePassword({String changePassword, String confirmPassword}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User[password]'] = changePassword;
    data['User[confirm_password]'] = confirmPassword;
    return data;
  }

  static updateRequestData(
      {String fullName,
      String contactNo,
      String dateOfBirth,
      String aboutMe,
      String country,
      var fileUrl}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User[date_of_birth]'] = dateOfBirth;
    data['User[contact_no]'] = contactNo;
    data['User[full_name]'] = fullName;
    if (fileUrl != null) {
      data['User[profile_file]'] = fileUrl;
    }
    data['User[short_description]'] = aboutMe;
    data['User[country]'] = country;
    return data;
  }

  static commentsRequestData({int id, String comment}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Comment[model_id]'] = id;
    data['Comment[comment]'] = comment;
    return data;
  }

  static likeRequestData({String id}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Like[model_id]'] = id;
    return data;
  }

  static chatLikeRequestData({String chatId, String modelId}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Like[chat_id]'] = chatId;
    data['Like[model_id]'] = modelId;
    return data;
  }

  static contactus({
    String email,
    String subject,
    String description,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Information[email]'] = email;
    data['Information[subject]'] = subject;
    data['Information[description]'] = description;
    return data;
  }

  static socialLoginRequestData(
      {String fullName,
      String userId,
      String provider,
      String email,
      int roleID,
      String deviceToken,
      int deviceType,
      String deviceName}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User[full_name]'] = fullName;
    data['User[role_id]'] = roleID;
    data['User[userId]'] = userId;
    data['User[provider]'] = provider;
    data['User[email]'] = email;
    data['LoginForm[device_token]'] = deviceToken;
    data['LoginForm[device_type]'] = deviceType;
    data['LoginForm[device_name]'] = deviceName;
    return data;
  }

  static enableReply({isReply}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_reply'] = isReply;
    return data;
  }

  static enableRequest({isFollow}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_follow'] = isFollow;
    return data;
  }

  static enableLikePost({isPost}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_post'] = isPost;
    return data;
  }
}
