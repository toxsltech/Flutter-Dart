
/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited
 */

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../export.dart';

var log = Logger();
GetStorage storage = GetStorage();
TextTheme textTheme = Theme.of(Get.context!).textTheme;
var tempDir;

class GlobalVariable {
  static final GlobalKey<ScaffoldMessengerState> navState = GlobalKey<ScaffoldMessengerState>();

  static final GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();
}



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  tempDir = await getTemporaryDirectory();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: COLOR_lightGray,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: ScreenUtilInit(
       builder: (context,widget)=>GetMaterialApp(
         theme: themeData,
         initialBinding: InitialBinding(),
         scaffoldMessengerKey: GlobalVariable.navState,
         debugShowCheckedModeBanner: false,
         home: SplashScreen(),
         enableLog: true,
         logWriterCallback: LoggerX.write,
         builder: EasyLoading.init(),
         defaultTransition: Transition.cupertino,
         // textDirection: TextDirection.ltr,
       ),
      ),
    );
  }
}
