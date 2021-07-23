// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:alanis/export.dart';

class StatusCode {
  static getDioException(error, context) {
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              HelperWidget.toast(Strings.REQUEST_CANCELLED);
              break;
            case DioErrorType.connectTimeout:
              HelperWidget.toast(Strings.CONNECTION_TIMEOUT);
              break;
            case DioErrorType.other:
              List<String> dateParts = error.message.split(":");
              List<String> message = dateParts[2].split(",");
              if (message[0].trim() == Strings.connectionRefused) {
                HelperWidget.toast(Strings.pleaseTryAgain);
              } else if (message[0].trim() == Strings.networkUnreachable) {
                HelperWidget.toast(Strings.INTERNET_CONNECTION);
              } else {
                HelperWidget.toast(message[0]);
              }

              break;
            case DioErrorType.receiveTimeout:
              HelperWidget.toast(Strings.TIME_OUT);
              break;
            case DioErrorType.response:
              switch (error.response.statusCode) {
                case 400:
                  Map<String, dynamic> data = error.response.data;

                  if (data.values.elementAt(0).runtimeType == String) {
                    HelperWidget.toast(data.values.elementAt(0));
                  } else {
                    Map<String, dynamic> datas = data.values.elementAt(0);
                    if (data.values.elementAt(0) == null) {
                      var dataValue = ErrorMessageResponseModel.fromJson(
                              error.response.data)
                          .message;
                      if (dataValue == null) {
                        HelperWidget.toast(dataValue);
                      } else {
                        HelperWidget.toast(Strings.UNAUTH_REQUEST);
                      }
                    } else {
                      HelperWidget.toast(datas.values.first[0]);
                    }
                  }

                  break;
                case 401:
                  PrefManger.saveRegisterData(null);
                  HelperUtility.pushAndRemoveUntil(
                      route: LoginScreen(), context: context);

                  Map<String, dynamic> data = error.response.data;

                  if (data.values.elementAt(0).runtimeType == String) {
                    HelperWidget.toast(data.values.elementAt(0));
                  } else {
                    Map<String, dynamic> datas = data.values.elementAt(0);
                    if (data.values.elementAt(0) == null) {
                      var dataValue = ErrorMessageResponseModel.fromJson(
                              error.response.data)
                          .message;
                      if (dataValue == null) {
                        HelperWidget.toast(dataValue);
                      } else {
                        HelperWidget.toast(Strings.UNAUTH_REQUEST);
                      }
                    } else {
                      HelperWidget.toast(datas.values.first[0]);
                    }
                  }
                  break;
                case 403:
                  PrefManger.saveRegisterData(null);
                  HelperUtility.pushAndRemoveUntil(
                      route: LoginScreen(), context: context);
                  Map<String, dynamic> data = error.response.data;
                  if (data.values.elementAt(0).runtimeType == String) {
                    HelperWidget.toast(data.values.elementAt(0));
                  } else {
                    Map<String, dynamic> datas = data.values.elementAt(0);
                    if (data.values.elementAt(0) == null) {
                      var dataValue = ErrorMessageResponseModel.fromJson(
                              error.response.data)
                          .message;
                      if (dataValue == null) {
                        HelperWidget.toast(dataValue);
                      } else {
                        HelperWidget.toast(Strings.UNAUTH_REQUEST);
                      }
                    } else {
                      HelperWidget.toast(datas.values.first[0]);
                    }
                  }
                  break;
                case 404:
                  HelperWidget.toast(Strings.NOT_FOUND);
                  break;
                case 408:
                  HelperWidget.toast(Strings.REQUEST_TIME_OUT);
                  break;
                case 500:
                  HelperWidget.toast(Strings.INTERNAL_SERVER_ERROR);
                  break;
                case 503:
                  HelperWidget.toast(Strings.INTERNET_SERVICE_UNAVAIL);
                  break;
                default:
                  HelperWidget.toast(Strings.SOMETHINGS_IS_WRONG);
              }
              break;
            case DioErrorType.sendTimeout:
              HelperWidget.toast(Strings.TIME_OUT);
              break;
          }
        } else if (error is SocketException) {
          HelperWidget.toast(Strings.SOCKET_EXCEPTIONS);
        } else {
          HelperWidget.toast(Strings.UNEXPECTED_EXCEPTION);
        }
      } on FormatException catch (_) {
        HelperWidget.toast(Strings.FORMAT_EXCEPTION);
      } catch (_) {
        HelperWidget.toast(Strings.UNEXPECTED_EXCEPTION);
      }
    }
  }
}
