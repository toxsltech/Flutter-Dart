class ChatRequestModel {
  static messageSendRequestBody({var userId, var message}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Chat[to_id]'] = userId;
    data['Chat[message]'] = message;
    return data;
  }
}
