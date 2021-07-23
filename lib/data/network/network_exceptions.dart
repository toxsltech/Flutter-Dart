// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:alanis/export.dart';

class NetworkExceptions {
  static String messageData = "";

  static getDioException(error, context) {
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              return messageData = Strings.REQUEST_CANCELLED;
              break;
            case DioErrorType.connectTimeout:
              return messageData = Strings.CONNECTION_TIMEOUT;
              break;
            case DioErrorType.other:
              List<String> dateParts = error.message.split(":");
              List<String> message = dateParts[2].split(",");

              if (message[0].trim() == Strings.connectionRefused) {
                return messageData = Strings.serverMaintance;
              } else if (message[0].trim() == Strings.networkUnreachable) {
                return messageData = Strings.networkUnreachable;
              } else if (dateParts[1].trim() == Strings.falidTOConnect) {
                return messageData = Strings.INTERNET_CONNECTION;
              } else {
                return messageData = dateParts[1];
              }
              break;
            case DioErrorType.receiveTimeout:
              return messageData = Strings.TIME_OUT;
              break;
            case DioErrorType.response:
              switch (error.response.statusCode) {
                case 400:
                  Map<String, dynamic> data = error.response.data;

                  if (data.values.elementAt(0).runtimeType == String) {
                    return messageData = data.values.elementAt(0);
                  } else {
                    Map<String, dynamic> datas = data.values.elementAt(0);
                    if (data.values.elementAt(0) == null) {
                      var dataValue = ErrorMessageResponseModel.fromJson(
                              error.response.data)
                          .message;
                      if (dataValue == null) {
                        return messageData = dataValue;
                      } else {
                        return messageData = Strings.UNAUTH_REQUEST;
                      }
                    } else {
                      return messageData = datas.values.first[0];
                    }
                  }

                  break;
                case 401:
                  PrefManger.saveRegisterData(null);
                  HelperUtility.pushAndRemoveUntil(
                      route: LoginScreen(), context: context);
                  Map<String, dynamic> data = error.response.data;

                  if (data.values.elementAt(0).runtimeType == String) {
                    if (data.values.elementAt(0) == "Unauthorized") {
                      return messageData = "Session expired";
                    } else {
                      return messageData = data.values.elementAt(0);
                    }
                  } else {
                    Map<String, dynamic> datas = data.values.elementAt(0);
                    if (data.values.elementAt(0) == null) {
                      var dataValue = ErrorMessageResponseModel.fromJson(
                              error.response.data)
                          .message;
                      if (dataValue == null) {
                        return messageData = dataValue;
                      } else {
                        return messageData = Strings.UNAUTH_REQUEST;
                      }
                    } else {
                      return messageData = datas.values.first[0];
                    }
                  }
                  break;
                case 403:
                  PrefManger.saveRegisterData(null);
                  HelperUtility.pushAndRemoveUntil(
                      route: LoginScreen(), context: context);
                  Map<String, dynamic> data = error.response.data;
                  if (data.values.elementAt(0).runtimeType == String) {
                    return messageData = data.values.elementAt(0);
                  } else {
                    Map<String, dynamic> datas = data.values.elementAt(0);
                    if (data.values.elementAt(0) == null) {
                      var dataValue = ErrorMessageResponseModel.fromJson(
                              error.response.data)
                          .message;
                      if (dataValue == null) {
                        return messageData = dataValue;
                      } else {
                        return messageData = Strings.UNAUTH_REQUEST;
                      }
                    } else {
                      return messageData = datas.values.first[0];
                    }
                  }

                  break;
                case 404:
                  return messageData = Strings.NOT_FOUND;
                  break;
                case 408:
                  return messageData = Strings.REQUEST_TIME_OUT;
                  break;
                case 500:
                  return messageData = Strings.INTERNAL_SERVER_ERROR;
                  break;
                case 503:
                  return messageData = Strings.INTERNET_SERVICE_UNAVAIL;
                  break;
                default:
                  return messageData = Strings.SOMETHINGS_IS_WRONG;
              }
              break;
            case DioErrorType.sendTimeout:
              return messageData = Strings.TIME_OUT;
              break;
          }
        } else if (error is SocketException) {
          return messageData = Strings.SOCKET_EXCEPTIONS;
        } else {
          return messageData = Strings.UNEXPECTED_EXCEPTION;
        }
      } on FormatException catch (_) {
        return messageData = Strings.FORMAT_EXCEPTION;
      } catch (_) {
        return messageData = Strings.UNEXPECTED_EXCEPTION;
      }
    } else {
      if (error.toString().contains(Strings.notsubType)) {
        return messageData = Strings.unableToProcessData;
      } else {
        return messageData = Strings.UNEXPECTED_EXCEPTION;
      }
    }
  }
}
