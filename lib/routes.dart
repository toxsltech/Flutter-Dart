/*
 *  @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 *  @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 *  the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

// Project imports:
import 'package:alanis/export.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgotPassword';
  static const String profileSetUp = '/profileSetUp';
  static const String home = '/home';
  static const String messagepage = '/messagepage';
  static const String addpost = '/addpost';
  static const String proffesional = '/proffesional';
  static const String settings = '/settings';
  static const String postdetails = '/postdetails';
  static const String commentscreen = '/commentscreen';
  static const String chatscreen = '/chatscreen';
  static const String professionalDetail = '/professionalDetail';

  /*================================================================== All App Routes added here ===================================================*/

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    signup: (BuildContext context) => SignUpPage(),
    forgotPassword: (BuildContext context) => ForgotPassword(),
    profileSetUp: (BuildContext context) => ProfileSetUp(),
    home: (BuildContext context) => Home(),
    messagepage: (BuildContext context) => MessagesPage(),
    addpost: (BuildContext context) => AddPost(),
    proffesional: (BuildContext context) => Network(),
    settings: (BuildContext context) => Settings(),
    postdetails: (BuildContext context) =>
        PostDetails(ModalRoute.of(context).settings.arguments as Map),
    commentscreen: (BuildContext context) =>
        CommentsScreen(ModalRoute.of(context).settings.arguments as Map),
    chatscreen: (BuildContext context) =>
        ChatScreen(ModalRoute.of(context).settings.arguments as Map),
    professionalDetail: (BuildContext context) =>
        ProfessionalDetail(ModalRoute.of(context).settings.arguments as Map),
  };
}
